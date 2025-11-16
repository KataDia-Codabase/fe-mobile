import 'package:equatable/equatable.dart';

/// Study Group entity for collaborative learning
class StudyGroup extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String createdById;
  final String createdByName;
  final GroupType type;
  final GroupVisibility visibility;
  final List<String> memberIds;
  final List<GroupMember> members;
  final int maxMembers;
  final DateTime createdAt;
  final DateTime? lastActivity;
  final GroupSettings settings;
  final List<Milestone> milestones;
  final List<GroupChallenge> activeChallenges;
  final String? avatarUrl;
  final List<String> tags;
  final Map<String, dynamic> metadata;
  final int? currentStreak;
  final double? averageProgress;
  final bool isCurrentUserMember;
  final GroupMembershipRole? currentUserRole;

  const StudyGroup({
    required this.id,
    required this.name,
    this.description,
    required this.createdById,
    required this.createdByName,
    this.type = GroupType.general,
    this.visibility = GroupVisibility.private,
    this.memberIds = const [],
    this.members = const [],
    this.maxMembers = 50,
    required this.createdAt,
    this.lastActivity,
    this.settings = const GroupSettings(),
    this.milestones = const [],
    this.activeChallenges = const [],
    this.avatarUrl,
    this.tags = const [],
    this.metadata = const {},
    this.currentStreak,
    this.averageProgress,
    this.isCurrentUserMember = false,
    this.currentUserRole,
  });

  /// Get display name with fallback
  String get groupDisplayName => name.isNotEmpty ? name : 'Study Group';

  /// Get member count
  int get memberCount => members.length;

  /// Check if group is full
  bool get isFull => memberCount >= maxMembers;

  /// Check if group is accepting new members
  bool get isAcceptingMembers => !isFull && (visibility == GroupVisibility.public || visibility == GroupVisibility.inviteOnly);

  /// Check if user has admin privileges
  bool get currentUserIsAdmin => currentUserRole == GroupMembershipRole.admin || currentUserRole == GroupMembershipRole.owner;

  /// Check if user is moderator or higher
  bool get currentUserCanModerate => currentUserIsAdmin || currentUserRole == GroupMembershipRole.moderator;

  /// Get group activity status
  GroupStatus get activityStatus {
    if (lastActivity == null) return GroupStatus.inactive;

    final now = DateTime.now();
    final difference = now.difference(lastActivity!);

    if (difference.inHours < 24) return GroupStatus.active;
    if (difference.inDays < 7) return GroupStatus.recentlyActive;
    if (difference.inDays < 30) return GroupStatus.somewhatActive;
    return GroupStatus.inactive;
  }

  /// Get formatted last activity
  String get formattedLastActivity {
    if (lastActivity == null) return 'No activity';

    final now = DateTime.now();
    final difference = now.difference(lastActivity!);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    if (difference.inDays < 30) return '${(difference.inDays / 7).floor()}w ago';
    return '${(difference.inDays / 30).floor()}mo ago';
  }

  /// Get group privacy descriptor
  String get privacyDescriptor {
    switch (visibility) {
      case GroupVisibility.public:
        return 'Public';
      case GroupVisibility.private:
        return 'Private';
      case GroupVisibility.inviteOnly:
        return 'Invite Only';
    }
  }

  /// Get group type display
  String get typeDisplay {
    switch (type) {
      case GroupType.general:
        return 'General';
      case GroupType.exam:
        return 'Exam Prep';
      case GroupType.vocabulary:
        return 'Vocabulary';
      case GroupType.pronunciation:
        return 'Pronunciation';
      case GroupType.grammar:
        return 'Grammar';
      case GroupType.conversation:
        return 'Conversation';
      case GroupType.cultural:
        return 'Cultural';
      case GroupType.business:
        return 'Business';
    }
  }

  /// Check if user can join the group
  JoinabilityStatus get canUserJoin {
    if (isCurrentUserMember) return JoinabilityStatus.alreadyMember;
    if (isFull) return JoinabilityStatus.groupFull;
    if (visibility == GroupVisibility.private) return JoinabilityStatus.private;
    return JoinabilityStatus.available;
  }

  /// Get group completion percentage
  double get completionPercentage {
    if (milestones.isEmpty) return 0.0;
    final completed = milestones.where((m) => m.isCompleted).length;
    return completed / milestones.length * 100.0;
  }

  /// Get group progress color
  String get progressColor {
    final progress = completionPercentage;
    if (progress >= 80) return '#4CAF50';
    if (progress >= 60) return '#2196F3';
    if (progress >= 40) return '#FF9800';
    return '#F44336';
  }

  /// Get average member progress
  double get averageMemberProgress {
    if (members.isEmpty) return 0.0;
    final totalProgress = members.fold(0.0, (sum, member) => sum + member.progress);
    return totalProgress / members.length;
  }

  StudyGroup copyWith({
    String? id,
    String? name,
    String? description,
    String? createdById,
    String? createdByName,
    GroupType? type,
    GroupVisibility? visibility,
    List<String>? memberIds,
    List<GroupMember>? members,
    int? maxMembers,
    DateTime? createdAt,
    DateTime? lastActivity,
    GroupSettings? settings,
    List<Milestone>? milestones,
    List<GroupChallenge>? activeChallenges,
    String? avatarUrl,
    List<String>? tags,
    Map<String, dynamic>? metadata,
    int? currentStreak,
    double? averageProgress,
    bool? isCurrentUserMember,
    GroupMembershipRole? currentUserRole,
  }) {
    return StudyGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdById: createdById ?? this.createdById,
      createdByName: createdByName ?? this.createdByName,
      type: type ?? this.type,
      visibility: visibility ?? this.visibility,
      memberIds: memberIds ?? this.memberIds,
      members: members ?? this.members,
      maxMembers: maxMembers ?? this.maxMembers,
      createdAt: createdAt ?? this.createdAt,
      lastActivity: lastActivity ?? this.lastActivity,
      settings: settings ?? this.settings,
      milestones: milestones ?? this.milestones,
      activeChallenges: activeChallenges ?? this.activeChallenges,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      tags: tags ?? this.tags,
      metadata: metadata ?? this.metadata,
      currentStreak: currentStreak ?? this.currentStreak,
      averageProgress: averageProgress ?? this.averageProgress,
      isCurrentUserMember: isCurrentUserMember ?? this.isCurrentUserMember,
      currentUserRole: currentUserRole ?? this.currentUserRole,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        createdById,
        createdByName,
        type,
        visibility,
        memberIds,
        members,
        maxMembers,
        createdAt,
        lastActivity,
        settings,
        milestones,
        activeChallenges,
        avatarUrl,
        tags,
        metadata,
        currentStreak,
        averageProgress,
        isCurrentUserMember,
        currentUserRole,
      ];
}

