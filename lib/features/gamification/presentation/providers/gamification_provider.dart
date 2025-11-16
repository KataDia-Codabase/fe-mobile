import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/gamification_models.dart';
import '../../domain/repositories/gamification_repository.dart';
import '../../data/repositories/gamification_repository_mock.dart';
import '../../../../core/errors/failures.dart';

/// User Level State
abstract class UserLevelState {
  const UserLevelState();
}

class UserLevelInitial extends UserLevelState {
  const UserLevelInitial();
}

class UserLevelLoading extends UserLevelState {
  const UserLevelLoading();
}

class UserLevelLoaded extends UserLevelState {
  final UserLevel userLevel;
  
  const UserLevelLoaded(this.userLevel);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLevelLoaded &&
          runtimeType == other.runtimeType &&
          userLevel == other.userLevel;
  
  @override
  int get hashCode => userLevel.hashCode;
}

class UserLevelError extends UserLevelState {
  final Failure failure;
  final String message;
  
  const UserLevelError(this.failure, this.message);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLevelError &&
          runtimeType == other.runtimeType &&
          failure == other.failure &&
          message == other.message;
  
  @override
  int get hashCode => failure.hashCode ^ message.hashCode;
}

/// Achievement State
abstract class AchievementState {
  const AchievementState();
}

class AchievementInitial extends AchievementState {
  const AchievementInitial();
}

class AchievementLoading extends AchievementState {
  const AchievementLoading();
}

class AchievementLoaded extends AchievementState {
  final List<UserAchievement> achievements;
  final List<Achievement> availableAchievements;
  
  const AchievementLoaded({
    required this.achievements,
    required this.availableAchievements,
  });
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AchievementLoaded &&
          runtimeType == other.runtimeType &&
          achievements == other.achievements &&
          availableAchievements == other.availableAchievements;
  
  @override
  int get hashCode => Object.hash(achievements, availableAchievements);
}

class AchievementError extends AchievementState {
  final Failure failure;
  final String message;
  
  const AchievementError(this.failure, this.message);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AchievementError &&
          runtimeType == other.runtimeType &&
          failure == other.failure &&
          message == other.message;
  
  @override
  int get hashCode => failure.hashCode ^ message.hashCode;
}

/// Streak State
abstract class StreakState {
  const StreakState();
}

class StreakInitial extends StreakState {
  const StreakInitial();
}

class StreakLoading extends StreakState {
  const StreakLoading();
}

class StreakLoaded extends StreakState {
  final List<UserStreak> streaks;
  
  const StreakLoaded(this.streaks);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StreakLoaded &&
          runtimeType == other.runtimeType &&
          streaks == other.streaks;
  
  @override
  int get hashCode => streaks.hashCode;
}

class StreakError extends StreakState {
  final Failure failure;
  final String message;
  
  const StreakError(this.failure, this.message);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StreakError &&
          runtimeType == other.runtimeType &&
          failure == other.failure &&
          message == other.message;
  
  @override
  int get hashCode => failure.hashCode ^ message.hashCode;
}

/// Level Provider
class UserLevelNotifier extends StateNotifier<UserLevelState> {
  final GamificationRepository repository;
  
  UserLevelNotifier(this.repository) : super(const UserLevelInitial());
  
  Future<void> loadUserLevel(String userId) async {
    state = const UserLevelLoading();
    
    final result = await repository.getUserLevel(userId);
    
    result.fold(
      (failure) => state = UserLevelError(failure, failure.message),
      (userLevel) => state = UserLevelLoaded(userLevel),
    );
  }
  
  Future<void> addXP({
    required String userId,
    required int amount,
    required XPTransactionType type,
    String? sourceId,
    String? description,
    Map<String, dynamic>? metadata,
  }) async {
    if (state is! UserLevelLoaded) return;
    
    final result = await repository.addXP(
      userId: userId,
      amount: amount,
      type: type,
      sourceId: sourceId,
      description: description ?? 'XP earned',
      metadata: metadata ?? {},
    );
    
    result.fold(
      (failure) => state = UserLevelError(failure, failure.message),
      (newLevel) => state = UserLevelLoaded(newLevel),
    );
  }
  
  void reset() {
    state = const UserLevelInitial();
  }
}

/// Achievement Provider
class AchievementNotifier extends StateNotifier<AchievementState> {
  final GamificationRepository repository;
  
  AchievementNotifier(this.repository) : super(const AchievementInitial());
  
