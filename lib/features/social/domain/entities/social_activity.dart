import 'package:equatable/equatable.dart';

/// Social Activity entity for tracking user social interactions
class SocialActivity extends Equatable {
  final String id;
  final String userId;
  final String username;
  final String? displayName;
  final String? avatarUrl;
  final ActivityType type;
  final String? targetUserId;
  final String? targetUsername;
  final String? targetDisplayName;
  final String? relatedEntityId;
  final String? relatedEntityType;
  final Map<String, dynamic> metadata;
  final DateTime timestamp;
  final bool isPublic;
  final int likes;
  final int comments;
  final bool isCurrentUserLiked;
  final List<String> viewers;

  const SocialActivity({
    required this.id,
    required this.userId,
    required this.username,
    this.displayName,
    this.avatarUrl,
    required this.type,
    this.targetUserId,
    this.targetUsername,
    this.targetDisplayName,
    this.relatedEntityId,
    this.relatedEntityType,
    this.metadata = const {},
    required this.timestamp,
    this.isPublic = true,
    this.likes = 0,
    this.comments = 0,
    this.isCurrentUserLiked = false,
    this.viewers = const [],
  });

  /// Get effective display name
  String get effectiveDisplayName => displayName?.isNotEmpty == true ? displayName! : username;

  /// Get target display name
  String get targetEffectiveDisplayName => targetDisplayName?.isNotEmpty == true 
      ? (targetDisplayName ?? targetUsername ?? 'Someone') 
      : (targetUsername ?? 'Someone');

  /// Get avatar with fallback
  String get effectiveAvatar => avatarUrl ?? _generateAvatar();

  /// Get activity description
  String get description {
    switch (type) {
      case ActivityType.lessonCompleted:
        return 'completed a lesson';
      case ActivityType.achievementUnlocked:
        return 'unlocked an achievement';
      case ActivityType.streakReached:
        final streak = metadata['streak'] as int?;
        return 'reached a ${streak ?? 0} day streak';
      case ActivityType.leveledUp:
        final level = metadata['level'] as int?;
        return 'reached level ${level ?? 1}';
      case ActivityType.friendsAdded:
        return 'became friends with ${targetEffectiveDisplayName}';
      case ActivityType.joinedStudyGroup:
        final groupName = metadata['groupName'] as String?;
        return 'joined study group ${groupName ?? ''}';
      case ActivityType.startedChallenge:
        final challengeName = metadata['challengeName'] as String?;
        return 'started challenge: ${challengeName ?? ''}';
      case ActivityType.completedChallenge:
        final challengeName = metadata['challengeName'] as String?;
        return 'completed challenge: ${challengeName ?? ''}';
      case ActivityType.pronunciationScore:
        final score = metadata['score'] as double?;
        return 'scored ${score?.toStringAsFixed(1) ?? 0.0} on pronunciation';
      case ActivityType.xpMilestone:
        final xp = metadata['xp'] as int?;
        return 'reached ${xp ?? 0} XP milestone';
      case ActivityType.certificateEarned:
        final certificateType = metadata['certificateType'] as String?;
        return 'earned ${certificateType ?? ''} certificate';
      case ActivityType.sharedProgress:
        return 'shared their learning progress';
      case ActivityType.joinedPlatform:
        return 'joined KataDia';
      case ActivityType.weeklyWinner:
        return 'won this week\'s challenge';
      case ActivityType.topPerformer:
        return 'became a top performer';
    }
  }

  /// Get full activity description with username
  String get fullDescription => '$effectiveDisplayName $description';

  /// Get activity category for organizing feed
  ActivityCategory get category {
    switch (type) {
      case ActivityType.lessonCompleted:
      case ActivityType.pronunciationScore:
        return ActivityCategory.learning;
      case ActivityType.achievementUnlocked:
      case ActivityType.leveledUp:
      case ActivityType.xpMilestone:
      case ActivityType.certificateEarned:
        return ActivityCategory.achievement;
      case ActivityType.friendsAdded:
      case ActivityType.joinedStudyGroup:
      case ActivityType.sharedProgress:
      case ActivityType.joinedPlatform:
        return ActivityCategory.social;
      case ActivityType.startedChallenge:
      case ActivityType.completedChallenge:
      case ActivityType.weeklyWinner:
      case ActivityType.topPerformer:
        return ActivityCategory.competition;
      case ActivityType.streakReached:
        return ActivityCategory.streak;
    }
  }

  /// Get formatted timestamp
  String get formattedTimestamp {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    if (difference.inDays < 30) return '${(difference.inDays / 7).floor()}w ago';
    return '${(difference.inDays / 30).floor()}mo ago';
  }

  /// Get formatted full date
  String get fullFormattedDate {
    final day = timestamp.day;
    final month = _getMonthName(timestamp.month);
    final year = timestamp.year;
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    
    return '$day $month $year - $hour:$minute';
  }

  /// Check if activity should be highlighted
  bool get shouldHighlight {
    switch (type) {
      case ActivityType.achievementUnlocked:
      case ActivityType.leveledUp:
      case ActivityType.weeklyWinner:
      case ActivityType.completedChallenge:
        return true;
      default:
        return false;
    }
  }

  /// Get activity icon
  String get iconName {
    switch (type) {
      case ActivityType.lessonCompleted:
        return 'book';
      case ActivityType.achievementUnlocked:
        return 'trophy';
      case ActivityType.streakReached:
        return 'streak';
      case ActivityType.leveledUp:
        return 'levelup';
      case ActivityType.friendsAdded:
        return 'friends';
      case ActivityType.joinedStudyGroup:
        return 'group';
      case ActivityType.startedChallenge:
        return 'rocket';
      case ActivityType.completedChallenge:
        return 'target';
      case ActivityType.pronunciationScore:
        return 'mic';
      case ActivityType.xpMilestone:
        return 'star';
      case ActivityType.certificateEarned:
        return 'certificate';
      case ActivityType.sharedProgress:
        return 'share';
      case ActivityType.joinedPlatform:
        return 'wave';
      case ActivityType.weeklyWinner:
        return 'crown';
      case ActivityType.topPerformer:
        return 'medal';
    }
  }

