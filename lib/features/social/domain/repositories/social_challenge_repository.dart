import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/social_challenge.dart';
import '../../../../core/errors/failures.dart';

/// Repository interface for social challenges
abstract class SocialChallengeRepository {
  /// Get available challenges
  Future<Either<Failure, List<SocialChallenge>>> getChallenges({
    ChallengeStatus? status,
    ChallengeType? type,
    ChallengeDifficulty? difficulty,
    Map<String, dynamic>? filters,
    int? limit,
    int? offset,
  });

  /// Get challenge details
  Future<Either<Failure, SocialChallenge>> getChallengeDetails({
    required String challengeId,
  });

  /// Join a challenge
  Future<Either<Failure, void>> joinChallenge({
    required String challengeId,
    bool isTeamMember = false,
    String? teamId,
  });

  /// Leave a challenge
  Future<Either<Failure, void>> leaveChallenge({
    required String challengeId,
  });

  /// Get challenge leaderboard
  Future<Either<Failure, ChallengeLeaderboard>> getChallengeLeaderboard({
    required String challengeId,
    int? limit,
    bool includeCurrentUser = true,
  });

  /// Update challenge progress
  Future<Either<Failure, void>> updateProgress({
    required String challengeId,
    required String objectiveId,
    int? progressValue,
    bool isCompleted = false,
  });

  /// Get user's challenge history
  Future<Either<Failure, List<UserChallengeHistory>>> getUserChallengeHistory({
    String? userId,
    ChallengeStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  });

  /// Create custom challenge
  Future<Either<Failure, SocialChallenge>> createChallenge({
    required String title,
    String? description,
    required ChallengeType type,
    required ChallengeDifficulty difficulty,
    required DateTime startTime,
    required DateTime endTime,
    required List<ChallengeObjective> objectives,
    required List<ChallengeReward> rewards,
    ChallengeRules? rules,
    List<String>? tags,
    String? imageUrl,
    int? maxParticipants,
    bool allowTeams = false,
    int? teamSize,
    List<String>? prerequisites,
  });

  /// Delete challenge (creator only)
  Future<Either<Failure, void>> deleteChallenge({
    required String challengeId,
  });

  /// Report inappropriate challenge
  Future<Either<Failure, void>> reportChallenge({
    required String challengeId,
    required String reason,
    String? description,
  });

  /// Get challenge participants
  Future<Either<Failure, List<ChallengeParticipant>>> getParticipants({
    required String challengeId,
    int? limit,
    int? offset,
    ParticipantStatus? statusFilter,
  });

  /// Invite users to challenge
  Future<Either<Failure, void>> inviteToChallenge({
    required String challengeId,
    required List<String> userIds,
    String? message,
  });

  /// Get challenge recommendations
  Future<Either<Failure, List<SocialChallenge>>> getRecommendedChallenges({
    String? userId,
    int? limit,
  });

  /// Get featured challenges
  Future<Either<Failure, List<SocialChallenge>>> getFeaturedChallenges({
    int? limit,
  });

  /// Search challenges
  Future<Either<Failure, List<SocialChallenge>>> searchChallenges({
    required String query,
    ChallengeType? type,
    ChallengeDifficulty? difficulty,
    bool includeInactive = false,
    int? limit,
  });

  /// Get challenge categories and tags
  Future<Either<Failure, List<ChallengeCategory>>> getChallengeCategories();

  /// Get challenge stats for analytics
  Future<Either<Failure, ChallengeStats>> getChallengeStats({
    String? challengeId,
    StatsPeriod? period,
  });

  /// Check if user is eligible for challenge
  Future<Either<Failure, EligibilityCheck>> checkEligibility({
    required String challengeId,
    String? userId,
  });
}

/// User challenge history
class UserChallengeHistory extends Equatable {
  final String challengeId;
  final String challengeTitle;
  final ChallengeType type;
  final ChallengeDifficulty difficulty;
  final ParticipantStatus finalStatus;
  final DateTime joinedAt;
  final DateTime? completedAt;
  final int currentRank;
  final int totalParticipants;
  final double finalScore;
  final int completedObjectives;
  final List<ChallengeReward> earnedRewards;

  const UserChallengeHistory({
    required this.challengeId,
    required this.challengeTitle,
    required this.type,
    required this.difficulty,
    required this.finalStatus,
    required this.joinedAt,
    this.completedAt,
    required this.currentRank,
    required this.totalParticipants,
    required this.finalScore,
    required this.completedObjectives,
    required this.earnedRewards,
  });

