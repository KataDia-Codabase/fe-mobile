import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

import '../../domain/models/pronunciation_session.dart';
import '../../../../core/errors/failures.dart';

/// Evaluation state enum for pronunciation assessment
enum EvaluationState {
  idle,
  uploading,
  processing,
  completed,
  error,
}

/// Provider for evaluation state management
final evaluationProvider = StateNotifierProvider<EvaluationStateNotifier, EvaluationState>(
  (ref) => EvaluationStateNotifier(),
);

/// State notifier for managing pronunciation evaluation
class EvaluationStateNotifier extends StateNotifier<EvaluationState> {
  EvaluationStateNotifier() : super(EvaluationState.idle);
  
  PronunciationEvaluationResult? _result;
  Failure? _lastError;

  /// Current evaluation state
  EvaluationState get currentState => state;
  /// Last evaluation result
  PronunciationEvaluationResult? get result => _result;
  /// Last error that occurred
  Failure? get lastError => _lastError;
  /// Whether evaluation is currently processing
  bool get isProcessing => [
        EvaluationState.uploading,
        EvaluationState.processing,
      ].contains(state);
  /// Whether evaluation has a result
  bool get hasResult => _result != null;

  /// Start a new evaluation
  Future<void> startEvaluation({
    required String audioPath,
    required String sessionId,
  }) async {
    try {
      _reset();
      state = EvaluationState.uploading;
      
      // Simulate upload process
      await Future<void>.delayed(const Duration(seconds: 1));
      
      state = EvaluationState.processing;
      
      // Simulate processing
      await Future<void>.delayed(const Duration(seconds: 2));
      
      _result = _createPronunciationEvaluationResult(sessionId);
      state = EvaluationState.completed;
      
      debugPrint('Evaluation completed successfully for session: $sessionId');
    } catch (e) {
      _lastError = UnexpectedFailure('Evaluation failed: $e');
      state = EvaluationState.error;
      debugPrint('Evaluation failed: $e');
    }
  }

  /// Reset the evaluation state
  void reset() {
    _reset();
  }

  void _reset() {
    state = EvaluationState.idle;
    _result = null;
    _lastError = null;
  }

  /// Create a pronunciation evaluation result
  PronunciationEvaluationResult _createPronunciationEvaluationResult(String evaluationId) {
    final score = 75.0 + (DateTime.now().millisecond % 20);
    
    return PronunciationEvaluationResult(
      overallScore: score,
      categoryScores: {
        'accuracy': 70.0 + (DateTime.now().millisecond % 25),
        'fluency': 75.0 + (DateTime.now().millisecond % 15),
        'prosody': 80.0 + (DateTime.now().millisecond % 15),
        'stress': 70.0 + (DateTime.now().millisecond % 25),
      },
      phonemeErrors: [
        const PhonemeError(
          targetPhoneme: 'eɪ',
          actualPhoneme: 'æ',
          word: 'again',
          position: 2,
          type: PhonemeErrorType.substitution,
          severity: 0.3,
        ),
        const PhonemeError(
          targetPhoneme: 'iː',
          actualPhoneme: 'ɪ',
          word: 'beautiful',
          position: 3,
          type: PhonemeErrorType.substitution,
          severity: 0.4,
        ),
      ],
      recordingDuration: const Duration(seconds: 5),
      feedbackMessage: 'Good pronunciation overall! Focus on vowel sounds.',
      improvementTips: [
        'Practice the "ay" sound in words like "say" and "day"',
        'Try to elongate vowel sounds in stressed syllables',
        'Listen to native speakers and try to mimic their rhythm',
      ],
      evaluatedAt: DateTime.now(),
      sessionId: evaluationId,
    );
  }
}
