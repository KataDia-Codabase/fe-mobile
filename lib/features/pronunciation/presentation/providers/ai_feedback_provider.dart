import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../../domain/repositories/pronunciation_repository.dart';

// AI Feedback status enum
enum AIFeedbackStatus {
  idle,
  loading,
  loaded,
  error,
}

class AIFeedbackState {
  const AIFeedbackState({
    this.status = AIFeedbackStatus.idle,
    this.feedback = const <String, dynamic>{},
    this.recommendations = const <String>[],
    this.errorMessage,
  });

  final AIFeedbackStatus status;
  final Map<String, dynamic> feedback;
  final List<String> recommendations;
  final String? errorMessage;

  AIFeedbackState copyWith({
    AIFeedbackStatus? status,
    Map<String, dynamic>? feedback,
    List<String>? recommendations,
    String? errorMessage,
  }) {
    return AIFeedbackState(
      status: status ?? this.status,
      feedback: feedback ?? this.feedback,
      recommendations: recommendations ?? this.recommendations,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AIFeedbackState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          feedback == other.feedback &&
          recommendations == other.recommendations &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode =>
      status.hashCode ^ feedback.hashCode ^ recommendations.hashCode ^ errorMessage.hashCode;

  @override
  String toString() => 'AIFeedbackState(status: $status, recommendations: ${recommendations.length})';
}

class AIFeedbackNotifier extends StateNotifier<AIFeedbackState> {
  AIFeedbackNotifier({
    required PronunciationRepository pronunciationRepository,
  })  : _pronunciationRepository = pronunciationRepository,
        super(const AIFeedbackState());

  final PronunciationRepository _pronunciationRepository;
  final Logger _logger = Logger();

  Future<void> getPersonalizedFeedback(String userId, String sessionId) async {
    try {
      state = state.copyWith(status: AIFeedbackStatus.loading);
      
      final result = await _pronunciationRepository.getPersonalizedFeedback(userId, sessionId);
      
      result.fold(
        (failure) {
          state = state.copyWith(
            status: AIFeedbackStatus.error,
            errorMessage: 'Failed to load AI feedback: ${failure.message}',
          );
        },
        (feedbackData) {
          final recommendations = List<String>.from(feedbackData['recommendations'] as List<dynamic>? ?? []);
          final insights = feedbackData['insights'] as Map<String, dynamic>? ?? {};
          
          state = state.copyWith(
            status: AIFeedbackStatus.loaded,
            feedback: insights,
            recommendations: recommendations,
            errorMessage: null,
          );
          
          _logger.i('Loaded personalized feedback for user: $userId');
        },
      );
    } catch (e) {
      _logger.e('Failed to get personalized feedback: $e');
      state = state.copyWith(
        status: AIFeedbackStatus.error,
        errorMessage: 'Failed to load AI feedback: ${e.toString()}',
      );
    }
  }

  Future<void> getLearningPathRecommendations(String userId) async {
    try {
      state = state.copyWith(status: AIFeedbackStatus.loading);
      
      final result = await _pronunciationRepository.getLearningPathRecommendations(userId);
      
      result.fold(
        (failure) {
          state = state.copyWith(
            status: AIFeedbackStatus.error,
            errorMessage: 'Failed to load learning path: ${failure.message}',
          );
        },
        (pathData) {
          final recommendations = List<String>.from(pathData['recommendations'] as List<dynamic>? ?? []);
          final nextSteps = pathData['nextSteps'] as List<String>? ?? [];
          final goals = pathData['goals'] as Map<String, dynamic>? ?? {};
          
          final allRecommendations = [...recommendations, ...nextSteps];
          
          state = state.copyWith(
            status: AIFeedbackStatus.loaded,
            feedback: {'goals': goals, 'path': pathData},
            recommendations: allRecommendations,
            errorMessage: null,
          );
          
          _logger.i('Loaded learning path recommendations for user: $userId');
        },
      );
    } catch (e) {
      _logger.e('Failed to get learning path recommendations: $e');
      state = state.copyWith(
        status: AIFeedbackStatus.error,
        errorMessage: 'Failed to load learning path: ${e.toString()}',
      );
    }
  }

  void reset() {
    state = const AIFeedbackState();
  }

  bool get isLoading => state.status == AIFeedbackStatus.loading;
  bool get hasFeedback => state.status == AIFeedbackStatus.loaded;
  bool get hasError => state.status == AIFeedbackStatus.error;
  String get message => state.errorMessage ?? (hasFeedback ? 'Feedback loaded' : '');
}

// Provider
final aiFeedbackProvider = StateNotifierProvider<AIFeedbackNotifier, AIFeedbackState>(
  (ref) => AIFeedbackNotifier(
    pronunciationRepository: ref.watch(pronunciationRepositoryProvider),
  ),
);

// Dummy provider for now - implement with actual repository
final pronunciationRepositoryProvider = Provider<PronunciationRepository>(
  (ref) => throw UnimplementedError('PronunciationRepository not configured'),
);
