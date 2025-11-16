/// Achievement Categories
enum AchievementCategory {
  pronunciation('Pronunciation'),
  vocabulary('Vocabulary'),
  grammar('Grammar'),
  speaking('Speaking'),
  listening('Listening'),
  reading('Reading'),
  writing('Writing'),
  streak('Streak'),
  time('Time'),
  social('Social'),
  special('Special');

  const AchievementCategory(this.displayName);
  
  final String displayName;
}

/// Achievement Rarity
enum AchievementRarity {
  common('Common', 'bronze', 1.0),
  uncommon('Uncommon', 'silver', 1.5),
  rare('Rare', 'gold', 2.0),
  epic('Epic', 'platinum', 3.0),
  legendary('Legendary', 'diamond', 5.0);

  const AchievementRarity(this.displayName, this.borderColor, this.xpMultiplier);
  
  final String displayName;
  final String borderColor;
  final double xpMultiplier;
}

/// Achievement Type
enum AchievementType {
  singleCompletion('Single Completion'),
  cumulativeCount('Cumulative Count'),
  streakBased('Streak Based'),
  scoreThreshold('Score Threshold'),
  timeBased('Time Based'),
  social('Social'),
  hidden('Hidden');

  const AchievementType(this.displayName);
  
  final String displayName;
}

/// Achievement Definition
class Achievement {
  final String id;
  final String title;
  final String description;
  final AchievementCategory category;
  final AchievementRarity rarity;
  final AchievementType type;
  final String? unLockCriteriaDescription;
  final Map<String, dynamic> criteria;
  final int xpReward;
  final String? iconUrl;
  final bool isVisible;
  final DateTime? unlockableFromDate;
  final int sortOrder;
  final int? requiredLevel;
  
  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.rarity,
    required this.type,
    this.unLockCriteriaDescription,
    required this.criteria,
    required this.xpReward,
    this.iconUrl,
    this.isVisible = true,
    this.unlockableFromDate,
    this.sortOrder = 0,
    this.requiredLevel,
  });
}

/// User Achievement Progress
class UserAchievement {
  final String id;
  final String userId;
  final String achievementId;
  final bool isUnlocked;
  final Map<String, dynamic> progressData;
  final DateTime createdAt;
  final DateTime? unlockedAt;
  final int currentProgress;
  final int maxProgress;
  
  const UserAchievement({
    required this.id,
    required this.userId,
    required this.achievementId,
    required this.isUnlocked,
    required this.progressData,
    required this.createdAt,
    this.unlockedAt,
    required this.currentProgress,
    required this.maxProgress,
  });
  
  double get progressPercentage => 
      maxProgress > 0 ? (currentProgress / maxProgress) * 100 : 0.0;
}

/// User Level and XP
class UserLevel {
  final int currentLevel;
  final int totalXP;
  final int currentLevelXP;
  final int currentLevelXPNeeded;
  final double levelProgress;
  final DateTime lastUpdatedAt;
  final int totalSessionsCompleted;
  
  const UserLevel({
    required this.currentLevel,
    required this.totalXP,
    required this.currentLevelXP,
    required this.currentLevelXPNeeded,
    required this.levelProgress,
    required this.lastUpdatedAt,
    required this.totalSessionsCompleted,
  });
  
  /// Calculate XP needed for level
  static int xpNeededForLevel(int level) {
    // Exponential growth: Level^2 * 100 + (Level * 500)
    return (level * level * 100) + (level * 500);
  }
  
  /// Get level from total XP
  static int getLevelFromXP(int totalXP) {
    int level = 1;
    while (totalXP >= xpNeededForLevel(level)) {
      totalXP -= xpNeededForLevel(level);
      level++;
    }
    return level;
  }
}

/// Streak Types
enum StreakType {
  dailyPractice('Daily Practice'),
  weeklyConsistent('Weekly Consistent'),
  monthlyConsistent('Monthly Consistent'),
  perfectDays('Perfect Days'),
  lessonStreak('Lesson Streak'),
  pronunciationStreak('Pronunciation Streak');

  const StreakType(this.displayName);
  
  final String displayName;
}

/// User Streak
class UserStreak {
  final String id;
  final String userId;
  final StreakType type;
  final int currentStreak;
  final int longestStreak;
  final DateTime lastActivityDate;
  final bool isActive;
  final DateTime streakStartDate;
  final Map<String, dynamic> streakData;
  
  const UserStreak({
    required this.id,
    required this.userId,
    required this.type,
    required this.currentStreak,
    required this.longestStreak,
    required this.lastActivityDate,
    required this.isActive,
    required this.streakStartDate,
    required this.streakData,
  });
}

