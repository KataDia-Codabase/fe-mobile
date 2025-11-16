import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../../domain/repositories/pronunciation_repository.dart';

// Real-time scoring statuses
enum RealTimeScoringStatus {
  initial,
  connecting,
  connected,
  receiving,
  completed,
  error,
}

class RealTimeScoringState {
  const RealTimeScoringState({
    this.status = RealTimeScoringStatus.initial,
    this.score = 0.0,
    this.feedback = '',
    this.isRecording = false,
    this.errorMessage,
  });

  final RealTimeScoringStatus status;
  final double score;
  final String feedback;
  final bool isRecording;
  final String? errorMessage;

  RealTimeScoringState copyWith({
    RealTimeScoringStatus? status,
    double? score,
    String? feedback,
    bool? isRecording,
    String? errorMessage,
  }) {
    return RealTimeScoringState(
      status: status ?? this.status,
      score: score ?? this.score,
      feedback: feedback ?? this.feedback,
      isRecording: isRecording ?? this.isRecording,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RealTimeScoringState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          score == other.score &&
          feedback == other.feedback &&
          isRecording == other.isRecording &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode =>
      status.hashCode ^ score.hashCode ^ feedback.hashCode ^ isRecording.hashCode ^ errorMessage.hashCode;

  @override
  String toString() => 'RealTimeScoringState(status: $status, score: $score, feedback: $feedback)';
}

class RealTimeScoringNotifier extends StateNotifier<RealTimeScoringState> {
  RealTimeScoringNotifier({
    required PronunciationRepository pronunciationRepository,
  })  : _pronunciationRepository = pronunciationRepository,
        super(const RealTimeScoringState());

  final PronunciationRepository _pronunciationRepository;
  final Logger _logger = Logger();
  
  Stream<Map<String, dynamic>>? _scoringStream;

  Future<void> connectRealTimeScoring(String sessionId) async {
    try {
      state = state.copyWith(status: RealTimeScoringStatus.connecting);
      
      _scoringStream = _pronunciationRepository.connectRealTimeScoring(sessionId);
      _scoringStream?.listen(
        (data) => _handleScoringData(data),
        onError: (dynamic error) => _handleScoringError(error),
      );

      state = state.copyWith(status: RealTimeScoringStatus.connected);
      _logger.i('Connected to real-time scoring for session: $sessionId');
    } catch (e) {
      _logger.e('Failed to connect real-time scoring: $e');
      state = state.copyWith(
        status: RealTimeScoringStatus.error,
        errorMessage: 'Failed to connect to scoring service',
      );
    }
  }

  void _handleScoringData(Map<String, dynamic> data) {
    try {
      if (data.containsKey('error')) {
        state = state.copyWith(
          status: RealTimeScoringStatus.error,
          errorMessage: data['error']?.toString(),
        );
        return;
      }

      final score = (data['score'] as num?)?.toDouble() ?? 0.0;
      final feedback = data['feedback'] as String? ?? '';
      final isRecording = data['isRecording'] as bool? ?? false;

      state = state.copyWith(
        status: isRecording ? RealTimeScoringStatus.receiving : RealTimeScoringStatus.completed,
        score: score,
        feedback: feedback,
        isRecording: isRecording,
        errorMessage: null,
      );
    } catch (e) {
      _logger.e('Error handling scoring data: $e');
      state = state.copyWith(
        status: RealTimeScoringStatus.error,
        errorMessage: 'Error processing scoring data',
      );
    }
  }

  void _handleScoringError(dynamic error) {
    _logger.e('Real-time scoring error: $error');
    state = state.copyWith(
      status: RealTimeScoringStatus.error,
      errorMessage: 'Connection error: ${error.toString()}',
    );
  }

  void startReceiving() {
    state = state.copyWith(status: RealTimeScoringStatus.receiving, isRecording: true);
  }

  void stopReceiving() {
    state = state.copyWith(status: RealTimeScoringStatus.completed, isRecording: false);
  }

  void reset() {
    _scoringStream = null;
    state = const RealTimeScoringState();
  }

  void disposeStreams() {
    _scoringStream = null;
  }
}

// Provider
final realtimeScoringProvider = StateNotifierProvider<RealTimeScoringNotifier, RealTimeScoringState>(
  (ref) => RealTimeScoringNotifier(
    pronunciationRepository: ref.watch(pronunciationRepositoryProvider),
  ),
);

// Dummy provider for now - implement with actual repository
final pronunciationRepositoryProvider = Provider<PronunciationRepository>(
  (ref) => throw UnimplementedError('PronunciationRepository not configured'),
);
