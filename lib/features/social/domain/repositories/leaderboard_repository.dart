import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/leaderboard.dart';
import '../../../../core/errors/failures.dart';

/// Repository interface for leaderboard management
abstract class LeaderboardRepository {
  /// Get leaderboard by type and scope
  Future<Either<Failure, Leaderboard>> getLeaderboard({
    required LeaderboardType type,
    required LeaderboardScope scope,
    Map<String, dynamic>? filters,
    int? limit,
  });

  /// Get current user's position across different leaderboards
  Future<Either<Failure, List<UserPosition>>> getCurrentUserPositions({
    List<LeaderboardType>? types,
    List<LeaderboardScope>? scopes,
  });

  /// Get leaderboard entries around current user's position
  Future<Either<Failure, List<LeaderboardEntry>>> getEntriesAroundCurrentUser({
    required LeaderboardType type,
    required LeaderboardScope scope,
    int range = 5,
  });

  /// Get top entries from leaderboard
  Future<Either<Failure, List<LeaderboardEntry>>> getTopEntries({
    required LeaderboardType type,
    required LeaderboardScope scope,
    int limit = 10,
  });

  /// Get leaderboard history for a user
  Future<Either<Failure, List<LeaderboardHistory>>> getLeaderboardHistory({
    required String userId,
    LeaderboardType? type,
    LeaderboardScope? scope,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  });

  /// Search for users in leaderboard
  Future<Either<Failure, List<LeaderboardEntry>>> searchUsers({
    required LeaderboardType type,
    required LeaderboardScope scope,
    required String query,
    int? limit,
  });

  /// Get available leaderboard types
  Future<Either<Failure, List<LeaderboardType>>> getAvailableTypes();

  /// Get leaderboard statistics and insights
  Future<Either<Failure, LeaderboardStats>> getLeaderboardStats({
    required LeaderboardType type,
    required LeaderboardScope scope,
  });

  /// Get leaderboard rewards
  Future<Either<Failure, List<LeaderboardReward>>> getLeaderboardRewards({
    required LeaderboardType type,
    required LeaderboardScope scope,
    int? userRank,
  });

  /// Refresh leaderboard data
  Future<Either<Failure, Leaderboard>> refreshLeaderboard({
    required LeaderboardType type,
    required LeaderboardScope scope,
  });

  /// Check if user is eligible for rewards
  Future<Either<Failure, bool>> isEligibleForReward({
    required String userId,
    required LeaderboardType type,
    required LeaderboardScope scope,
    int? rank,
  });

  /// Get leaderboard participation trends
  Future<Either<Failure, LeaderboardTrendData>> getParticipationTrends({
    required LeaderboardType type,
    required LeaderboardScope scope,
    TrendPeriod? period,
  });

