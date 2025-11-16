import 'package:equatable/equatable.dart';

/// Leaderboard entity for competitive rankings
class Leaderboard extends Equatable {
  final String id;
  final String name;
  final LeaderboardType type;
  final LeaderboardScope scope;
  final LeaderboardPeriod period;
  final List<LeaderboardEntry> entries;
  final UserPosition? currentUserPosition;
  final DateTime lastUpdated;
  final int totalParticipants;
  final bool isActive;
  final String? description;
  final List<LeaderboardReward> rewards;
  final DateTime? startDate;
  final DateTime? endDate;
  final Map<String, dynamic> filters;

  const Leaderboard({
    required this.id,
    required this.name,
    this.type = LeaderboardType.global,
    this.scope = LeaderboardScope.weekly,
    this.period = LeaderboardPeriod.weekly,
    this.entries = const [],
    this.currentUserPosition,
    required this.lastUpdated,
    required this.totalParticipants,
    this.isActive = true,
    this.description,
    this.rewards = const [],
    this.startDate,
    this.endDate,
    this.filters = const {},
  });

  /// Check if leaderboard is currently active
  bool get isCurrentLeaderboard {
    if (!isActive) return false;
    if (startDate == null || endDate == null) return true;
    
    final now = DateTime.now();
    return now.isAfter(startDate!) && now.isBefore(endDate!);
  }

  /// Get display name for the leaderboard type
  String get typeDisplayName {
    switch (type) {
      case LeaderboardType.global:
        return 'Global';
      case LeaderboardType.friends:
        return 'Friends';
      case LeaderboardType.country:
        return 'Country';
      case LeaderboardType.studyGroup:
        return 'Study Group';
      case LeaderboardType.city:
        return 'City';
    }
  }

  /// Get display name for the scope
  String get scopeDisplayName {
    switch (scope) {
      case LeaderboardScope.daily:
        return 'Daily';
      case LeaderboardScope.weekly:
        return 'Weekly';
      case LeaderboardScope.monthly:
        return 'Monthly';
      case LeaderboardScope.allTime:
        return 'All Time';
    }
  }

  /// Get formatted leaderboard title
  String get formattedTitle => '$name - $scopeDisplayName';

  /// Get top entry (rank #1)
  LeaderboardEntry? get topEntry => entries.isNotEmpty ? entries.first : null;

  /// Get top 3 entries
  List<LeaderboardEntry> get topThree => entries.take(3).toList();

  /// Get entries around current user (user + 2 above + 2 below)
  List<LeaderboardEntry> get entriesAroundCurrentUser {
    if (currentUserPosition == null) return entries.take(5).toList();
    
    final userRank = currentUserPosition!.rank;
    final start = (userRank - 3).clamp(0, entries.length - 1);
    final end = (userRank + 2).clamp(start + 1, entries.length);
    
    return entries.sublist(start, end);
  }

  /// Check if current user is in top positions
  bool get currentUserIsTop => currentUserPosition != null && currentUserPosition!.rank <= 10;

  /// Get percentile of current user
  double? get currentUserPercentile {
    if (currentUserPosition == null || totalParticipants == 0) return null;
    return (totalParticipants - currentUserPosition!.rank) / totalParticipants * 100;
  }

  /// Check if leaderboard will end soon
  bool get endsSoon {
    if (endDate == null) return false;
    final now = DateTime.now();
    final difference = endDate!.difference(now);
    return difference.inDays <= 3;
  }

  /// Time until leaderboard ends
  String? get timeToEnd {
    if (endDate == null) return null;
    
    final now = DateTime.now();
    final difference = endDate!.difference(now);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ${difference.inHours % 24}h';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ${difference.inMinutes % 60}m';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'Soon';
    }
  }

  Leaderboard copyWith({
    String? id,
    String? name,
    LeaderboardType? type,
    LeaderboardScope? scope,
    LeaderboardPeriod? period,
    List<LeaderboardEntry>? entries,
    UserPosition? currentUserPosition,
    DateTime? lastUpdated,
    int? totalParticipants,
    bool? isActive,
    String? description,
    List<LeaderboardReward>? rewards,
    DateTime? startDate,
    DateTime? endDate,
    Map<String, dynamic>? filters,
  }) {
    return Leaderboard(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      scope: scope ?? this.scope,
      period: period ?? this.period,
      entries: entries ?? this.entries,
      currentUserPosition: currentUserPosition ?? this.currentUserPosition,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      totalParticipants: totalParticipants ?? this.totalParticipants,
      isActive: isActive ?? this.isActive,
      description: description ?? this.description,
      rewards: rewards ?? this.rewards,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      filters: filters ?? this.filters,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        scope,
        period,
        entries,
        currentUserPosition,
        lastUpdated,
        totalParticipants,
        isActive,
        description,
        rewards,
        startDate,
        endDate,
        filters,
      ];
}

/// Individual leaderboard entry
class LeaderboardEntry extends Equatable {
  final int rank;
  final String userId;
  final String username;
  final String? displayName;
  final String? avatarUrl;
  final double score;
  final String scoreType;
  final Map<String, dynamic> stats;
  final int? achievementCount;
  final int? streak;
  final String? cefrLevel;
  final bool isCurrentUser;
  final int? previousRank;
  final RankChange rankChange;
  final List<Badge> badges;

