import '../models/social_challenge.dart';
import '../../data/datasources/social_remote_datasource.dart';

abstract class SocialRepository {
  /// Get available challenges for a user
  Future<List<SocialChallenge>> getAvailableChallenges(String userId);
  
  /// Get user's challenge participations
  Future<List<ChallengeParticipation>> getMyParticipations(String userId);
  
  /// Get leaderboard entries
  Future<List<LeaderboardEntry>> getLeaderboard({int limit = 100});
  
  /// Get challenges by category
  Future<List<SocialChallenge>> getChallengesByCategory(String category);
  
  /// Get challenge details
  Future<SocialChallenge?> getChallengeById(String challengeId);
  
  /// Get user participation in specific challenge
  Future<ChallengeParticipation?> getMyParticipation(String challengeId);
  
  /// Join a challenge
  Future<bool> joinChallenge(String userId, String challengeId);
  
  /// Leave a challenge
  Future<bool> leaveChallenge(String userId, String challengeId);
  
  /// Submit score
  Future<bool> submitScore(String userId, String challengeId, int score);
}
