import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../domain/models/pronunciation_session.dart';
import '../../../../core/errors/failures.dart';

abstract class PronunciationRemoteDataSource {
  /// Upload audio recording for evaluation
  Future<String> uploadAudio({
    required String audioPath,
    required String sessionId,
    required String lessonId,
  });

  /// Get evaluation result for a session
  Future<PronunciationEvaluationResult> getEvaluationResult(
    String sessionId,
  );

  /// Get pronunciation history from server
  Future<List<PronunciationEvaluationResult>> getHistory({
    int limit = 20,
    int offset = 0,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Delete a pronunciation session from server
  Future<void> deleteSession(String sessionId);

  /// Get pronunciation statistics from server
  Future<Map<String, dynamic>> getStatistics();

  /// Upload queued audio files
  Future<void> processQueuedUploads(List<Map<String, dynamic>> queuedUploads);

  /// Connect to real-time scoring WebSocket
  Stream<Map<String, dynamic>> connectRealTimeScoring(String sessionId);
  
  /// Get AI-powered feedback and recommendations
  Future<Map<String, dynamic>> getPersonalizedFeedback(String userId, String sessionId);
  
  /// Get learning path optimization
  Future<Map<String, dynamic>> getLearningPathRecommendations(String userId);
  
  /// Real-time phoneme analysis
  Stream<List<Map<String, dynamic>>> streamPhonemeAnalysis(String sessionId);
}

class PronunciationRemoteDataSourceImpl implements PronunciationRemoteDataSource {
  final Dio dio;
  final String baseUrl;
  final Logger logger;

  PronunciationRemoteDataSourceImpl({
    required this.dio,
    required this.baseUrl,
    required this.logger,
  });

  @override
  Future<String> uploadAudio({
    required String audioPath,
    required String sessionId,
    required String lessonId,
  }) async {
    try {
      final file = File(audioPath);
      if (!file.existsSync()) {
        throw const FileSystemFailure('Audio file not found');
      }

      final fileSize = await file.length();
      const maxFileSize = 10 * 1024 * 1024; // 10MB
      if (fileSize > maxFileSize) {
        throw const FileSystemFailure('Audio file is too large');
      }

      final formData = FormData.fromMap({
        'audio': await MultipartFile.fromFile(audioPath, filename: 'recording.wav'),
        'sessionId': sessionId,
        'lessonId': lessonId,
      });

      final response = await dio.post<Map<String, dynamic>>(
        '$baseUrl/api/pronunciation/upload',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        final uploadUrl = response.data?['uploadUrl']?.toString() ?? '';
        if (uploadUrl.isEmpty) {
          throw const ServerFailure('Invalid response from server');
        }
        return uploadUrl;
      } else {
        throw ServerFailure('Upload failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      logger.e('Dio error during upload: $e');
      
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const TimeoutFailure('Request timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw const NetworkFailure('No internet connection');
      } else if (e.response?.statusCode == 401) {
        throw const AuthenticationFailure('Unauthorized');
      } else if (e.response?.statusCode == 403) {
        throw const PermissionFailure('Access forbidden');
      } else if (e.response?.statusCode == 413) {
        throw const FileSystemFailure('File too large');
      } else {
        throw ServerFailure(e.response?.data?['message']?.toString() ?? 'Upload failed');
      }
    } catch (e) {
      logger.e('Unexpected error during upload: $e');
      if (e is Failure) rethrow;
      throw UnexpectedFailure('Upload failed: $e');
    }
  }

  @override
  Future<PronunciationEvaluationResult> getEvaluationResult(
    String sessionId,
  ) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        '$baseUrl/api/pronunciation/evaluation/$sessionId',
      );

      if (response.statusCode == 200 && response.data != null) {
        return _mapToEvaluationResult(response.data!);
      } else if (response.statusCode == 404) {
        throw const NotFoundFailure('Evaluation result not found');
      } else {
        throw const ServerFailure('Failed to get evaluation result');
      }
    } on DioException catch (e) {
      logger.e('Dio error getting evaluation result: $e');
      
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const TimeoutFailure('Request timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw const NetworkFailure('No internet connection');
      } else if (e.response?.statusCode == 404) {
        throw const NotFoundFailure('Evaluation not ready yet');
      } else {
        throw ServerFailure(e.response?.data?['message']?.toString() ?? 'Failed to get evaluation result');
      }
    } catch (e) {
      logger.e('Unexpected error getting evaluation result: $e');
      if (e is Failure) rethrow;
      throw UnexpectedFailure('Failed to get evaluation result: $e');
    }
  }

  @override
  Future<List<PronunciationEvaluationResult>> getHistory({
    int limit = 20,
    int offset = 0,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'limit': limit,
        'offset': offset,
      };

      if (startDate != null) {
        queryParams['startDate'] = startDate.toIso8601String();
      }
      if (endDate != null) {
        queryParams['endDate'] = endDate.toIso8601String();
      }

      final response = await dio.get<Map<String, dynamic>>(
        '$baseUrl/api/pronunciation/history',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> results = response.data!['results'] as List<dynamic>;
        return results
            .map((item) => _mapToEvaluationResult(item as Map<String, dynamic>))
            .toList();
      } else {
        throw const ServerFailure('Failed to get history');
      }
    } on DioException catch (e) {
      logger.e('Dio error getting history: $e');
      
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const TimeoutFailure('Request timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw const NetworkFailure('No internet connection');
      } else {
        throw ServerFailure(e.response?.data?['message']?.toString() ?? 'Failed to get history');
      }
    } catch (e) {
      logger.e('Unexpected error getting history: $e');
      if (e is Failure) rethrow;
      throw UnexpectedFailure('Failed to get history: $e');
    }
  }

