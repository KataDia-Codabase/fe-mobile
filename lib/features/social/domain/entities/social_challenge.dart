import 'package:equatable/equatable.dart';

/// Social Challenge entity for community competitions
class SocialChallenge extends Equatable {
  final String id;
  final String title;
  final String? description;
  final ChallengeType type;
  final ChallengeDifficulty difficulty;
  final String? imageUrl;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime? registrationDeadline;
  final List<ChallengeObjective> objectives;
  final List<ChallengeReward> rewards;
  final ParticipantStatus currentUserStatus;
  final int totalParticipants;
  final int maxParticipants;
  final ChallengeRules rules;
  final List<String> tags;
  final bool isActive;
  final CreatorInfo createdBy;
  final ChallengeLeaderboard leaderboard;
  final List<String> prerequisites;
  final bool allowTeams;
  final int? teamSize;
  final List<ChallengeSponsor> sponsors;
  final Map<String, dynamic> metadata;

  const SocialChallenge({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    required this.difficulty,
    this.imageUrl,
    required this.startTime,
    required this.endTime,
    this.registrationDeadline,
    required this.objectives,
    required this.rewards,
    this.currentUserStatus = ParticipantStatus.notJoined,
    required this.totalParticipants,
    this.maxParticipants = 1000,
    required this.rules,
    this.tags = const [],
    this.isActive = true,
    required this.createdBy,
    required this.leaderboard,
    this.prerequisites = const [],
    this.allowTeams = false,
    this.teamSize,
    this.sponsors = const [],
    this.metadata = const {},
  });

  /// Get formatted challenge title with difficulty
  String get formattedTitle => '$title (${difficulty.displayName})';

  /// Check if challenge is currently active
  bool get isCurrentlyActive {
    final now = DateTime.now();
    return now.isAfter(startTime) && now.isBefore(endTime) && isActive;
  }

  /// Check if registration is open
  bool get isRegistrationOpen {
    if (registrationDeadline == null) return isCurrentlyActive;
    return DateTime.now().isBefore(registrationDeadline!);
  }

  /// Check if challenge is full
  bool get isFull => totalParticipants >= maxParticipants;

  /// Get challenge status
  ChallengeStatus get status {
    final now = DateTime.now();
    
    if (!isActive) return ChallengeStatus.cancelled;
    if (now.isBefore(startTime)) return ChallengeStatus.upcoming;
    if (now.isAfter(endTime)) return ChallengeStatus.completed;
    return ChallengeStatus.active;
  }

  /// Get status display name
  String get statusDisplayName {
    switch (status) {
      case ChallengeStatus.upcoming:
        return 'Starts Soon';
      case ChallengeStatus.active:
        return 'Active';
      case ChallengeStatus.completed:
        return 'Completed';
      case ChallengeStatus.cancelled:
        return 'Cancelled';
    }
  }

  /// Get time until challenge starts
  String get timeUntilStart {
    if (status != ChallengeStatus.upcoming) return '';
    
    final difference = startTime.difference(DateTime.now());
    if (difference.inDays > 0) return '${difference.inDays} days';
    if (difference.inHours > 0) return '${difference.inHours} hours';
    return '${difference.inMinutes} minutes';
  }

  /// Get time remaining in challenge
  String get timeRemaining {
    if (status != ChallengeStatus.active) return '';
    
    final difference = endTime.difference(DateTime.now());
    if (difference.inDays > 0) return '${difference.inDays}d ${difference.inHours % 24}h';
    if (difference.inHours > 0) return '${difference.inHours}h ${difference.inMinutes % 60}m';
    return '${difference.inMinutes}m';
  }

  /// Get progress for current user
  double get currentUserProgress {
    if (currentUserStatus == ParticipantStatus.notJoined) return 0.0;
    
    final completedObjectives = objectives.where((obj) => obj.isCompleted).length;
    return completedObjectives / objectives.length;
  }

  /// Check if user can join
  JoinabilityResult get canUserJoin {
    if (currentUserStatus != ParticipantStatus.notJoined) {
      return JoinabilityResult(
        canJoin: false,
        reason: 'Already participated',
      );
    }
    
    if (!isRegistrationOpen) {
      return JoinabilityResult(
        canJoin: false,
        reason: status != ChallengeStatus.upcoming ? 'Registration closed' : 'Challenge has ended',
      );
    }
    
    if (isFull) {
      return JoinabilityResult(
        canJoin: false,
        reason: 'Challenge is full',
      );
    }
    
    return const JoinabilityResult(canJoin: true, reason: '');
  }

  /// Get estimated duration
  Duration get estimatedDuration => endTime.difference(startTime);

