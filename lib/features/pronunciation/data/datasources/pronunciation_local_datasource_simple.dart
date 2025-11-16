import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/pronunciation_session.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';

abstract class PronunciationLocalDataSource {
  /// Cache evaluation result locally
  Future<void> saveEvaluationResult(PronunciationEvaluationResult result);

  /// Get cached evaluation result
  Future<PronunciationEvaluationResult?> getEvaluationResult(String sessionId);

  /// Get pronunciation history from local cache
  Future<List<PronunciationEvaluationResult>> getHistory({
    int limit = 20,
    int offset = 0,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Delete a session from local cache
  Future<void> deleteSession(String sessionId);

  /// Queue upload for when network is available
  Future<void> queueUpload({
    required String audioPath,
    required String sessionId,
    required String lessonId,
  });

  /// Cache upload information
  Future<void> cacheUploadInfo(String sessionId, String uploadUrl);

  /// Get queued uploads
  Future<List<Map<String, dynamic>>> getQueuedUploads();

  /// Remove queued upload
  Future<void> removeFromQueue(String sessionId);

  /// Save statistics locally
  Future<void> saveStatistics(Map<String, dynamic> stats);

  /// Get local statistics
  Future<Map<String, dynamic>> getStatistics();

  /// Check microphone permission status
  Future<bool> hasMicrophonePermission();

  /// Request microphone permission
  Future<bool> requestMicrophonePermission();

  /// Clean old recordings
  Future<void> cleanupOldRecordings({Duration maxAge = const Duration(days: 7)});
}

class PronunciationLocalDataSourceImpl implements PronunciationLocalDataSource {
  final SharedPreferences _prefs;

  static const String _evaluationPrefix = 'evaluation_';
  static const String _statisticsKey = 'pronunciation_stats';
  static const String _uploadQueueKey = 'upload_queue';

  PronunciationLocalDataSourceImpl({
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  // Helper methods for JSON serialization
  Map<String, dynamic> _resultToJson(PronunciationEvaluationResult result) {
    return {
      'overallScore': result.overallScore,
      'categoryScores': result.categoryScores,
      'phonemeErrors': result.phonemeErrors.map((e) => {
        'targetPhoneme': e.targetPhoneme,
        'actualPhoneme': e.actualPhoneme,
        'word': e.word,
        'position': e.position,
        'type': e.type.name,
        'severity': e.severity,
      }).toList(),
      'recordingDuration': result.recordingDuration.inMilliseconds,
      'feedbackMessage': result.feedbackMessage,
      'improvementTips': result.improvementTips,
      'evaluatedAt': result.evaluatedAt.toIso8601String(),
      'sessionId': result.sessionId,
      'lessonId': result.lessonId,
    };
  }

  PronunciationEvaluationResult? _resultFromJson(String json) {
    try {
      final Map<String, dynamic> data = jsonDecode(json) as Map<String, dynamic>;
      
      final phonemeErrors = (data['phonemeErrors'] as List<dynamic>)
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
        data['categoryScores'] as Map<dynamic, dynamic>
      );

      return PronunciationEvaluationResult(
        overallScore: (data['overallScore'] as num).toDouble(),
        categoryScores: categoryScores,
        phonemeErrors: phonemeErrors,
        recordingDuration: Duration(milliseconds: data['recordingDuration'] as int),
        feedbackMessage: data['feedbackMessage'] as String,
        improvementTips: List<String>.from(data['improvementTips'] as List<dynamic>),
        evaluatedAt: DateTime.parse(data['evaluatedAt'] as String),
        sessionId: data['sessionId'] as String,
        lessonId: data['lessonId'] as String?,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveEvaluationResult(PronunciationEvaluationResult result) async {
    try {
      final key = '$_evaluationPrefix${result.sessionId}';
      final json = jsonEncode(_resultToJson(result));
      await _prefs.setString(key, json);
    } catch (e) {
      throw const CacheException(message: 'Failed to save evaluation result');
    }
  }

  @override
  Future<PronunciationEvaluationResult?> getEvaluationResult(String sessionId) async {
    try {
      final key = '$_evaluationPrefix$sessionId';
      final json = _prefs.getString(key);
      
      if (json == null) return null;

      return _resultFromJson(json);
    } catch (e) {
      throw const CacheException(message: 'Failed to get evaluation result');
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
      final keys = _prefs.getKeys()
          .where((key) => key.startsWith(_evaluationPrefix))
          .toList();

      // Get all evaluation results
      final results = <PronunciationEvaluationResult>[];
      
      for (final key in keys) {
        final json = _prefs.getString(key);
        if (json != null) {
          final result = _resultFromJson(json);
          if (result != null) {
            // Apply date filters
            if (startDate != null && result.evaluatedAt.isBefore(startDate)) {
              continue;
            }
            if (endDate != null && result.evaluatedAt.isAfter(endDate)) {
              continue;
            }
            results.add(result);
          }
        }
      }

      // Sort by evaluation date (newest first)
      results.sort((a, b) => b.evaluatedAt.compareTo(a.evaluatedAt));

      // Apply pagination
      return results.skip(offset).take(limit).toList();
    } catch (e) {
      throw const CacheException(message: 'Failed to get history');
    }
  }

  @override
  Future<void> deleteSession(String sessionId) async {
    try {
      final key = '$_evaluationPrefix$sessionId';
      await _prefs.remove(key);
    } catch (e) {
      throw const CacheException(message: 'Failed to delete session');
    }
  }

  @override
  Future<void> queueUpload({
    required String audioPath,
    required String sessionId,
    required String lessonId,
  }) async {
    try {
      final currentQueue = _prefs.getStringList(_uploadQueueKey) ?? [];
      
      final uploadData = {
        'sessionId': sessionId,
        'lessonId': lessonId,
        'audioPath': audioPath,
        'createdAt': DateTime.now().toIso8601String(),
      };
      
      currentQueue.add(jsonEncode(uploadData));
      await _prefs.setStringList(_uploadQueueKey, currentQueue);
    } catch (e) {
      throw const CacheException(message: 'Failed to queue upload');
    }
  }

  @override
  Future<void> cacheUploadInfo(String sessionId, String uploadUrl) async {
    try {
      final key = 'upload_info_$sessionId';
      await _prefs.setString(key, uploadUrl);
    } catch (e) {
      throw const CacheException(message: 'Failed to cache upload info');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getQueuedUploads() async {
    try {
      final queueStrings = _prefs.getStringList(_uploadQueueKey) ?? [];
      
      return queueStrings
          .map((str) => jsonDecode(str) as Map<String, dynamic>)
          .toList();
    } catch (e) {
      throw const CacheException(message: 'Failed to get queued uploads');
    }
  }

  @override
  Future<void> removeFromQueue(String sessionId) async {
    try {
      final currentQueue = _prefs.getStringList(_uploadQueueKey) ?? [];
      
      final filteredQueue = currentQueue.where((itemStr) {
        final item = jsonDecode(itemStr) as Map<String, dynamic>;
        return item['sessionId'] != sessionId;
      }).toList();
      
      await _prefs.setStringList(_uploadQueueKey, filteredQueue);
    } catch (e) {
      throw const CacheException(message: 'Failed to remove from queue');
    }
  }

  @override
  Future<void> saveStatistics(Map<String, dynamic> stats) async {
    try {
      final statsJson = jsonEncode(stats);
      await _prefs.setString(_statisticsKey, statsJson);
    } catch (e) {
      throw const CacheException(message: 'Failed to save statistics');
    }
  }

  @override
  Future<Map<String, dynamic>> getStatistics() async {
    try {
      final statsJson = _prefs.getString(_statisticsKey);
      if (statsJson == null) {
        // Return default statistics
        return {
          'totalSessions': 0,
          'averageScore': 0.0,
          'totalTime': 0,
          'improvementRate': 0.0,
        };
      }
      
      return jsonDecode(statsJson) as Map<String, dynamic>;
    } catch (e) {
      throw const CacheException(message: 'Failed to get statistics');
    }
  }

  @override
  Future<bool> hasMicrophonePermission() async {
    return await Permission.microphone.status == PermissionStatus.granted;
  }

  @override
  Future<bool> requestMicrophonePermission() async {
    try {
      final status = await Permission.microphone.request();
      if (status == PermissionStatus.denied) {
        throw const PermissionFailure('Microphone permission denied');
      } else if (status == PermissionStatus.permanentlyDenied) {
        throw const PermissionFailure('Microphone permission permanently denied');
      }
      return status == PermissionStatus.granted;
    } catch (e) {
      if (e is PermissionFailure) rethrow;
      throw PermissionFailure('Failed to request microphone permission: $e');
    }
  }

  @override
  Future<void> cleanupOldRecordings({Duration maxAge = const Duration(days: 7)}) async {
    try {
      final cutoffDate = DateTime.now().subtract(maxAge);
      final keys = _prefs.getKeys()
          .where((key) => key.startsWith(_evaluationPrefix))
          .toList();

      for (final key in keys) {
        final json = _prefs.getString(key);
        if (json != null) {
          final result = _resultFromJson(json);
          if (result != null && result.evaluatedAt.isBefore(cutoffDate)) {
            await _prefs.remove(key);
          }
        }
      }
    } catch (e) {
      throw const CacheException(message: 'Failed to cleanup old recordings');
    }
  }
}