  @override
  Future<void> deleteSession(String sessionId) async {
    try {
      final response = await dio.delete<Map<String, dynamic>>(
        '$baseUrl/api/pronunciation/session/$sessionId',
      );

      if (response.statusCode != 200) {
        throw const ServerFailure('Failed to delete session');
      }
    } on DioException catch (e) {
      logger.e('Dio error deleting session: $e');
      
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const TimeoutFailure('Request timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw const NetworkFailure('No internet connection');
      } else if (e.response?.statusCode == 404) {
        throw const NotFoundFailure('Session not found');
      } else {
        throw ServerFailure(e.response?.data?['message']?.toString() ?? 'Failed to delete session');
      }
    } catch (e) {
      logger.e('Unexpected error deleting session: $e');
      if (e is Failure) rethrow;
      throw UnexpectedFailure('Failed to delete session: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getStatistics() async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        '$baseUrl/api/pronunciation/statistics',
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data!;
      } else {
        throw const ServerFailure('Failed to get statistics');
      }
    } on DioException catch (e) {
      logger.e('Dio error getting statistics: $e');
      
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const TimeoutFailure('Request timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw const NetworkFailure('No internet connection');
      } else {
        throw ServerFailure(e.response?.data?['message']?.toString() ?? 'Failed to get statistics');
      }
    } catch (e) {
      logger.e('Unexpected error getting statistics: $e');
      if (e is Failure) rethrow;
      throw UnexpectedFailure('Failed to get statistics: $e');
    }
  }

  @override
  Future<void> processQueuedUploads(List<Map<String, dynamic>> queuedUploads) async {
    for (final upload in queuedUploads) {
      try {
        await uploadAudio(
          audioPath: upload['audioPath'] as String,
          sessionId: upload['sessionId'] as String,
          lessonId: upload['lessonId'] as String,
        );
      } catch (e) {
        logger.e('Failed to process upload ${upload['sessionId']}: $e');
      }
    }
  }

  PronunciationEvaluationResult _mapToEvaluationResult(Map<String, dynamic> data) {
    try {
      final phonemeErrors = (data['phonemeErrors'] as List<dynamic>? ?? [])
          .map((e) => PhonemeError(
                targetPhoneme: e['targetPhoneme'] as String,
                actualPhoneme: e['actualPhoneme'] as String,
                word: e['word'] as String,
                position: e['position'] as int,
                type: PhonemeErrorType.values.firstWhere(
                  (type) => type.name == e['type'],
                  orElse: () => PhonemeErrorType.substitution,
                ),
                severity: (e['severity'] as num).toDouble(),
              ))
          .toList();

      final categoryScores = Map<String, double>.from(
        data['categoryScores'] as Map<dynamic, dynamic>? ?? {},
      );

      return PronunciationEvaluationResult(
        overallScore: (data['overallScore'] as num).toDouble(),
        categoryScores: categoryScores,
        phonemeErrors: phonemeErrors,
        recordingDuration: Duration(
          milliseconds: data['recordingDuration'] as int? ?? 0,
        ),
        feedbackMessage: data['feedbackMessage'] as String? ?? '',
        improvementTips: List<String>.from(
          data['improvementTips'] as List<dynamic>? ?? [],
        ),
        evaluatedAt: DateTime.parse(data['evaluatedAt'] as String),
        sessionId: data['sessionId'] as String,
        lessonId: data['lessonId'] as String?,
      );
    } catch (e) {
      logger.e('Failed to parse evaluation result: $e');
      throw const ParsingFailure('Failed to parse evaluation result');
    }
  }

