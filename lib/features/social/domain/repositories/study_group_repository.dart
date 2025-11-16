import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/study_group.dart';
import '../entities/social_challenge.dart' as challenge;
import '../../../../core/errors/failures.dart';

/// Repository interface for study group management
abstract class StudyGroupRepository {
  /// Get study groups for current user
  Future<Either<Failure, List<StudyGroup>>> getUserGroups({
    GroupStatus? status,
    GroupType? type,
    int? limit,
    int? offset,
  });

  /// Get discoverable study groups
  Future<Either<Failure, List<StudyGroup>>> getDiscoverableGroups({
    GroupType? type,
    String? query,
    bool orderByRecentActivity = true,
    int? limit,
  });

  /// Create new study group
  Future<Either<Failure, StudyGroup>> createStudyGroup({
    required String name,
    String? description,
    required GroupType type,
    GroupVisibility visibility = GroupVisibility.private,
    int? maxMembers,
    List<String>? tags,
    GroupSettings? settings,
  });

  /// Get study group details
  Future<Either<Failure, StudyGroup>> getStudyGroupDetails({
    required String groupId,
  });

  /// Join a study group
  Future<Either<Failure, void>> joinStudyGroup({
    required String groupId,
    String? inviteCode,
    String? message,
  });

  /// Leave a study group
  Future<Either<Failure, void>> leaveStudyGroup({
    required String groupId,
  });

  /// Update study group information
  Future<Either<Failure, StudyGroup>> updateStudyGroup({
    required String groupId,
    String? name,
    String? description,
    GroupVisibility? visibility,
    int? maxMembers,
    List<String>? tags,
    GroupSettings? settings,
  });

  /// Invite members to study group
  Future<Either<Failure, void>> inviteMembers({
    required String groupId,
    required List<String> userIds,
    String? message,
  });

  /// Accept study group invitation
  Future<Either<Failure, void>> acceptInvitation({
    required String groupId,
  });

  /// Decline study group invitation
  Future<Either<Failure, void>> declineInvitation({
    required String groupId,
  });

  /// Get group members
  Future<Either<Failure, List<GroupMember>>> getGroupMembers({
    required String groupId,
    GroupMembershipRole? roleFilter,
    int? limit,
    int? offset,
  });

  /// Update member role
  Future<Either<Failure, void>> updateMemberRole({
    required String groupId,
    required String userId,
    required GroupMembershipRole newRole,
  });

  /// Remove member from group
  Future<Either<Failure, void>> removeMember({
    required String groupId,
    required String userId,
  });

  /// Get group milestones
  Future<Either<Failure, List<Milestone>>> getGroupMilestones({
    required String groupId,
    bool includeCompleted = true,
  });

  /// Create group milestone
  Future<Either<Failure, Milestone>> createMilestone({
    required String groupId,
    required String title,
    String? description,
    required MilestoneType type,
    required int targetValue,
    DateTime? deadline,
    String? rewardDescription,
  });

  /// Update milestone progress
  Future<Either<Failure, void>> updateMilestoneProgress({
    required String groupId,
    required String milestoneId,
    required int progressValue,
  });

  /// Get group challenges
  Future<Either<Failure, List<GroupChallenge>>> getGroupChallenges({
    required String groupId,
    challenge.ChallengeStatus? status,
    int? limit,
  });

  /// Create group challenge
  Future<Either<Failure, GroupChallenge>> createChallenge({
    required String groupId,
    required String title,
    required String description,
    required challenge.ChallengeType type,
    required DateTime startTime,
    required DateTime endTime,
    required int targetValue,
    List<String>? tags,
  });

  /// Participate in group challenge
  Future<Either<Failure, void>> joinChallenge({
    required String groupId,
    required String challengeId,
  });

  /// Get group activity feed
  Future<Either<Failure, List<GroupActivity>>> getGroupActivities({
    required String groupId,
    int? limit,
    DateTime? after,
  });

  /// Post message to group chat
  Future<Either<Failure, GroupChatMessage>> postMessage({
    required String groupId,
    required String content,
    MessageType type = MessageType.text,
    String? attachmentUrl,
  });