  /// Get participation duration
  Duration? get participationDuration {
    if (completedAt == null) return null;
    return completedAt!.difference(joinedAt);
  }

  /// Get formatted participation duration
  String get formattedDuration {
    final duration = participationDuration;
    if (duration == null) return 'In Progress';
    
    if (duration.inDays > 0) {
      return '${duration.inDays}d ${duration.inHours % 24}h';
    } else if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes % 60}m';
    } else {
      return '${duration.inMinutes}m';
    }
  }

  /// Get percentile ranking
  double get percentileRanking {
    if (totalParticipants <= 1) return 100.0;
    return ((totalParticipants - currentRank) / (totalParticipants - 1)) * 100.0;
  }

  /// Check if user successfully completed challenge
  bool get wasSuccessful => finalStatus == ParticipantStatus.completed;

  /// Get success rate for objectives
  double get objectivesSuccessRate {
    // This would depend on total objectives from the challenge
    return 0.0; // Implementation needed
  }

  @override
  List<Object?> get props => [
        challengeId,
        challengeTitle,
        type,
        difficulty,
        finalStatus,
        joinedAt,
        completedAt,
        currentRank,
        totalParticipants,
        finalScore,
        completedObjectives,
        earnedRewards,
      ];
}

/// Challenge category
class ChallengeCategory extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String icon;
  final int challengeCount;
  final int activeChallengeCount;

  const ChallengeCategory({
    required this.id,
    required this.name,
    this.description,
    required this.icon,
    this.challengeCount = 0,
    this.activeChallengeCount = 0,
  });

  /// Check if category has active challenges
  bool get hasActiveChallenges => activeChallengeCount > 0;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        icon,
        challengeCount,
        activeChallengeCount,
      ];
}

/// Challenge statistics
class ChallengeStats extends Equatable {
  final int totalChallenges;
  final int activeChallenges;
  final int completedChallenges;
  final int totalParticipants;
  final int activeParticipants;
  final double averageCompletionRate;
  final Map<ChallengeType, int> typeDistribution;
  final Map<ChallengeDifficulty, int> difficultyDistribution;
  final List<StatsDataPoint> participationTrend;
  final List<StatsDataPoint> completionTrend;

  const ChallengeStats({
    required this.totalChallenges,
    required this.activeChallenges,
    required this.completedChallenges,
    required this.totalParticipants,
    required this.activeParticipants,
    required this.averageCompletionRate,
    required this.typeDistribution,
    required this.difficultyDistribution,
    required this.participationTrend,
    required this.completionTrend,
  });

  /// Get overall completion rate
  double get overallCompletionRate {
    if (totalChallenges == 0) return 0.0;
    return completedChallenges / totalChallenges * 100.0;
  }

  /// Get participation rate
  double get participationRate {
    if (totalChallenges == 0) return 0.0;
    return activeParticipants / totalParticipants * 100.0;
  }

  /// Get most popular challenge type
  ChallengeType? get mostPopularType {
    if (typeDistribution.isEmpty) return null;
    return typeDistribution.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  /// Get most popular difficulty
  ChallengeDifficulty? get mostPopularDifficulty {
    if (difficultyDistribution.isEmpty) return null;
    return difficultyDistribution.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  @override
  List<Object?> get props => [
        totalChallenges,
        activeChallenges,
        completedChallenges,
        totalParticipants,
        activeParticipants,
        averageCompletionRate,
        typeDistribution,
        difficultyDistribution,
        participationTrend,
        completionTrend,
      ];
}

/// Statistics data point
class StatsDataPoint extends Equatable {
  final DateTime date;
  final double value;
  final String? label;

  const StatsDataPoint({
    required this.date,
    required this.value,
    this.label,
  });

  @override
  List<Object?> get props => [date, value, label];
}

/// Eligibility check result
class EligibilityCheck extends Equatable {
  final bool isEligible;
  final List<String> reasons;
  final List<String> missingRequirements;

  const EligibilityCheck({
    required this.isEligible,
    required this.reasons,
    required this.missingRequirements,
  });

  /// Get first reason (primary)
  String get primaryReason => reasons.isNotEmpty ? reasons.first : '';

  @override
  List<Object?> get props => [isEligible, reasons, missingRequirements];
}

// Enums
enum StatsPeriod {
  daily,
  weekly,
  monthly,
  quarterly,
  yearly,
}

enum ParticipantStatus {
  notJoined,
  pending,
  active,
  completed,
  disqualified,
  withdrew,
}
