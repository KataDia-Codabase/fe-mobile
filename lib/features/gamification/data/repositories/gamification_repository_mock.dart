import 'package:dartz/dartz.dart';
import '../../domain/models/gamification_models.dart';
import '../../domain/repositories/gamification_repository.dart';
import '../../../../core/errors/failures.dart';

/// Mock implementation of GamificationRepository for development/testing
class GamificationRepositoryMock implements GamificationRepository {
  
  @override
  Future<Either<Failure, UserLevel>> getUserLevel(String userId) async {
    // Mock implementation - return default user level
    return Right(UserLevel(
      currentLevel: 1,
      totalXP: 0,
      currentLevelXP: 0,
      currentLevelXPNeeded: 100,
      levelProgress: 0.0,
      lastUpdatedAt: DateTime.now(),
      totalSessionsCompleted: 0,
    ));
  }

  @override
  Future<Either<Failure, UserLevel>> addXP({
    required String userId,
    required int amount,
    required XPTransactionType type,
    String? sourceId,
    String? description,
    Map<String, dynamic>? metadata,
  }) async {
    // Mock implementation - add XP and return updated level
    final mockLevel = UserLevel(
      currentLevel: 1,
      totalXP: amount,
      currentLevelXP: amount,
      currentLevelXPNeeded: 100,
      levelProgress: (amount / 100) * 100,
      lastUpdatedAt: DateTime.now(),
      totalSessionsCompleted: 1,
    );
    
    return Right(mockLevel);
  }

  @override
  Future<Either<Failure, List<UserAchievement>>> getUserAchievements(String userId) async {
    // Mock implementation - return empty list
    return const Right([]);
  }

  @override
  Future<Either<Failure, List<Achievement>>> getAvailableAchievements() async {
    // Mock implementation - return empty list
    return const Right([]);
  }

  @override
  Future<Either<Failure, UserAchievement>> unlockAchievement({
    required String userId,
    required String achievementId,
  }) async {
    // Mock implementation
    return const Left(ServerFailure('Mock: Not implemented'));
  }

  @override
  Future<Either<Failure, void>> updateAchievementProgress({
    required String userId,
    required String achievementId,
    required int progressIncrement,
    Map<String, dynamic>? progressData,
  }) async {
    // Mock implementation
    return const Right(null);
  }

  @override
  Future<Either<Failure, List<UserStreak>>> getUserStreaks(String userId) async {
    // Mock implementation - return empty list
    return const Right([]);
  }

  @override
  Future<Either<Failure, UserStreak>> updateUserStreak({
    required String userId,
    required StreakType type,
    required bool increment,
  }) async {
    // Mock implementation
    return const Left(ServerFailure('Mock: Not implemented'));
  }

  @override
  Future<Either<Failure, UserGamificationProfile>> getUserGamificationProfile(String userId) async {
    // Mock implementation - return empty profile
    final mockProfile = UserGamificationProfile(
      userId: userId,
      level: UserLevel(
        currentLevel: 1,
        totalXP: 0,
        currentLevelXP: 0,
        currentLevelXPNeeded: 100,
        levelProgress: 0.0,
        lastUpdatedAt: DateTime.now(),
        totalSessionsCompleted: 0,
      ),
      achievements: const [],
      streaks: const [],
      xpTransactions: const [],
      preferences: const {},
      createdAt: DateTime.now(),
      lastUpdatedAt: DateTime.now(),
      isFirstLogin: true,
    );
    
    return Right(mockProfile);
  }

  @override
  Future<Either<Failure, void>> processGamificationEvent(GamificationEventData event) async {
    // Mock implementation
    return const Right(null);
  }

  @override
  Future<Either<Failure, List<LeaderboardEntry>>> getLeaderboard({
    required LeaderboardType type,
    int? limit,
    String? country,
  }) async {
    // Mock implementation - return empty list
    return const Right([]);
  }

  @override
  Future<Either<Failure, GamificationAnalytics>> getUserAnalytics(String userId) async {
    // Mock implementation
    return const Left(ServerFailure('Mock: Not implemented'));
  }
}
