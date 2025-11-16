import 'package:dartz/dartz.dart';
import '../entities/friend.dart';
import '../entities/social_activity.dart';
import '../entities/leaderboard.dart';
import '../entities/study_group.dart';
import '../entities/social_challenge.dart';
import '../../../../core/errors/failures.dart';

/// Main social repository combining all social features
abstract class SocialRepository {
  // Friend Management
  Future<Either<Failure, List<Friend>>> getFriends({
    FriendStatus? status,
    int? limit,
  });

  Future<Either<Failure, List<Friend>>> searchUsers({
    required String query,
    int? limit,
  });

  Future<Either<Failure, void>> sendFriendRequest({
    required String userId,
  });

  Future<Either<Failure, void>> acceptFriendRequest({
    required String userId,
  });

  Future<Either<Failure, void>> unfriend({
    required String userId,
  });

  // Social Activities Feed
  Future<Either<Failure, List<SocialActivity>>> getActivitiesFeed({
    String? userId,
    ActivityType? typeFilter,
    int? limit,
  });

  Future<Either<Failure, void>> likeActivity({
    required String activityId,
  });

  Future<Either<Failure, SocialComment>> postComment({
    required String activityId,
    required String content,
  });

  // Leaderboard
  Future<Either<Failure, List<LeaderboardEntry>>> getLeaderboard({
    String type,
    String scope,
    int? limit,
  });

  // Study Groups
  Future<Either<Failure, List<StudyGroup>>> getUserStudyGroups({
    int? limit,
  });

  Future<Either<Failure, void>> joinStudyGroup({
    required String groupId,
  });

  // Challenges
  Future<Either<Failure, List<SocialChallenge>>> getChallenges({
    String? status,
    int? limit,
  });

  Future<Either<Failure, void>> joinChallenge({
    required String challengeId,
  });
}
