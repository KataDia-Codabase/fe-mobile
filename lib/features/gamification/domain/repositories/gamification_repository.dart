import 'package:dartz/dartz.dart';
import '../models/gamification_models.dart';
import '../../../../core/errors/failures.dart';

/// Repository interface for gamification features
abstract class GamificationRepository {
  /// Get user level information
  Future<Either<Failure, UserLevel>> getUserLevel(String userId);

  /// Add XP to user account
  Future<Either<Failure, UserLevel>> addXP({
    required String userId,
    required int amount,
    required XPTransactionType type,
    String? sourceId,
    String? description,
    Map<String, dynamic>? metadata,
  });

  /// Get user achievements
  Future<Either<Failure, List<UserAchievement>>> getUserAchievements(String userId);

  /// Get all available achievements
  Future<Either<Failure, List<Achievement>>> getAvailableAchievements();

  /// Unlock an achievement for user
  Future<Either<Failure, UserAchievement>> unlockAchievement({
    required String userId,
    required String achievementId,
  });

  /// Update achievement progress
  Future<Either<Failure, void>> updateAchievementProgress({
    required String userId,
    required String achievementId,
    required int progressIncrement,
    Map<String, dynamic>? progressData,
  });

  /// Get user streaks
  Future<Either<Failure, List<UserStreak>>> getUserStreaks(String userId);

  /// Update user streak
  Future<Either<Failure, UserStreak>> updateUserStreak({
    required String userId,
    required StreakType type,
    required bool increment,
  });

  /// Get user gamification profile
  Future<Either<Failure, UserGamificationProfile>> getUserGamificationProfile(String userId);

  /// Process gamification event
  Future<Either<Failure, void>> processGamificationEvent(GamificationEventData event);

  /// Get leaderboard entries
  Future<Either<Failure, List<LeaderboardEntry>>> getLeaderboard({
    required LeaderboardType type,
    int? limit,
    String? country,
  });

  /// Get user analytics
  Future<Either<Failure, GamificationAnalytics>> getUserAnalytics(String userId);
}