  @override
  Stream<Map<String, dynamic>> connectRealTimeScoring(String sessionId) {
    try {
      final channel = WebSocketChannel.connect(
        Uri.parse('wss://$baseUrl/ws/pronunciation/scoring/$sessionId'),
      );
      
      return channel.stream.map((dynamic message) {
        try {
          return jsonDecode(message as String) as Map<String, dynamic>;
        } catch (e) {
          logger.e('Error parsing WebSocket message: $e');
          return {'error': 'Message parsing error', 'data': message.toString()};
        }
      });
    } catch (e) {
      logger.e('Failed to connect WebSocket: $e');
      return Stream.value({
        'error': 'WebSocket connection failed',
        'message': e.toString(),
      });
    }
  }

  @override
  Future<Map<String, dynamic>> getPersonalizedFeedback(
    String userId, 
    String sessionId
  ) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '$baseUrl/api/pronunciation/feedback/personalized',
        data: {
          'userId': userId,
          'sessionId': sessionId,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data!;
      } else {
        throw const ServerFailure('Failed to get personalized feedback');
      }
    } on DioException catch (e) {
      logger.e('Dio error getting personalized feedback: $e');
      
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const TimeoutFailure('Request timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw const NetworkFailure('No internet connection');
      } else if (e.response?.statusCode == 404) {
        throw const NotFoundFailure('Feedback not found');
      } else {
        throw ServerFailure(e.response?.data?['message']?.toString() ?? 'Failed to get feedback');
      }
    } catch (e) {
      logger.e('Unexpected error getting personalized feedback: $e');
      if (e is Failure) rethrow;
      throw UnexpectedFailure('Failed to get feedback: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getLearningPathRecommendations(String userId) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        '$baseUrl/api/pronunciation/learning-path/$userId',
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data!;
      } else {
        throw const ServerFailure('Failed to get learning path recommendations');
      }
    } on DioException catch (e) {
      logger.e('Dio error getting learning path: $e');
      
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const TimeoutFailure('Request timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw const NetworkFailure('No internet connection');
      } else if (e.response?.statusCode == 404) {
        throw const NotFoundFailure('Learning path not found');
      } else {
        throw ServerFailure(e.response?.data?['message']?.toString() ?? 'Failed to get learning path');
      }
    } catch (e) {
      logger.e('Unexpected error getting learning path: $e');
      if (e is Failure) rethrow;
      throw UnexpectedFailure('Failed to get learning path: $e');
    }
  }

  Stream<Map<String, dynamic>> connectPhonemeAnalysis(String sessionId) {
    try {
      final channel = WebSocketChannel.connect(
        Uri.parse('wss://$baseUrl/ws/pronunciation/phoneme-analysis/$sessionId'),
      );
      
      return channel.stream.map((dynamic message) {
        try {
          final data = jsonDecode(message as String) as Map<String, dynamic>;
          return data;
        } catch (e) {
          logger.e('Error parsing phoneme analysis message: $e');
          return {
            'error': 'Phoneme analysis parsing error',
            'message': e.toString()
          };
        }
      });
    } catch (e) {
      logger.e('Failed to connect phoneme analysis WebSocket: $e');
      return Stream.value({
        'error': 'Phoneme analysis connection failed',
        'message': e.toString()
      });
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> streamPhonemeAnalysis(String sessionId) {
    try {
      final channel = WebSocketChannel.connect(
        Uri.parse('wss://$baseUrl/ws/pronunciation/phoneme-stream/$sessionId'),
      );
      
      return channel.stream.map((dynamic message) {
        try {
          final data = jsonDecode(message as String) as List<dynamic>;
          return List<Map<String, dynamic>>.from(
            data.cast<Map<String, dynamic>>(),
          );
        } catch (e) {
          logger.e('Error parsing phoneme stream message: $e');
          return [{
            'error': 'Phoneme stream parsing error',
            'message': e.toString()
          }];
        }
      });
    } catch (e) {
      logger.e('Failed to connect phoneme stream WebSocket: $e');
      return Stream.value([{
        'error': 'Phoneme stream connection failed',
        'message': e.toString()
      }]);
    }
  }
}