  /// Get difficulty level description
  String get difficultyDescription {
    switch (difficulty) {
      case ChallengeDifficulty.beginner:
        return 'Great for newcomers';
      case ChallengeDifficulty.intermediate:
        return 'Some experience recommended';
      case ChallengeDifficulty.advanced:
        return 'Challenging for experienced users';
      case ChallengeDifficulty.expert:
        return 'Only for expert learners';
    }
  }

  /// Get total reward value
  int get totalRewardValue => rewards.fold(0, (sum, reward) => sum + reward.value);

  /// Get challenge type display
  String get typeDisplayName {
    switch (type) {
      case ChallengeType.pronunciation:
        return 'Pronunciation Challenge';
      case ChallengeType.vocabulary:
        return 'Vocabulary Challenge';
      case ChallengeType.streak:
        return 'Streak Challenge';
      case ChallengeType.practice:
        return 'Practice Challenge';
      case ChallengeType.social:
        return 'Social Challenge';
      case ChallengeType.learning:
        return 'Learning Challenge';
    }
  }

  SocialChallenge copyWith({
    String? id,
    String? title,
    String? description,
    ChallengeType? type,
    ChallengeDifficulty? difficulty,
    String? imageUrl,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? registrationDeadline,
    List<ChallengeObjective>? objectives,
    List<ChallengeReward>? rewards,
    ParticipantStatus? currentUserStatus,
    int? totalParticipants,
    int? maxParticipants,
    ChallengeRules? rules,
    List<String>? tags,
    bool? isActive,
    CreatorInfo? createdBy,
    ChallengeLeaderboard? leaderboard,
    List<String>? prerequisites,
    bool? allowTeams,
    int? teamSize,
    List<ChallengeSponsor>? sponsors,
    Map<String, dynamic>? metadata,
  }) {
    return SocialChallenge(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      difficulty: difficulty ?? this.difficulty,
      imageUrl: imageUrl ?? this.imageUrl,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      registrationDeadline: registrationDeadline ?? this.registrationDeadline,
      objectives: objectives ?? this.objectives,
      rewards: rewards ?? this.rewards,
      currentUserStatus: currentUserStatus ?? this.currentUserStatus,
      totalParticipants: totalParticipants ?? this.totalParticipants,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      rules: rules ?? this.rules,
      tags: tags ?? this.tags,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      leaderboard: leaderboard ?? this.leaderboard,
      prerequisites: prerequisites ?? this.prerequisites,
      allowTeams: allowTeams ?? this.allowTeams,
      teamSize: teamSize ?? this.teamSize,
      sponsors: sponsors ?? this.sponsors,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        type,
        difficulty,
        imageUrl,
        startTime,
        endTime,
        registrationDeadline,
        objectives,
        rewards,
        currentUserStatus,
        totalParticipants,
        maxParticipants,
        rules,
        tags,
        isActive,
        createdBy,
        leaderboard,
        prerequisites,
        allowTeams,
        teamSize,
        sponsors,
        metadata,
      ];
}

/// Individual challenge objectives
class ChallengeObjective extends Equatable {
  final String id;
  final String title;
  final String? description;
  final ObjectiveType type;
  final int targetValue;
  final int? currentValue;
  final String metric;
  final bool isMandatory;
  final bool isCompleted;
  final DateTime? completedAt;
  final Map<String, dynamic> criteria;

  const ChallengeObjective({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    required this.targetValue,
    this.currentValue = 0,
    required this.metric,
    this.isMandatory = true,
    this.isCompleted = false,
    this.completedAt,
    this.criteria = const {},
  });

  /// Get progress percentage
  double get progressPercentage {
    if (targetValue <= 0) return 0.0;
    final value = currentValue ?? 0;
    return (value / targetValue).clamp(0.0, 1.0) * 100.0;
  }

  /// Get formatted progress display
  String get progressDisplay => '${currentValue ?? 0} / $targetValue $metric';

  /// Get objective status
  ObjectiveStatus get status {
    if (isCompleted) return ObjectiveStatus.completed;
    if (currentValue == null || currentValue == 0) return ObjectiveStatus.notStarted;
    if (progressPercentage >= 50) return ObjectiveStatus.inProgressHalf;
    return ObjectiveStatus.inProgress;
  }

  ChallengeObjective copyWith({
    String? id,
    String? title,
    String? description,
    ObjectiveType? type,
    int? targetValue,
    int? currentValue,
    String? metric,
    bool? isMandatory,
    bool? isCompleted,
    DateTime? completedAt,
    Map<String, dynamic>? criteria,
  }) {
    return ChallengeObjective(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      targetValue: targetValue ?? this.targetValue,
      currentValue: currentValue ?? this.currentValue,
      metric: metric ?? this.metric,
      isMandatory: isMandatory ?? this.isMandatory,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      criteria: criteria ?? this.criteria,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        type,
        targetValue,
        currentValue,
        metric,
        isMandatory,
        isCompleted,
        completedAt,
        criteria,
      ];
}

/// Challenge rewards
class ChallengeReward extends Equatable {
  final String id;
  final RewardType type;
  final int value;
  final String description;
  final String? iconUrl;
  final bool isGuaranteed;
  final int? maxWinners;
  final DateTime? expiresAt;

