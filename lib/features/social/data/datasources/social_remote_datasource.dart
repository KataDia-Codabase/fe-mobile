import '../../../../core/network/network_info.dart';
import '../../domain/entities/friend.dart';
import '../../domain/entities/leaderboard.dart';
import '../../domain/entities/study_group.dart';
import '../../domain/entities/social_challenge.dart' as challenge;
import '../../domain/entities/social_activity.dart';
import '../../domain/repositories/friend_repository.dart';

/// Remote data source for social features
abstract class SocialRemoteDataSource {
  // Friend related
  Future<List<Friend>> getFriends({
    FriendStatus? status,
    bool includeBlocked = false,
    int? limit,
    int? offset,
  });

  Future<List<Friend>> getFriendSuggestions({
    int? limit,
    List<String>? excludeIds,
  });

  Future<List<Friend>> searchUsers({
    required String query,
    int? limit,
    int? offset,
  });

  Future<void> sendFriendRequest({
    required String userId,
    String? message,
  });

  Future<void> acceptFriendRequest({
    required String requestId,
  });

  Future<void> declineFriendRequest({
    required String requestId,
  });

  Future<void> cancelFriendRequest({
    required String requestId,
  });

  Future<void> unfriend({
    required String userId,
  });

  Future<void> blockUser({
    required String userId,
  });

  Future<void> unblockUser({
    required String userId,
  });

  Future<List<Friend>> getMutualFriends({
    required String userId,
  });

  Future<void> updateFriendPrivacySettings({
    required String userId,
    required PrivacySettings settings,
  });

  Future<Friend> getFriendDetails({
    required String userId,
  });

  Future<void> reportFriend({
    required String userId,
    required String reason,
    String? description,
  });

  Future<List<Friend>> getFriendRequests({
    RequestType? type,
    int? limit,
    int? offset,
  });

  Future<bool> isFriend({
    required String userId,
  });

  Future<FriendshipStats> getFriendshipStats({
    required String userId,
  });

  Future<void> updateFriendNickname({
    required String userId,
    required String nickname,
  });

  Future<void> muteFriendActivities({
    required String userId,
    required bool isMuted,
  });

  // Leaderboard, Study group, and Challenge methods deferred to Sprint 6+
  Future<Leaderboard> getLeaderboard({
    required LeaderboardType type,
    required LeaderboardScope scope,
    Map<String, dynamic>? filters,
    int? limit,
  });

  Future<List<UserPosition>> getCurrentUserPositions({
    List<LeaderboardType>? types,
    List<LeaderboardScope>? scopes,
  });

  Future<List<StudyGroup>> getUserStudyGroups({
    GroupStatus? status,
    GroupType? type,
    int? limit,
    int? offset,
  });

  Future<List<challenge.SocialChallenge>> getChallenges({
    challenge.ChallengeStatus? status,
    challenge.ChallengeType? type,
    challenge.ChallengeDifficulty? difficulty,
    Map<String, dynamic>? filters,
    int? limit,
    int? offset,
  });

  Future<List<SocialActivity>> getSocialActivities({
    List<String>? userIds,
    ActivityType? typeFilter,
    DateTime? after,
    DateTime? before,
    int? limit,
    int? offset,
  });
}

/// Basic implementation stub for SocialRemoteDataSource
/// Complete implementation deferred to Sprint 6+
class SocialRemoteDataSourceImpl implements SocialRemoteDataSource {
  final NetworkInfo networkInfo;

  SocialRemoteDataSourceImpl({required this.networkInfo});

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return Future<dynamic>.error(UnimplementedError(
      'SocialRemoteDataSourceImpl.${invocation.memberName} not implemented',
    ));
  }
}