  Future<void> loadAchievements(String userId) async {
    state = const AchievementLoading();
    
    final achievementsResult = await repository.getUserAchievements(userId);
    final availableResult = await repository.getAvailableAchievements();
    
    if (achievementsResult.isLeft() || availableResult.isLeft()) {
      state = const AchievementError(
        ServerFailure('Failed to load achievements'),
        'Failed to load achievements',
      );
      return;
    }
    
    state = AchievementLoaded(
      achievements: achievementsResult.getOrElse(() => []),
      availableAchievements: availableResult.getOrElse(() => []),
    );
  }
  
  Future<void> unlockAchievement({
    required String userId,
    required String achievementId,
  }) async {
    final result = await repository.unlockAchievement(
      userId: userId,
      achievementId: achievementId,
    );
    
    result.fold(
      (failure) => state = AchievementError(failure, failure.message),
      (achievement) {
        // Refresh achievements
        loadAchievements(userId);
      },
    );
  }
  
  Future<void> updateProgress({
    required String userId,
    required String achievementId,
    required int progressIncrement,
    Map<String, dynamic>? progressData,
  }) async {
    final result = await repository.updateAchievementProgress(
      userId: userId,
      achievementId: achievementId,
      progressIncrement: progressIncrement,
      progressData: progressData,
    );
    
    result.fold(
      (failure) => state = AchievementError(failure, failure.message),
      (_) => loadAchievements(userId),
    );
  }
  
  void reset() {
    state = const AchievementInitial();
  }
}

/// Streak Provider
class StreakNotifier extends StateNotifier<StreakState> {
  final GamificationRepository repository;
  
  StreakNotifier(this.repository) : super(const StreakInitial());
  
  Future<void> loadStreaks(String userId) async {
    state = const StreakLoading();
    
    final result = await repository.getUserStreaks(userId);
    
    result.fold(
      (failure) => state = StreakError(failure, failure.message),
      (streaks) => state = StreakLoaded(streaks),
    );
  }
  
  Future<void> updateStreak({
    required String userId,
    required StreakType type,
    required bool increment,
  }) async {
    final result = await repository.updateUserStreak(
      userId: userId,
      type: type,
      increment: increment,
    );
    
    result.fold(
      (failure) => state = StreakError(failure, failure.message),
      (_) => loadStreaks(userId),
    );
  }
  
  void reset() {
    state = const StreakInitial();
  }
}

/// Main Gamification Provider
class GamificationNotifier extends StateNotifier<UserGamificationProfile?> {
  final GamificationRepository repository;
  
  GamificationNotifier(this.repository) : super(null);
  
  Future<void> loadProfile(String userId) async {
    final result = await repository.getUserGamificationProfile(userId);
    
    result.fold(
      (failure) => state = null,
      (profile) => state = profile,
    );
  }
  
  Future<void> processEvent(GamificationEventData event) async {
    // Process gamification event (unlock achievements, add XP, etc.)
    final result = await repository.processGamificationEvent(event);
    
    result.fold(
      (failure) => null,
      (_) => loadProfile(event.userId),
    );
  }
  
  void reset() {
    state = null;
  }
}

// Providers
final userLevelProvider = StateNotifierProvider<UserLevelNotifier, UserLevelState>(
  (ref) => UserLevelNotifier(ref.watch(gamificationRepositoryProvider)),
);

final achievementProvider = StateNotifierProvider<AchievementNotifier, AchievementState>(
  (ref) => AchievementNotifier(ref.watch(gamificationRepositoryProvider)),
);

final streakProvider = StateNotifierProvider<StreakNotifier, StreakState>(
  (ref) => StreakNotifier(ref.watch(gamificationRepositoryProvider)),
);

final gamificationProvider = StateNotifierProvider<GamificationNotifier, UserGamificationProfile?>(
  (ref) => GamificationNotifier(ref.watch(gamificationRepositoryProvider)),
);

// Convenience providers
final currentLevelProvider = Provider<UserLevel?>((ref) {
  final state = ref.watch(userLevelProvider);
  return state is UserLevelLoaded ? state.userLevel : null;
});

final currentLevelNumberProvider = Provider<int>((ref) {
  final level = ref.watch(currentLevelProvider);
  return level?.currentLevel ?? 1;
});

final unlockedAchievementsProvider = Provider<List<UserAchievement>>((ref) {
  final state = ref.watch(achievementProvider);
  return state is AchievementLoaded ? state.achievements : const [];
});

final activeStreaksProvider = Provider<List<UserStreak>>((ref) {
  final state = ref.watch(streakProvider);
  return state is StreakLoaded ? state.streaks.where((s) => s.isActive).toList() : const [];
});

// Repository provider (using mock implementation for now)
final gamificationRepositoryProvider = Provider<GamificationRepository>(
  (ref) => GamificationRepositoryMock(),
);