  /// Get group messages
  Future<Either<Failure, List<GroupChatMessage>>> getGroupMessages({
    required String groupId,
    DateTime? after,
    int? limit,
  });

  /// Upload file to group
  Future<Either<Failure, String>> uploadGroupFile({
    required String groupId,
    required String fileName,
    required List<int> fileBytes,
    String? contentType,
  });

  /// Get group files
  Future<Either<Failure, List<GroupFile>>> getGroupFiles({
    required String groupId,
    String? category,
    int? limit,
  });

  /// Delete group file
  Future<Either<Failure, void>> deleteGroupFile({
    required String groupId,
    required String fileId,
  });

  /// Get group analytics
  Future<Either<Failure, GroupAnalytics>> getGroupAnalytics({
    required String groupId,
    DateTimeRange? dateRange,
  });

  /// Search study groups
  Future<Either<Failure, List<StudyGroup>>> searchGroups({
    required String query,
    GroupType? type,
    GroupVisibility? visibility,
    bool includeFull = false,
    int? limit,
  });

  /// Get user's group invitations
  Future<Either<Failure, List<GroupInvitation>>> getGroupInvitations({
    InvitationStatus? status,
    int? limit,
  });

  /// Generate invite code for group
  Future<Either<Failure, String>> generateInviteCode({
    required String groupId,
    int? maxUses,
    DateTime? expiresAt,
  });

  /// Validate invite code
  Future<Either<Failure, StudyGroup>> validateInviteCode({
    required String code,
  });

  /// Transfer group ownership
  Future<Either<Failure, void>> transferOwnership({
    required String groupId,
    required String newOwnerId,
  });

  /// Archive or unarchive group
  Future<Either<Failure, void>> setGroupArchiveStatus({
    required String groupId,
    required bool isArchived,
  });

  /// Report inappropriate group content
  Future<Either<Failure, void>> reportGroupContent({
    required String groupId,
    required String reason,
    String? description,
    String? contentId,
  });
}

/// Group activity entity
class GroupActivity extends Equatable {
  final String id;
  final String groupId;
  final String userId;
  final String username;
  final String? displayName;
  final GroupActivityType type;
  final String? description;
  final Map<String, dynamic> metadata;
  final DateTime timestamp;

  const GroupActivity({
    required this.id,
    required this.groupId,
    required this.userId,
    required this.username,
    this.displayName,
    required this.type,
    this.description,
    this.metadata = const {},
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
        id,
        groupId,
        userId,
        username,
        displayName,
        type,
        description,
        metadata,
        timestamp,
      ];
}

/// Group chat message entity
class GroupChatMessage extends Equatable {
  final String id;
  final String groupId;
  final String userId;
  final String username;
  final String? displayName;
  final String? avatarUrl;
  final String content;
  final MessageType type;
  final String? attachmentUrl;
  final DateTime timestamp;
  final bool isEdited;
  final DateTime? editedAt;
  final bool isDeleted;
  final List<String> reactions;

  const GroupChatMessage({
    required this.id,
    required this.groupId,
    required this.userId,
    required this.username,
    this.displayName,
    this.avatarUrl,
    required this.content,
    this.type = MessageType.text,
    this.attachmentUrl,
    required this.timestamp,
    this.isEdited = false,
    this.editedAt,
    this.isDeleted = false,
    this.reactions = const [],
  });

  /// Get effective display name
  String get effectiveDisplayName => displayName?.isNotEmpty == true ? displayName! : username;

  /// Get formatted timestamp
  String get formattedTimestamp {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }

  @override
  List<Object?> get props => [
        id,
        groupId,
        userId,
        username,
        displayName,
        avatarUrl,
        content,
        type,
        attachmentUrl,
        timestamp,
        isEdited,
        editedAt,
        isDeleted,
        reactions,
      ];
}

/// Group file entity
class GroupFile extends Equatable {
  final String id;
  final String groupId;
  final String userId;
  final String username;
  final String filename;
  final String url;
  final String contentType;
  final int sizeBytes;
  final String? category;
  final DateTime uploadedAt;
  final int downloadCount;
  final bool isDeleted;