  const LeaderboardEntry({
    required this.rank,
    required this.userId,
    required this.username,
    this.displayName,
    this.avatarUrl,
    required this.score,
    required this.scoreType,
    this.stats = const {},
    this.achievementCount,
    this.streak,
    this.cefrLevel,
    this.isCurrentUser = false,
    this.previousRank,
    this.rankChange = RankChange.same,
    this.badges = const [],
  });

  /// Get effective display name
  String get effectiveDisplayName => displayName?.isNotEmpty == true ? displayName! : username;

  /// Get avatar with fallback
  String get effectiveAvatar => avatarUrl ?? _generateAvatar();

  /// Check if rank improved
  bool get rankImproved => rankChange == RankChange.up;

  /// Check if rank declined
  bool get rankDeclined => rankChange == RankChange.down;

  /// Get rank change indicator
  String get rankChangeIndicator {
    switch (rankChange) {
      case RankChange.up:
        return '↑';
      case RankChange.down:
        return '↓';
      case RankChange.same:
        return '—';
      case RankChange.newEntry:
        return 'New';
    }
  }

  /// Get formatted score
  String get formattedScore {
    switch (scoreType) {
      case 'xp':
        return '${score.toInt()} XP';
      case 'percentage':
        return '${score.toStringAsFixed(1)}%';
      case 'time':
        return '${(score / 60).toStringAsFixed(1)}h';
      default:
        return score.toStringAsFixed(0);
    }
  }

  /// Check if entry is in top 3
  bool get isTopThree => rank <= 3;

  /// Get medal for top 3
  String? get medal {
    if (!isTopThree) return null;
    switch (rank) {
      case 1:
        return '🥇';
      case 2:
        return '🥈';
      case 3:
        return '🥉';
      default:
        return null;
    }
  }

  String _generateAvatar() {
    final initial = effectiveDisplayName.isNotEmpty ? effectiveDisplayName[0].toUpperCase() : 'U';
    return 'https://ui-avatars.com/api/?name=$initial&background=1976D2&color=fff&size=64';
  }

  LeaderboardEntry copyWith({
    int? rank,
    String? userId,
    String? username,
    String? displayName,
    String? avatarUrl,
    double? score,
    String? scoreType,
    Map<String, dynamic>? stats,
    int? achievementCount,
    int? streak,
    String? cefrLevel,
    bool? isCurrentUser,
    int? previousRank,
    RankChange? rankChange,
    List<Badge>? badges,
  }) {
    return LeaderboardEntry(
      rank: rank ?? this.rank,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      score: score ?? this.score,
      scoreType: scoreType ?? this.scoreType,
      stats: stats ?? this.stats,
      achievementCount: achievementCount ?? this.achievementCount,
      streak: streak ?? this.streak,
      cefrLevel: cefrLevel ?? this.cefrLevel,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
      previousRank: previousRank ?? this.previousRank,
      rankChange: rankChange ?? this.rankChange,
      badges: badges ?? this.badges,
    );
  }

  @override
  List<Object?> get props => [
        rank,
        userId,
        username,
        displayName,
        avatarUrl,
        score,
        scoreType,
        stats,
        achievementCount,
        streak,
        cefrLevel,
        isCurrentUser,
        previousRank,
        rankChange,
        badges,
      ];
}

/// Current user's position in leaderboard
class UserPosition extends Equatable {
  final int rank;
  final String userId;
  final double score;
  final int totalParticipants;
  final int? previousRank;
  final RankChange rankChange;

  const UserPosition({
    required this.rank,
    required this.userId,
    required this.score,
    required this.totalParticipants,
    this.previousRank,
    this.rankChange = RankChange.same,
  });

  /// Get percentile of user
  double get percentile => (totalParticipants - rank) / totalParticipants * 100;

  /// Get percentile label
  String get percentileLabel {
    if (percentile >= 95) return 'Top 5%';
    if (percentile >= 90) return 'Top 10%';
    if (percentile >= 75) return 'Top 25%';
    if (percentile >= 50) return 'Top 50%';
    return 'Bottom 50%';
  }

  @override
  List<Object?> get props => [rank, userId, score, totalParticipants, previousRank, rankChange];
}

/// Leaderboard types
enum LeaderboardType {
  global,
  friends,
  country,
  studyGroup,
  city,
}

/// Leaderboard scopes
enum LeaderboardScope {
  daily,
  weekly,
  monthly,
  allTime,
}

/// Leaderboard periods
enum LeaderboardPeriod {
  daily,
  weekly,
  monthly,
}

/// Rank change indicators
enum RankChange {
  up,
  down,
  same,
  newEntry,
}

/// Leaderboard rewards
class LeaderboardReward extends Equatable {
  final int rankStart;
  final int rankEnd;
  final String rewardType;
  final int rewardValue;
  final String description;
  final String? iconUrl;

  const LeaderboardReward({
    required this.rankStart,
    required this.rankEnd,
    required this.rewardType,
    required this.rewardValue,
    required this.description,
    this.iconUrl,
  });

  @override
  List<Object?> get props => [rankStart, rankEnd, rewardType, rewardValue, description, iconUrl];
}

/// Badge entity for leaderboard entries
class Badge extends Equatable {
  final String id;
  final String name;
  final String? iconUrl;
  final String? description;
  final BadgeType type;
  final bool isRare;

  const Badge({
    required this.id,
    required this.name,
    this.iconUrl,
    this.description,
    required this.type,
    this.isRare = false,
  });

  @override
  List<Object?> get props => [id, name, iconUrl, description, type, isRare];
}

/// Badge types
enum BadgeType {
  achievement,
  skill,
  special,
  seasonal,
}