/// Group member information
class GroupMember extends Equatable {
  final String userId;
  final String username;
  final String? displayName;
  final String? avatarUrl;
  final GroupMembershipRole role;
  final DateTime joinedAt;
  final double progress;
  final int? xp;
  final String? cefrLevel;
  final int? streak;
  final bool isOnline;
  final DateTime? lastActivity;
  final Map<String, dynamic> contributions;

  const GroupMember({
    required this.userId,
    required this.username,
    this.displayName,
    this.avatarUrl,
    this.role = GroupMembershipRole.member,
    required this.joinedAt,
    this.progress = 0.0,
    this.xp,
    this.cefrLevel,
    this.streak,
    this.isOnline = false,
    this.lastActivity,
    this.contributions = const {},
  });

  /// Get display name with fallback
  String get effectiveDisplayName => displayName?.isNotEmpty == true ? displayName! : username;

  /// Get avatar with fallback
  String get effectiveAvatar => avatarUrl ?? _generateAvatar();

  /// Check if member is admin or higher
  bool get canModerate => role == GroupMembershipRole.admin || role == GroupMembershipRole.owner || role == GroupMembershipRole.moderator;

  /// Get role display name
  String get roleDisplayName {
    switch (role) {
      case GroupMembershipRole.owner:
        return 'Owner';
      case GroupMembershipRole.admin:
        return 'Admin';
      case GroupMembershipRole.moderator:
        return 'Moderator';
      case GroupMembershipRole.member:
        return 'Member';
      case GroupMembershipRole.pending:
        return 'Pending';
    }
  }

  /// Get activity status
  String get activityStatus {
    if (isOnline) return 'Online';
    if (lastActivity == null) return 'Never';

    final now = DateTime.now();
    final difference = now.difference(lastActivity!);

    if (difference.inDays < 1) return 'Today';
    if (difference.inDays < 7) return 'This week';
    if (difference.inDays < 30) return 'This month';
    return 'Inactive';
  }

  String _generateAvatar() {
    final initial = effectiveDisplayName.isNotEmpty ? effectiveDisplayName[0].toUpperCase() : 'U';
    return 'https://ui-avatars.com/api/?name=$initial&background=1976D2&color=fff&size=64';
  }

  @override
  List<Object?> get props => [
        userId,
        username,
        displayName,
        avatarUrl,
        role,
        joinedAt,
        progress,
        xp,
        cefrLevel,
        streak,
        isOnline,
        lastActivity,
        contributions,
      ];
}

