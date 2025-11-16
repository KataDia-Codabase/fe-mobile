import 'package:dartz/dartz.dart';
import '../models/pronunciation_session.dart';
import '../../../../core/errors/failures.dart';

/// Repository interface for pronunciation practice functionality
abstract class PronunciationRepository {
  /// Upload audio recording for evaluation
  Future<Either<Failure, String>> uploadAudio({
    required String audioPath,
    required String sessionId,
    required String lessonId,
  });

  /// Get evaluation result for a session
  Future<Either<Failure, PronunciationEvaluationResult>> getEvaluationResult(
    String sessionId,
  );

  /// Save evaluation result to local cache
  Future<Either<Failure, void>> saveEvaluationResult(
    PronunciationEvaluationResult result,
  );

  /// Get user pronunciation history
  Future<Either<Failure, List<PronunciationEvaluationResult>>> getHistory({
    int limit = 20,
    int offset = 0,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Delete a pronunciation session
  Future<Either<Failure, void>> deleteSession(String sessionId);

  /// Get pronunciation statistics and analytics
  Future<Either<Failure, Map<String, dynamic>>> getStatistics();

  /// Check if user has microphone permission
  Future<bool> hasMicrophonePermission();

  /// Request microphone permission
  Future<Either<Failure, bool>> requestMicrophonePermission();

  /// Connect to real-time pronunciation scoring
  Stream<Map<String, dynamic>> connectRealTimeScoring(String sessionId);

  /// Get personalized AI feedback for a session
  Future<Either<Failure, Map<String, dynamic>>> getPersonalizedFeedback(
    String userId,
    String sessionId,
  );

  /// Get learning path recommendations for user
  Future<Either<Failure, Map<String, dynamic>>> getLearningPathRecommendations(
    String userId,
  );
}