  const ChallengeReward({
    required this.id,
    required this.type,
    required this.value,
    required this.description,
    this.iconUrl,
    this.isGuaranteed = true,
    this.maxWinners,
    this.expiresAt,
  });

  /// Get reward type display
  String get typeDisplayName {
    switch (type) {
      case RewardType.xp:
        return 'XP Points';
      case RewardType.badge:
        return 'Special Badge';
      case RewardType.streak:
        return 'Streak Bonus';
      case RewardType.unlock:
        return 'Feature Unlock';
      case RewardType.certificate:
        return 'Certificate';
      case RewardType.virtual:
        return 'Virtual Reward';
    }
  }

  /// Check if reward is expired
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  ChallengeReward copyWith({
    String? id,
    RewardType? type,
    int? value,
    String? description,
    String? iconUrl,
    bool? isGuaranteed,
    int? maxWinners,
    DateTime? expiresAt,
  }) {
    return ChallengeReward(
      id: id ?? this.id,
      type: type ?? this.type,
      value: value ?? this.value,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
      isGuaranteed: isGuaranteed ?? this.isGuaranteed,
      maxWinners: maxWinners ?? this.maxWinners,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        value,
        description,
        iconUrl,
        isGuaranteed,
        maxWinners,
        expiresAt,
      ];
}

/// Challenge creator information
class CreatorInfo extends Equatable {
  final String id;
  final String name;
  final String? avatarUrl;
  final CreatorType type;
  final bool isVerified;

  const CreatorInfo({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.type = CreatorType.system,
    this.isVerified = false,
  });

  /// Get creator type display
  String get typeDisplayName {
    switch (type) {
      case CreatorType.system:
        return 'Official Challenge';
      case CreatorType.teacher:
        return 'Teacher Created';
      case CreatorType.community:
        return 'Community Challenge';
      case CreatorType.sponsor:
        return 'Sponsored';
    }
  }

  CreatorInfo copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    CreatorType? type,
    bool? isVerified,
  }) {
    return CreatorInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      type: type ?? this.type,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  @override
  List<Object?> get props => [id, name, avatarUrl, type, isVerified];
}

/// Challenge leaderboard
class ChallengeLeaderboard extends Equatable {
  final List<ChallengeParticipant> participants;
  final ParticipantPosition? currentUserPosition;

  const ChallengeLeaderboard({
    this.participants = const [],
    this.currentUserPosition,
  });

  /// Get top participants
  List<ChallengeParticipant> get topParticipants => participants.take(10).toList();

  /// Get participants around current user
  List<ChallengeParticipant> get participantsAroundCurrentUser {
    if (currentUserPosition == null) return topParticipants;
    
    final userRank = currentUserPosition!.rank;
    final start = (userRank - 3).clamp(0, participants.length - 1);
    final end = (userRank + 2).clamp(start + 1, participants.length);
    
    return participants.sublist(start, end);
  }

  ChallengeLeaderboard copyWith({
    List<ChallengeParticipant>? participants,
    ParticipantPosition? currentUserPosition,
  }) {
    return ChallengeLeaderboard(
      participants: participants ?? this.participants,
      currentUserPosition: currentUserPosition ?? this.currentUserPosition,
    );
  }

  @override
  List<Object?> get props => [participants, currentUserPosition];
}

/// Individual participant in challenge
class ChallengeParticipant extends Equatable {
  final String userId;
  final String username;
  final String? displayName;
  final String? avatarUrl;
  final int rank;
  final double score;
  final int completedObjectives;
  final DateTime? joinedAt;
  final bool isCurrentUser;

  const ChallengeParticipant({
    required this.userId,
    required this.username,
    this.displayName,
    this.avatarUrl,
    required this.rank,
    required this.score,
    required this.completedObjectives,
    this.joinedAt,
    this.isCurrentUser = false,
  });

  /// Get effective display name
  String get effectiveDisplayName => displayName?.isNotEmpty == true ? displayName! : username;

  /// Get progress percentage
  double get progressPercentage {
    // This would be calculated based on challenge objectives
    return 0.0; // Implementation needed
  }