/// Group milestones for tracking progress
class Milestone extends Equatable {
  final String id;
  final String title;
  final String? description;
  final MilestoneType type;
  final DateTime? deadline;
  final bool isCompleted;
  final DateTime? completedAt;
  final List<String> completedBy;
  final int targetValue;
  final int currentValue;
  final String? rewardDescription;

  const Milestone({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    this.deadline,
    this.isCompleted = false,
    this.completedAt,
    this.completedBy = const [],
    required this.targetValue,
    this.currentValue = 0,
    this.rewardDescription,
  });

  /// Get progress percentage
  double get progressPercentage {
    if (targetValue <= 0) return 0.0;
    return (currentValue / targetValue).clamp(0.0, 1.0) * 100.0;
  }

  /// Check if milestone is overdue
  bool get isOverdue {
    if (deadline == null || isCompleted) return false;
    return DateTime.now().isAfter(deadline!);
  }

  /// Get days remaining
  int get daysRemaining {
    if (deadline == null) return -1;
    final difference = deadline!.difference(DateTime.now());
    return difference.inDays;
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        type,
        deadline,
        isCompleted,
        completedAt,
        completedBy,
        targetValue,
        currentValue,
        rewardDescription,
      ];
}

/// Active group challenges
class GroupChallenge extends Equatable {
  final String id;
  final String title;
  final String description;
  final ChallengeType type;
  final DateTime startTime;
  final DateTime endTime;
  final int targetValue;
  final double currentProgress;
  final List<String> participants;
  final bool isActive;

  const GroupChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.startTime,
    required this.endTime,
    required this.targetValue,
    this.currentProgress = 0.0,
    this.participants = const [],
    this.isActive = true,
  });

  /// Get progress percentage
  double get progressPercentage => (currentProgress / targetValue).clamp(0.0, 1.0) * 100.0;

  /// Check if challenge is currently active
  bool get isCurrentlyActive {
    final now = DateTime.now();
    return now.isAfter(startTime) && now.isBefore(endTime) && isActive;
  }

  /// Get time remaining text
  String get timeRemaining {
    final now = DateTime.now();
    final remaining = endTime.difference(now);
    
    if (remaining.isNegative) return 'Ended';
    if (remaining.inDays > 0) return '${remaining.inDays}d remaining';
    if (remaining.inHours > 0) return '${remaining.inHours}h remaining';
    return '${remaining.inMinutes}m remaining';
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        type,
        startTime,
        endTime,
        targetValue,
        currentProgress,
        participants,
        isActive,
      ];
}

/// Group settings and preferences
class GroupSettings extends Equatable {
  final bool allowInvites;
  final bool requireApproval;
  final bool enableChat;
  final bool enableFileSharing;
  final bool enableVoiceMessages;
  final bool enableProgressSharing;
  final bool enableReminders;
  final String timezone;
  final String defaultLanguage;
  final List<String> allowedLanguages;
  final int challengeFrequency;
  final bool enableLeaderboard;

  const GroupSettings({
    this.allowInvites = true,
    this.requireApproval = false,
    this.enableChat = true,
    this.enableFileSharing = false,
    this.enableVoiceMessages = false,
    this.enableProgressSharing = true,
    this.enableReminders = true,
    this.timezone = 'UTC',
    this.defaultLanguage = 'en',
    this.allowedLanguages = const ['en', 'id'],
    this.challengeFrequency = 7, // days
    this.enableLeaderboard = true,
  });

  @override
  List<Object?> get props => [
        allowInvites,
        requireApproval,
        enableChat,
        enableFileSharing,
        enableVoiceMessages,
        enableProgressSharing,
        enableReminders,
        timezone,
        defaultLanguage,
        allowedLanguages,
        challengeFrequency,
        enableLeaderboard,
      ];
}

// Enums for study groups
enum GroupType {
  general,
  exam,
  vocabulary,
  pronunciation,
  grammar,
  conversation,
  cultural,
  business,
}

enum GroupVisibility {
  public,
  private,
  inviteOnly,
}

enum GroupStatus {
  active,
  recentlyActive,
  somewhatActive,
  inactive,
}

enum GroupMembershipRole {
  owner,
  admin,
  moderator,
  member,
  pending,
}

enum JoinabilityStatus {
  available,
  alreadyMember,
  groupFull,
  private,
  inviteOnly,
}

enum MilestoneType {
  lessons,
  pronunciation,
  streak,
  xp,
  participation,
  challenge,
}

enum ChallengeType {
  dailyPractice,
  weeklyGoal,
  pronunciation,
  vocabulary,
  conversation,
}
