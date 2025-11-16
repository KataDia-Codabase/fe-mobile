import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../../domain/models/social_challenge.dart';
import '../../data/datasources/social_remote_datasource.dart' as ds;
import '../../domain/repositories/social_repository.dart';

class SocialFeaturesState {
  const SocialFeaturesState({
    this.challenges = const [],
    this.myParticipations = const [],
    this.leaderboard = const [],
    this.isLoading = false,
    this.error,
  });

  final List<SocialChallenge> challenges;
  final List<ds.ChallengeParticipation> myParticipations;
  final List<ds.LeaderboardEntry> leaderboard;
  final bool isLoading;
  final String? error;

  SocialFeaturesState copyWith({
    List<SocialChallenge>? challenges,
    List<ds.ChallengeParticipation>? myParticipations,
    List<ds.LeaderboardEntry>? leaderboard,
    bool? isLoading,
    String? error,
  }) {
    return SocialFeaturesState(
      challenges: challenges ?? this.challenges,
      myParticipations: myParticipations ?? this.myParticipations,
      leaderboard: leaderboard ?? this.leaderboard,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialFeaturesState &&
          runtimeType == other.runtimeType &&
          challenges == other.challenges &&
          myParticipations == other.myParticipations &&
          leaderboard == other.leaderboard &&
          isLoading == other.isLoading &&
          error == other.error;

  @override
  int get hashCode =>
      challenges.hashCode ^ 
      myParticipations.hashCode ^ 
      leaderboard.hashCode ^ 
      isLoading.hashCode ^ 
      error.hashCode;

  @override
  String toString() => 
      'SocialFeaturesState(challenges: ${challenges.length}, '
      'participations: ${myParticipations.length}, '
      'isLoading: $isLoading, '
      'error: $error)';
}

/// Social features provider for challenges, leaderboards, and community features
class SocialFeaturesNotifier extends StateNotifier<SocialFeaturesState> {
  final SocialRepository _socialRepository;
  final Logger _logger = Logger();
  
  SocialFeaturesNotifier({
    required SocialRepository socialRepository,
  }) : _socialRepository = socialRepository,
        super(const SocialFeaturesState());

  Future<void> loadChallenges({String? userId}) async {
    try {
      state = state.copyWith(isLoading: true);
      
      final challenges = await _socialRepository.getAvailableChallenges(userId ?? 'guest');
      final myParticipations = userId != null 
          ? await _socialRepository.getMyParticipations(userId)
          : <ds.ChallengeParticipation>[];
      
      state = state.copyWith(
        challenges: challenges,
        myParticipations: myParticipations,
        isLoading: false,
        error: null,
      );
      
      _logger.i('Loaded ${challenges.length} challenges and ${myParticipations.length} participations');
    } catch (e) {
      _logger.e('Failed to load social features: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load social features: ${e.toString()}',
      );
    }
  }

  Future<void> joinChallenge(String challengeId, String userId) async {
    try {
      state = state.copyWith(isLoading: true);
      
      await _socialRepository.joinChallenge(challengeId, userId);
      
      // Refresh data after joining
      await loadChallenges(userId: userId);
      
      _logger.i('Successfully joined challenge: $challengeId');
    } catch (e) {
      _logger.e('Failed to join challenge: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to join challenge: ${e.toString()}',
      );
    }
  }

  Future<void> leaveChallenge(String challengeId, String userId) async {
    try {
      state = state.copyWith(isLoading: true);
      
      await _socialRepository.leaveChallenge(challengeId, userId);
      
      // Refresh data after leaving
      await loadChallenges(userId: userId);
      
      _logger.i('Successfully left challenge: $challengeId');
    } catch (e) {
      _logger.e('Failed to leave challenge: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to leave challenge: ${e.toString()}',
      );
    }
  }

  Future<void> loadLeaderboard() async {
    try {
      state = state.copyWith(isLoading: true);
      
      final leaderboard = await _socialRepository.getLeaderboard();
      
      state = state.copyWith(
        leaderboard: leaderboard,
        isLoading: false,
        error: null,
      );
      
      _logger.i('Loaded leaderboard with ${leaderboard.length} entries');
    } catch (e) {
      _logger.e('Failed to load leaderboard: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load leaderboard: ${e.toString()}',
      );
    }
  }

  Future<List<SocialChallenge>> getChallengesByCategory(String category) async {
    return state.challenges
        .where((challenge) => challenge.category == category)
        .toList();
  }

  Future<SocialChallenge?> getChallengeById(String challengeId) async {
    try {
      return state.challenges.firstWhere((challenge) => challenge.id == challengeId);
    } catch (e) {
      _logger.e('Failed to get challenge by ID: $e');
      return null;
    }
  }

  Future<ds.ChallengeParticipation?> getMyParticipation(String challengeId) async {
    try {
      return state.myParticipations
          .firstWhere((participation) => participation.challengeId == challengeId);
    } catch (e) {
      _logger.e('Failed to get participation: $e');
      return null;
    }
  }

  Future<void> submitScore(String userId, String challengeId, int score) async {
    try {
      await _socialRepository.submitScore(userId, challengeId, score);
      
      // Refresh participations and leaderboard
      await loadChallenges(userId: userId);
      await loadLeaderboard();
      
      _logger.i('Submitted score for user: $userId in challenge: $challengeId');
    } catch (e) {
      _logger.e('Failed to submit score: $e');
      state = state.copyWith(
        error: 'Failed to submit score: ${e.toString()}',
      );
    }
  }

  void reset() {
    state = const SocialFeaturesState();
  }

  bool get isLoading => state.isLoading;
  String? get error => state.error;
  bool get hasError => state.error != null;
  int get challengeCount => state.challenges.length;
  int get participationCount => state.myParticipations.length;
  bool get hasAnyChallenges => state.challenges.isNotEmpty;
}

// Provider - using mock/placeholder repository untuk sekarang
final socialFeaturesProvider = StateNotifierProvider<SocialFeaturesNotifier, SocialFeaturesState>(
  (ref) => SocialFeaturesNotifier(
    socialRepository: _MockSocialRepository(),
  ),
);

/// Mock implementation of SocialRepository untuk development
class _MockSocialRepository implements SocialRepository {
  @override
  Future<List<SocialChallenge>> getAvailableChallenges(String userId) async {
    return [];
  }

  @override
  Future<List<ds.ChallengeParticipation>> getMyParticipations(String userId) async {
    return [];
  }

  @override
  Future<List<ds.LeaderboardEntry>> getLeaderboard({int limit = 100}) async {
    return [];
  }

  @override
  Future<List<SocialChallenge>> getChallengesByCategory(String category) async {
    return [];
  }

  @override
  Future<SocialChallenge?> getChallengeById(String challengeId) async {
    return null;
  }

  @override
  Future<ds.ChallengeParticipation?> getMyParticipation(String challengeId) async {
    return null;
  }

  @override
  Future<bool> joinChallenge(String userId, String challengeId) async {
    return false;
  }

  @override
  Future<bool> leaveChallenge(String userId, String challengeId) async {
    return false;
  }

  @override
  Future<bool> submitScore(String userId, String challengeId, int score) async {
    return false;
  }
}