  ChallengeParticipant copyWith({
    String? userId,
    String? username,
    String? displayName,
    String? avatarUrl,
    int? rank,
    double? score,
    int? completedObjectives,
    DateTime? joinedAt,
    bool? isCurrentUser,
  }) {
    return ChallengeParticipant(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      rank: rank ?? this.rank,
      score: score ?? this.score,
      completedObjectives: completedObjectives ?? this.completedObjectives,
      joinedAt: joinedAt ?? this.joinedAt,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        username,
        displayName,
        avatarUrl,
        rank,
        score,
        completedObjectives,
        joinedAt,
        isCurrentUser,
      ];
}

/// Current user position in challenge
class ParticipantPosition extends Equatable {
  final int rank;
  final String userId;
  final double score;
  final int completedObjectives;
  final int totalParticipants;

  const ParticipantPosition({
    required this.rank,
    required this.userId,
    required this.score,
    required this.completedObjectives,
    required this.totalParticipants,
  });

  /// Get percentile
  double get percentile => (totalParticipants - rank) / totalParticipants * 100.0;

  ParticipantPosition copyWith({
    int? rank,
    String? userId,
    double? score,
    int? completedObjectives,
    int? totalParticipants,
  }) {
    return ParticipantPosition(
      rank: rank ?? this.rank,
      userId: userId ?? this.userId,
      score: score ?? this.score,
      completedObjectives: completedObjectives ?? this.completedObjectives,
      totalParticipants: totalParticipants ?? this.totalParticipants,
    );
  }

  @override
  List<Object?> get props => [rank, userId, score, completedObjectives, totalParticipants];
}

/// Challenge rules and requirements
class ChallengeRules extends Equatable {
  final String description;
  final List<String> requirements;
  final List<String> restrictions;
  final Duration? maxDailyTime;
  final int? maxAttempts;
  final bool requiresVerification;

  const ChallengeRules({
    required this.description,
    this.requirements = const [],
    this.restrictions = const [],
    this.maxDailyTime,
    this.maxAttempts,
    this.requiresVerification = false,
  });

  ChallengeRules copyWith({
    String? description,
    List<String>? requirements,
    List<String>? restrictions,
    Duration? maxDailyTime,
    int? maxAttempts,
    bool? requiresVerification,
  }) {
    return ChallengeRules(
      description: description ?? this.description,
      requirements: requirements ?? this.requirements,
      restrictions: restrictions ?? this.restrictions,
      maxDailyTime: maxDailyTime ?? this.maxDailyTime,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      requiresVerification: requiresVerification ?? this.requiresVerification,
    );
  }

  @override
  List<Object?> get props => [
        description,
        requirements,
        restrictions,
        maxDailyTime,
        maxAttempts,
        requiresVerification,
      ];
}

/// Challenge sponsor information
class ChallengeSponsor extends Equatable {
  final String id;
  final String name;
  final String? logoUrl;
  final String? website;
  final SponsorTier tier;

  const ChallengeSponsor({
    required this.id,
    required this.name,
    this.logoUrl,
    this.website,
    this.tier = SponsorTier.partner,
  });

  ChallengeSponsor copyWith({
    String? id,
    String? name,
    String? logoUrl,
    String? website,
    SponsorTier? tier,
  }) {
    return ChallengeSponsor(
      id: id ?? this.id,
      name: name ?? this.name,
      logoUrl: logoUrl ?? this.logoUrl,
      website: website ?? this.website,
      tier: tier ?? this.tier,
    );
  }

  @override
  List<Object?> get props => [id, name, logoUrl, website, tier];
}

/// Result for joinability check
class JoinabilityResult extends Equatable {
  final bool canJoin;
  final String reason;

  const JoinabilityResult({
    required this.canJoin,
    required this.reason,
  });

  @override
  List<Object?> get props => [canJoin, reason];
}

// Enums
enum ChallengeType {
  pronunciation,
  vocabulary,
  streak,
  practice,
  social,
  learning,
}

enum ChallengeDifficulty {
  beginner,
  intermediate,
  advanced,
  expert;

  String get displayName {
    switch (this) {
      case ChallengeDifficulty.beginner:
        return 'Beginner';
      case ChallengeDifficulty.intermediate:
        return 'Intermediate';
      case ChallengeDifficulty.advanced:
        return 'Advanced';
      case ChallengeDifficulty.expert:
        return 'Expert';
    }
  }
}

enum ChallengeStatus {
  upcoming,
  active,
  completed,
  cancelled,
}

enum ParticipantStatus {
  notJoined,
  pending,
  active,
  completed,
  disqualified,
}

enum ObjectiveType {
  lessons,
  pronunciation,
  vocabulary,
  streak,
  timeSpent,
  accuracy,
  social,
}

enum ObjectiveStatus {
  notStarted,
  inProgress,
  inProgressHalf,
  completed,
  failed,
}

enum RewardType {
  xp,
  badge,
  streak,
  unlock,
  certificate,
  virtual,
}

enum CreatorType {
  system,
  teacher,
  community,
  sponsor,
}

enum SponsorTier {
  title,
  gold,
  silver,
  partner,
}
