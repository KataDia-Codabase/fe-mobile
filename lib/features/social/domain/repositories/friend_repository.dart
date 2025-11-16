import 'package:dartz/dartz.dart';
import '../entities/friend.dart';
import '../../../../core/errors/failures.dart';

/// Repository interface for friend management
abstract class FriendRepository {
  /// Get list of friends for current user
  Future<Either<Failure, List<Friend>>> getFriends({
    FriendStatus? status,
    bool includeBlocked = false,
    int? limit,
    int? offset,
  });

  /// Get friend suggestions based on mutual connections and preferences
  Future<Either<Failure, List<Friend>>> getFriendSuggestions({
    int? limit,
    List<String>? excludeIds,
  });

  /// Search for users by username or display name
  Future<Either<Failure, List<Friend>>> searchUsers({
    required String query,
    int? limit,
    int? offset,
  });

  /// Send friend request to a user
  Future<Either<Failure, void>> sendFriendRequest({
    required String userId,
    String? message,
  });

  /// Accept incoming friend request
  Future<Either<Failure, void>> acceptFriendRequest({
    required String requestId,
  });

  /// Decline incoming friend request
  Future<Either<Failure, void>> declineFriendRequest({
    required String requestId,
  });

  /// Cancel sent friend request
  Future<Either<Failure, void>> cancelFriendRequest({
    required String requestId,
  });

  /// Unfriend someone
  Future<Either<Failure, void>> unfriend({
    required String userId,
  });

  /// Block a user
  Future<Either<Failure, void>> blockUser({
    required String userId,
  });

  /// Unblock a user
  Future<Either<Failure, void>> unblockUser({
    required String userId,
  });

  /// Get mutual friends with another user
  Future<Either<Failure, List<Friend>>> getMutualFriends({
    required String userId,
  });

  /// Update privacy settings for a friendship
  Future<Either<Failure, void>> updateFriendPrivacySettings({
    required String userId,
    required PrivacySettings settings,
  });

  /// Get detailed information about a friend
  Future<Either<Failure, Friend>> getFriendDetails({
    required String userId,
  });

  /// Report inappropriate friend behavior
  Future<Either<Failure, void>> reportFriend({
    required String userId,
    required String reason,
    String? description,
  });

  /// Get friend requests (both sent and received)
  Future<Either<Failure, List<Friend>>> getFriendRequests({
    RequestType? type,
    int? limit,
    int? offset,
  });

  /// Check if user is already a friend
  Future<Either<Failure, bool>> isFriend({
    required String userId,
  });

  /// Get friendship level and interaction history
  Future<Either<Failure, FriendshipStats>> getFriendshipStats({
    required String userId,
  });

  /// Update friend's nickname (display name in your friend list)
  Future<Either<Failure, void>> updateFriendNickname({
    required String userId,
    required String nickname,
  });

  /// Mute/unmute friend activities
  Future<Either<Failure, void>> muteFriendActivities({
    required String userId,
    required bool isMuted,
  });
}

/// Friendship statistics and interaction data
class FriendshipStats extends Friend {
  final DateTime friendsSince;
  final int totalInteractions;
  final DateTime? lastInteraction;
  final List<String> sharedGroups;
  final int challengesCompletedTogether;
  final double similarityScore;
  final Map<String, dynamic> interactionBreakdown;

  const FriendshipStats({
    required super.id,
    required super.userId,
    required super.friendId,
    required super.username,
    required super.displayName,
    super.avatarUrl,
    super.status = FriendStatus.friends,
    super.xp,
    super.level,
    super.streak,
    super.cefrLevel,
    super.friendshipLevel,
    required this.friendsSince,
    this.totalInteractions = 0,
    this.lastInteraction,
    this.sharedGroups = const [],
    this.challengesCompletedTogether = 0,
    this.similarityScore = 0.0,
    this.interactionBreakdown = const {},
  });

  /// Get friendship duration
  Duration get friendshipDuration => DateTime.now().difference(friendsSince);

  /// Get formatted friendship duration
  String get formattedDuration {
    final duration = friendshipDuration;
    if (duration.inDays > 365) {
      final years = duration.inDays ~/ 365;
      final remainingDays = duration.inDays % 365;
      return years > 1 ? '$years years $remainingDays days' : '$years year $remainingDays days';
    } else if (duration.inDays > 30) {
      return '${duration.inDays ~/ 30} months';
    } else {
      return '${duration.inDays} days';
    }
  }

  /// Get interaction frequency score
  double get interactionFrequency {
    if (totalInteractions == 0) return 0.0;
    final daysSinceFriends = friendshipDuration.inDays;
    return totalInteractions / daysSinceFriends;
  }

  /// Check if friendship is strong based on multiple factors
  bool get isStrongFriendship {
    return similarityScore > 0.7 &&
           interactionFrequency > 0.5 &&
           sharedGroups.isNotEmpty &&
           challengesCompletedTogether > 0;
  }
}

/// Types of friend requests
enum RequestType {
  sent,       // You sent the request
  received,   // You received a request
}