/// XP Transaction Types
enum XPTransactionType {
  earned('Earned'),
  bonus('Bonus'),
  streak('Streak'),
  achievement('Achievement'),
  lesson('Lesson'),
  pronunciation('Pronunciation'),
  assessment('Assessment');

  const XPTransactionType(this.displayName);
  
  final String displayName;
}

/// XP Transaction
class XPTransaction {
  final String id;
  final String userId;
  final int amount;
  final XPTransactionType type;
  final String? sourceId;
  final String description;
  final DateTime createdAt;
  final Map<String, dynamic> metadata;
  
  const XPTransaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    this.sourceId,
    required this.description,
    required this.createdAt,
    required this.metadata,
  });
}

/// Leaderboard Types
enum LeaderboardType {
  global('Global'),
  friends('Friends'),
  country('Country'),
  weekly('Weekly'),
  monthly('Monthly');

  const LeaderboardType(this.displayName);
  
  final String displayName;
}

/// Leaderboard Entry
class LeaderboardEntry {
  final String userId;
  final int rank;
  final String username;
  final String? avatarUrl;
  final int xp;
  final int level;
  final int streak;
  final List<Achievement> recentAchievements;
  
  const LeaderboardEntry({
    required this.userId,
    required this.rank,
    required this.username,
    this.avatarUrl,
    required this.xp,
    required this.level,
    required this.streak,
    required this.recentAchievements,
  });
}

/// Gamification Analytics
class GamificationAnalytics {
  final String userId;
  final int totalXP;
  final int currentLevel;
  final int achievementsUnlocked;
  final int achievementsTotal;
  final Map<AchievementCategory, int> achievementsByCategory;
  final double averageXPPerSession;
  final UserStreak longestStreak;
  final DateTime lastActivity;
  final Map<StreakType, bool> activeStreaks;
  final int leaderboardRank; // Global rank
  final Map<LeaderboardType, int> leaderboardRanks;
  
  const GamificationAnalytics({
    required this.userId,
    required this.totalXP,
    required this.currentLevel,
    required this.achievementsUnlocked,
    required this.achievementsTotal,
    required this.achievementsByCategory,
    required this.averageXPPerSession,
    required this.longestStreak,
    required this.lastActivity,
    required this.activeStreaks,
    required this.leaderboardRank,
    required this.leaderboardRanks,
  });
  
  /// Calculate achievement completion percentage
  double get achievementCompletionPercentage =>
      achievementsTotal > 0 ? (achievementsUnlocked / achievementsTotal) * 100 : 0.0;
  
  /// Check if user is performing well
  bool get isHighPerformer => 
      currentLevel >= 10 && achievementsUnlocked >= 20 && longestStreak.currentStreak >= 7;
}

/// User Gamification Profile
class UserGamificationProfile {
  final String userId;
  final UserLevel level;
  final List<UserAchievement> achievements;
  final List<UserStreak> streaks;
  final List<XPTransaction> xpTransactions;
  final Map<String, dynamic> preferences;
  final DateTime createdAt;
  final DateTime lastUpdatedAt;
  final bool isFirstLogin;
  
  const UserGamificationProfile({
    required this.userId,
    required this.level,
    required this.achievements,
    required this.streaks,
    required this.xpTransactions,
    required this.preferences,
    required this.createdAt,
    required this.lastUpdatedAt,
    required this.isFirstLogin,
  });
  
  /// Get active streaks
  List<UserStreak> get activeStreaks => 
      streaks.where((streak) => streak.isActive).toList();
  
  /// Get unlocked achievements
  List<UserAchievement> get unlockedAchievements => 
      achievements.where((achievement) => achievement.isUnlocked).toList();
  
  /// Get total XP earned
  int get totalXPEarned => level.totalXP;
  
  /// Check if user has specific achievement
  bool hasAchievement(String achievementId) {
    return unlockedAchievements
        .any((achievement) => achievement.achievementId == achievementId);
  }
}

/// Gamification Event Types
enum GamificationEvent {
  lessonCompleted('Lesson Completed'),
  pronunciationCompleted('Pronunciation Completed'),
  assessmentCompleted('Assessment Completed'),
  streakMaintained('Streak Maintained'),
  achievementUnlocked('Achievement Unlocked'),
  levelUp('Level Up'),
  dailyReward('Daily Reward');

  const GamificationEvent(this.displayName);
  
  final String displayName;
}

/// Gamification Event Data
class GamificationEventData {
  final GamificationEvent eventType;
  final String userId;
  final Map<String, dynamic> eventData;
  final DateTime timestamp;
  
  const GamificationEventData({
    required this.eventType,
    required this.userId,
    required this.eventData,
    required this.timestamp,
  });
}
