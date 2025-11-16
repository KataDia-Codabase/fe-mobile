import 'dart:io';
import 'package:dio/dio.dart';
import '../../domain/models/pronunciation_session.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/dio_client.dart';

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
}

class PronunciationRemoteDataSourceImpl implements PronunciationRemoteDataSource {
  final DioClient dioClient;
  final String baseUrl;

  PronunciationRemoteDataSourceImpl({
    required this.dioClient,
    required this.baseUrl,
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
        throw FileException.fileNotFound();
      }

      final fileSize = await file.length();
      const maxFileSize = 10 * 1024 * 1024; // 10MB
      if (fileSize > maxFileSize) {
        throw FileException.fileTooLarge('10MB');
      }

      final formData = FormData.fromMap({
        'audio': await MultipartFile.fromFile(audioPath, filename: 'recording.wav'),
        'sessionId': sessionId,
        'lessonId': lessonId,
      });

      final response = await dioClient.post<Map<String, dynamic>>(
        '/api/pronunciation/upload',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        final uploadUrl = response.data?['uploadUrl'] as String? ?? '';
        return uploadUrl;
      } else {
        throw NetworkException.serverError(
          message: 'Upload failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException.requestTimeout();
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException.noConnection();
      } else if (e.response?.statusCode == 401) {
        throw NetworkException.unauthorized();
      } else if (e.response?.statusCode == 403) {
        throw NetworkException.forbidden();
      } else if (e.response?.statusCode == 413) {
        throw FileException.fileTooLarge('10MB');
      } else {
        throw NetworkException.serverError(
          message: _extractErrorMessage(e.response?.data),
        );
      }
    } catch (e) {
      if (e is BaseException) rethrow;
      throw NetworkException.serverError(
        message: 'Upload failed: $e',
      );
    }
  }

  @override
  Future<PronunciationEvaluationResult> getEvaluationResult(
    String sessionId,
  ) async {
    try {
      final response = await dioClient.get<Map<String, dynamic>>(
        '/api/pronunciation/evaluation/$sessionId',
      );

      if (response.statusCode == 200) {
        return _mapToEvaluationResult(response.data ?? {});
      } else if (response.statusCode == 404) {
        throw NetworkException.notFound(
          message: 'Evaluation result not found',
        );
      } else {
        throw NetworkException.serverError(
          message: 'Failed to get evaluation result',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException.requestTimeout();
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException.noConnection();
      } else if (e.response?.statusCode == 404) {
        throw NetworkException.notFound(
          message: 'Evaluation not ready yet',
        );
      } else {
        throw NetworkException.serverError(
          message: _extractErrorMessage(e.response?.data),
        );
      }
    } catch (e) {
      if (e is BaseException) rethrow;
      throw NetworkException.serverError(
        message: 'Failed to get evaluation result: $e',
      );
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

      final response = await dioClient.get<Map<String, dynamic>>(
        '/api/pronunciation/history',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data?['results'] as List<dynamic>? ?? [];
        return data.map((item) => _mapToEvaluationResult(item as Map<String, dynamic>))
            .toList();
      } else {
        throw NetworkException.serverError(
          message: 'Failed to get history',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException.requestTimeout();
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException.noConnection();
      } else {
        throw NetworkException.serverError(
          message: _extractErrorMessage(e.response?.data),
        );
      }
    } catch (e) {
      if (e is BaseException) rethrow;
      throw NetworkException.serverError(
        message: 'Failed to get history: $e',
      );
    }
  }

  @override
  Future<void> deleteSession(String sessionId) async {
    try {
      final response = await dioClient.delete<void>(
        '/api/pronunciation/session/$sessionId',
      );

      if (response.statusCode != 200) {
        throw NetworkException.serverError(
          message: 'Failed to delete session',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException.requestTimeout();
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException.noConnection();
      } else if (e.response?.statusCode == 404) {
        throw NetworkException.notFound(
          message: 'Session not found',
        );
      } else {
        throw NetworkException.serverError(
          message: _extractErrorMessage(e.response?.data),
        );
      }
    } catch (e) {
      if (e is BaseException) rethrow;
      throw NetworkException.serverError(
        message: 'Failed to delete session: $e',
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getStatistics() async {
    try {
      final response = await dioClient.get<Map<String, dynamic>>(
        '/api/pronunciation/statistics',
      );

      if (response.statusCode == 200) {
        return response.data ?? {};
      } else {
        throw NetworkException.serverError(
          message: 'Failed to get statistics',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException.requestTimeout();
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException.noConnection();
      } else {
        throw NetworkException.serverError(
          message: _extractErrorMessage(e.response?.data),
        );
      }
    } catch (e) {
      if (e is BaseException) rethrow;
      throw NetworkException.serverError(
        message: 'Failed to get statistics: $e',
      );
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
        // Log error but continue processing other uploads
        print('Failed to process upload ${upload['sessionId']}: $e');
      }
    }
  }

  PronunciationEvaluationResult _mapToEvaluationResult(Map<String, dynamic> data) {
    try {
      final phonemeErrors = (data['phonemeErrors'] as List<dynamic>? ?? [])
          .map((e) {
            final typeStr = e['type'] as String? ?? 'substitution';
            PhonemeErrorType errorType = PhonemeErrorType.substitution;
            try {
              errorType = PhonemeErrorType.values.firstWhere(
                (type) => type.name == typeStr,
                orElse: () => PhonemeErrorType.substitution,
              );
            } catch (_) {
              errorType = PhonemeErrorType.substitution;
            }
            return PhonemeError(
              targetPhoneme: e['targetPhoneme'] as String? ?? '',
              actualPhoneme: e['actualPhoneme'] as String? ?? '',
              word: e['word'] as String? ?? '',
              position: e['position'] as int? ?? 0,
              type: errorType,
              severity: (e['severity'] as num?)?.toDouble() ?? 0.0,
            );
          })
          .toList();

      final categoryScores = Map<String, double>.from(
        data['categoryScores'] as Map<dynamic, dynamic>? ?? {},
      );

      return PronunciationEvaluationResult(
        overallScore: (data['overallScore'] as num?)?.toDouble() ?? 0.0,
        categoryScores: categoryScores,
        phonemeErrors: phonemeErrors,
        recordingDuration: Duration(
          milliseconds: data['recordingDuration'] as int? ?? 0,
        ),
        feedbackMessage: data['feedbackMessage'] as String? ?? '',
        improvementTips: List<String>.from(
          data['improvementTips'] as List<dynamic>? ?? [],
        ),
        evaluatedAt: data['evaluatedAt'] != null
            ? DateTime.parse(data['evaluatedAt'] as String)
            : DateTime.now(),
        sessionId: data['sessionId'] as String? ?? '',
        lessonId: data['lessonId'] as String?,
      );
    } catch (e) {
      throw NetworkException.serverError(
        message: 'Failed to parse evaluation result: $e',
      );
    }
  }

  String _extractErrorMessage(dynamic data) {
    if (data == null) return 'Unknown error occurred';
    if (data is String) return data;
    if (data is Map && data.containsKey('message')) {
      return data['message'].toString();
    }
    return data.toString();
  }
}
