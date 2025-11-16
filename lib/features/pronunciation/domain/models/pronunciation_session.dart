/// Phoneme error severity levels
enum PhonemeErrorSeverity {
  low,
  medium,
  high,
}

/// Error types for phoneme recognition
enum PhonemeErrorType {
  substitution,
  deletion,
  insertion,
  wrongVowel,
  stress,
  pitch,
  timing,
}

/// A phoneme error instance
class PhonemeError {
  final String targetPhoneme;
  final String actualPhoneme;
  final String word;
  final int position;
  final PhonemeErrorType type;
  final double severity;

  const PhonemeError({
    required this.targetPhoneme,
    required this.actualPhoneme,
    required this.word,
    required this.position,
    required this.type,
    required this.severity,
  });

  @override
  String toString() {
    return '$word: $targetPhoneme → $actualPhoneme (${type.name})';
  }
}

/// Evaluation result model for pronunciation assessment
class PronunciationEvaluationResult {
  final double overallScore;
  final Map<String, double> categoryScores;
  final List<PhonemeError> phonemeErrors;
  final Duration recordingDuration;
  final String feedbackMessage;
  final List<String> improvementTips;
  final DateTime evaluatedAt;
  final String sessionId;
  final String? lessonId;

  const PronunciationEvaluationResult({
    required this.overallScore,
    required this.categoryScores,
    required this.phonemeErrors,
    required this.recordingDuration,
    required this.feedbackMessage,
    required this.improvementTips,
    required this.evaluatedAt,
    required this.sessionId,
    this.lessonId,
  });

  /// Gets a list of all phoneme errors
  List<PhonemeError> get allErrors => phonemeErrors;

  /// Gets errors by severity type
  List<PhonemeError> getErrorsBySeverity(PhonemeErrorSeverity severity) {
    return phonemeErrors.where((error) {
      switch (severity) {
        case PhonemeErrorSeverity.low:
          return error.severity < 0.3;
        case PhonemeErrorSeverity.medium:
          return error.severity >= 0.3 && error.severity < 0.7;
        case PhonemeErrorSeverity.high:
          return error.severity >= 0.7;
      }
    }).toList();
  }

  /// Check if evaluation has any errors
  bool get hasErrors => phonemeErrors.isNotEmpty;

  @override
  String toString() {
    return 'PronunciationEvaluationResult(overallScore: $overallScore, errors: ${phonemeErrors.length})';
  }
}