  /// Get user's rank history over time
  Future<Either<Failure, List<RankSnapshot>>> getUserRankHistory({
    required String userId,
    required LeaderboardType type,
    required LeaderboardScope scope,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get leaderboard social features (friends rankings)
  Future<Either<Failure, List<LeaderboardEntry>>> getFriendsLeaderboard({
    required LeaderboardType type,
    required LeaderboardScope scope,
  });

  /// Create or update custom leaderboard
  Future<Either<Failure, Leaderboard>> createCustomLeaderboard({
    required String name,
    required LeaderboardType type,
    required LeaderboardScope scope,
    String? description,
    Map<String, dynamic>? filters,
  });

  /// Join leaderboard participation
  Future<Either<Failure, void>> joinLeaderboard({
    required LeaderboardType type,
    required LeaderboardScope scope,
    bool optIn = true,
  });

  /// Get leaderboard ranking algorithm explanation
  Future<Either<Failure, String>> getRankingExplanation({
    required LeaderboardType type,
    required LeaderboardScope scope,
  });
}

/// Leaderboard history entry
class LeaderboardHistory extends Equatable {
  final DateTime date;
  final int rank;
  final double score;
  final int totalParticipants;
  final int rankChange;
  final double scoreChange;

  const LeaderboardHistory({
    required this.date,
    required this.rank,
    required this.score,
    required this.totalParticipants,
    required this.rankChange,
    required this.scoreChange,
  });

  /// Get percentile for this history entry
  double get percentile => (totalParticipants - rank) / totalParticipants * 100.0;

  /// Check if rank improved
  bool get rankImproved => rankChange > 0;

  /// Check if score improved
  bool get scoreImproved => scoreChange > 0;

  /// Get rank change indicator
  String get rankChangeIndicator {
    if (rankChange > 0) return '↑$rankChange';
    if (rankChange < 0) return '↓${rankChange.abs()}';
    return '—';
  }

  @override
  List<Object?> get props => [date, rank, score, totalParticipants, rankChange, scoreChange];
}

/// Leaderboard statistics
class LeaderboardStats extends Equatable {
  final int totalParticipants;
  final double averageScore;
  final double medianScore;
  final double topScore;
  final double bottomScore;
  final int activeParticipants;
  final int newParticipants;
  final double participationRate;
  final Map<String, int> scoreDistribution;
  final List<String> topCountries;
  final List<String> topCities;

  const LeaderboardStats({
    required this.totalParticipants,
    required this.averageScore,
    required this.medianScore,
    required this.topScore,
    required this.bottomScore,
    required this.activeParticipants,
    required this.newParticipants,
    required this.participationRate,
    required this.scoreDistribution,
    required this.topCountries,
    required this.topCities,
  });

  /// Get score range
  double get scoreRange => topScore - bottomScore;

  /// Get score distribution labels
  List<String> get scoreLabels => scoreDistribution.keys.toList();

  /// Get score distribution values
  List<int> get scoreValues => scoreDistribution.values.toList();

  @override
  List<Object?> get props => [
        totalParticipants,
        averageScore,
        medianScore,
        topScore,
        bottomScore,
        activeParticipants,
        newParticipants,
        participationRate,
        scoreDistribution,
        topCountries,
        topCities,
      ];
}

/// Leaderboard trend data
class LeaderboardTrendData extends Equatable {
  final TrendPeriod period;
  final List<TrendPoint> participationTrend;
  final List<TrendPoint> averageScoreTrend;
  final List<TrendPoint> newUsersTrend;
  final Map<String, List<TrendPoint>> categoryTrends;

  const LeaderboardTrendData({
    required this.period,
    required this.participationTrend,
    required this.averageScoreTrend,
    required this.newUsersTrend,
    required this.categoryTrends,
  });

  /// Get overall growth trend
  TrendDirection get partGrowthTrend {
    if (participationTrend.length < 2) return TrendDirection.stable;
    final start = participationTrend.first.value;
    final end = participationTrend.last.value;
    if (end > start * 1.1) return TrendDirection.growing;
    if (end < start * 0.9) return TrendDirection.declining;
    return TrendDirection.stable;
  }

  /// Get percentage growth
  double get participationGrowthPercentage {
    if (participationTrend.length < 2) return 0.0;
    final start = participationTrend.first.value;
    final end = participationTrend.last.value;
    return ((end - start) / start * 100).clamp(-100.0, 100.0);
  }

  @override
  List<Object?> get props => [
        period,
        participationTrend,
        averageScoreTrend,
        newUsersTrend,
        categoryTrends,
      ];
}

/// Single trend point
class TrendPoint extends Equatable {
  final DateTime date;
  final double value;

  const TrendPoint({
    required this.date,
    required this.value,
  });

  @override
  List<Object?> get props => [date, value];
}

/// User rank snapshot over time
class RankSnapshot extends Equatable {
  final DateTime timestamp;
  final int rank;
  final double score;
  final int totalParticipants;
  final int percentile;

  const RankSnapshot({
    required this.timestamp,
    required this.rank,
    required this.score,
    required this.totalParticipants,
    required this.percentile,
  });

  /// Check if rank improved from previous snapshot
  bool improvedFrom(RankSnapshot previous) => rank < previous.rank;

  /// Get rank change from previous snapshot
  int rankChangeFrom(RankSnapshot previous) => previous.rank - rank;

  /// Get score change from previous snapshot
  double scoreChangeFrom(RankSnapshot previous) => score - previous.score;

  @override
  List<Object?> get props => [timestamp, rank, score, totalParticipants, percentile];
}

/// Trend direction enumeration
enum TrendDirection {
  growing,
  stable,
  declining,
}

/// Time periods for trend analysis
enum TrendPeriod {
  daily,
  weekly,
  monthly,
  quarterly,
  yearly,
}