  const GroupFile({
    required this.id,
    required this.groupId,
    required this.userId,
    required this.username,
    required this.filename,
    required this.url,
    required this.contentType,
    required this.sizeBytes,
    this.category,
    required this.uploadedAt,
    this.downloadCount = 0,
    this.isDeleted = false,
  });

  /// Get formatted file size
  String get formattedSize {
    if (sizeBytes < 1024) return '$sizeBytes B';
    if (sizeBytes < 1048576) return '${(sizeBytes / 1024).toStringAsFixed(1)} KB';
    return '${(sizeBytes / 1048576).toStringAsFixed(1)} MB';
  }

  @override
  List<Object?> get props => [
        id,
        groupId,
        userId,
        username,
        filename,
        url,
        contentType,
        sizeBytes,
        category,
        uploadedAt,
        downloadCount,
        isDeleted,
      ];
}

/// Group analytics entity
class GroupAnalytics extends Equatable {
  final String groupId;
  final DateTimeRange dateRange;
  final int activeMembers;
  final int totalMessages;
  final List<ChatActivity> chatActivity;
  final List<ProgressData> memberProgress;
  final Map<String, int> goalCompletion;
  final double engagementScore;

  const GroupAnalytics({
    required this.groupId,
    required this.dateRange,
    required this.activeMembers,
    required this.totalMessages,
    required this.chatActivity,
    required this.memberProgress,
    required this.goalCompletion,
    required this.engagementScore,
  });

  @override
  List<Object?> get props => [
        groupId,
        dateRange,
        activeMembers,
        totalMessages,
        chatActivity,
        memberProgress,
        goalCompletion,
        engagementScore,
      ];
}

/// Group invitation entity
class GroupInvitation extends Equatable {
  final String id;
  final String groupId;
  final GroupSummary group;
  final String invitedById;
  final String invitedByName;
  final String? invitedByAvatar;
  final InvitationStatus status;
  final DateTime sentAt;
  final DateTime? respondedAt;
  final String? message;

  const GroupInvitation({
    required this.id,
    required this.groupId,
    required this.group,
    required this.invitedById,
    required this.invitedByName,
    this.invitedByAvatar,
    required this.status,
    required this.sentAt,
    this.respondedAt,
    this.message,
  });

  @override
  List<Object?> get props => [
        id,
        groupId,
        group,
        invitedById,
        invitedByName,
        invitedByAvatar,
        status,
        sentAt,
        respondedAt,
        message,
      ];
}

/// Supporting classes
class ChatActivity extends Equatable {
  final DateTime date;
  final int messageCount;
  final int uniqueParticipants;

  const ChatActivity({
    required this.date,
    required this.messageCount,
    required this.uniqueParticipants,
  });

  @override
  List<Object?> get props => [date, messageCount, uniqueParticipants];
}

class ProgressData extends Equatable {
  final String userId;
  final String username;
  final double averageProgress;
  final int lessonsCompleted;
  final int streak;

  const ProgressData({
    required this.userId,
    required this.username,
    required this.averageProgress,
    required this.lessonsCompleted,
    required this.streak,
  });

  @override
  List<Object?> get props => [userId, username, averageProgress, lessonsCompleted, streak];
}

class DateTimeRange extends Equatable {
  final DateTime start;
  final DateTime end;

  const DateTimeRange({
    required this.start,
    required this.end,
  });

  /// Get duration
  Duration get duration => end.difference(start);

  @override
  List<Object?> get props => [start, end];
}

class GroupSummary extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String? avatarUrl;
  final int memberCount;
  final GroupType type;
  final GroupVisibility visibility;

  const GroupSummary({
    required this.id,
    required this.name,
    this.description,
    this.avatarUrl,
    required this.memberCount,
    required this.type,
    required this.visibility,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        avatarUrl,
        memberCount,
        type,
        visibility,
      ];
}

// Enums
enum GroupActivityType {
  memberJoined,
  memberLeft,
  milestoneCompleted,
  challengeStarted,
  challengeCompleted,
  messagePosted,
  fileUploaded,
  groupCreated,
}

enum MessageType {
  text,
  image,
  audio,
  file,
  system,
}

enum InvitationStatus {
  pending,
  accepted,
  declined,
  expired,
}