  /// Check if activity has related entity
  bool get hasRelatedEntity => relatedEntityId != null && relatedEntityType != null;

  /// Get formatted likes count
  String get formattedLikes {
    if (likes < 1000) return likes.toString();
    if (likes < 1000000) return '${(likes / 1000).toStringAsFixed(1)}K';
    return '${(likes / 1000000).toStringAsFixed(1)}M';
  }

  /// Get formatted comments count
  String get formattedComments {
    if (comments < 1000) return comments.toString();
    if (comments < 1000000) return '${(comments / 1000).toStringAsFixed(1)}K';
    return '${(comments / 1000000).toStringAsFixed(1)}M';
  }

  String _generateAvatar() {
    final initial = effectiveDisplayName.isNotEmpty ? effectiveDisplayName[0].toUpperCase() : 'U';
    return 'https://ui-avatars.com/api/?name=$initial&background=1976D2&color=fff&size=64';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  SocialActivity copyWith({
    String? id,
    String? userId,
    String? username,
    String? displayName,
    String? avatarUrl,
    ActivityType? type,
    String? targetUserId,
    String? targetUsername,
    String? targetDisplayName,
    String? relatedEntityId,
    String? relatedEntityType,
    Map<String, dynamic>? metadata,
    DateTime? timestamp,
    bool? isPublic,
    int? likes,
    int? comments,
    bool? isCurrentUserLiked,
    List<String>? viewers,
  }) {
    return SocialActivity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      type: type ?? this.type,
      targetUserId: targetUserId ?? this.targetUserId,
      targetUsername: targetUsername ?? this.targetUsername,
      targetDisplayName: targetDisplayName ?? this.targetDisplayName,
      relatedEntityId: relatedEntityId ?? this.relatedEntityId,
      relatedEntityType: relatedEntityType ?? this.relatedEntityType,
      metadata: metadata ?? this.metadata,
      timestamp: timestamp ?? this.timestamp,
      isPublic: isPublic ?? this.isPublic,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      isCurrentUserLiked: isCurrentUserLiked ?? this.isCurrentUserLiked,
      viewers: viewers ?? this.viewers,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        username,
        displayName,
        avatarUrl,
        type,
        targetUserId,
        targetUsername,
        targetDisplayName,
        relatedEntityId,
        relatedEntityType,
        metadata,
        timestamp,
        isPublic,
        likes,
        comments,
        isCurrentUserLiked,
        viewers,
      ];
}

/// Social comment entity
class SocialComment extends Equatable {
  final String id;
  final String activityId;
  final String userId;
  final String username;
  final String? displayName;
  final String? avatarUrl;
  final String content;
  final DateTime timestamp;
  final int likes;
  final bool isCurrentUserLiked;
  final String? parentCommentId;
  final List<SocialComment> replies;
  final bool isDeleted;

  const SocialComment({
    required this.id,
    required this.activityId,
    required this.userId,
    required this.username,
    this.displayName,
    this.avatarUrl,
    required this.content,
    required this.timestamp,
    this.likes = 0,
    this.isCurrentUserLiked = false,
    this.parentCommentId,
    this.replies = const [],
    this.isDeleted = false,
  });

  /// Get effective display name
  String get effectiveDisplayName => displayName?.isNotEmpty == true ? displayName! : username;

  /// Get avatar with fallback
  String get effectiveAvatar => avatarUrl ?? _generateAvatar();

  /// Get formatted timestamp
  String get formattedTimestamp {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    return '${(difference.inDays / 7).floor()}w ago';
  }

  /// Get formatted likes
  String get formattedLikes => likes.toString();

  /// Check if comment is a reply
  bool get isReply => parentCommentId != null;

  /// Get total replies count
  int get totalRepliesCount => replies.length;

  String _generateAvatar() {
    final initial = effectiveDisplayName.isNotEmpty ? effectiveDisplayName[0].toUpperCase() : 'U';
    return 'https://ui-avatars.com/api/?name=$initial&background=1976D2&color=fff&size=64';
  }

  SocialComment copyWith({
    String? id,
    String? activityId,
    String? userId,
    String? username,
    String? displayName,
    String? avatarUrl,
    String? content,
    DateTime? timestamp,
    int? likes,
    bool? isCurrentUserLiked,
    String? parentCommentId,
    List<SocialComment>? replies,
    bool? isDeleted,
  }) {
    return SocialComment(
      id: id ?? this.id,
      activityId: activityId ?? this.activityId,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes,
      isCurrentUserLiked: isCurrentUserLiked ?? this.isCurrentUserLiked,
      parentCommentId: parentCommentId ?? this.parentCommentId,
      replies: replies ?? this.replies,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        activityId,
        userId,
        username,
        displayName,
        avatarUrl,
        content,
        timestamp,
        likes,
        isCurrentUserLiked,
        parentCommentId,
        replies,
        isDeleted,
      ];
}

// Enums
enum ActivityType {
  lessonCompleted,
  achievementUnlocked,
  streakReached,
  leveledUp,
  friendsAdded,
  joinedStudyGroup,
  startedChallenge,
  completedChallenge,
  pronunciationScore,
  xpMilestone,
  certificateEarned,
  sharedProgress,
  joinedPlatform,
  weeklyWinner,
  topPerformer,
}

enum ActivityCategory {
  learning,
  achievement,
  social,
  competition,
  streak,
}
