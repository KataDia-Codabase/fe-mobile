import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class SocialRemoteDatasource {
  final Dio _dioClient;
  final Logger _logger = Logger();

  SocialRemoteDatasource(this._dioClient);

  /// Get available challenges - returns Map<String, dynamic> list
  Future<List<Map<String, dynamic>>> getAvailableChallenges(String userId) async {
    try {
      final response = await _dioClient.get<List<dynamic>>(
        '/api/challenges/available',
        queryParameters: {'userId': userId},
      );
      
      if (response.statusCode == 200 && response.data != null) {
        return List<Map<String, dynamic>>.from(
          (response.data as List).map((json) => json as Map<String, dynamic>),
        );
      }
      return [];
    } catch (e) {
      _logger.e('Failed to get available challenges: $e');
      return [];
    }
  }

  /// Get user's participations
  Future<List<ChallengeParticipation>> getMyParticipations(String userId) async {
    try {
      final response = await _dioClient.get<List<dynamic>>(
        '/api/challenges/my-participations',
        queryParameters: {'userId': userId},
      );
      
      if (response.statusCode == 200 && response.data != null) {
        return (response.data as List)
            .map((json) => ChallengeParticipation.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      _logger.e('Failed to get my participations: $e');
      return [];
    }
  }

  /// Get leaderboard
  Future<List<LeaderboardEntry>> getLeaderboard({int limit = 100}) async {
    try {
      final response = await _dioClient.get<List<dynamic>>(
        '/api/challenges/leaderboard',
        queryParameters: {'limit': limit},
      );
      
      if (response.statusCode == 200 && response.data != null) {
        return (response.data as List)
            .map((json) => LeaderboardEntry.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      _logger.e('Failed to get leaderboard: $e');
      return [];
    }
  }
}

class ChallengeParticipation {
  final String id;
  final String challengeId;
  final String userId;
  final String username;
  final DateTime joinedAt;
  final DateTime lastActiveAt;
  final int currentScore;
  final int bestScore;
  final int currentLevel;
  final List<Achievement> achievements;
  final bool isActive;
  final Map<String, dynamic> progress;

  const ChallengeParticipation({
    required this.id,
    required this.challengeId,
    required this.userId,
    required this.username,
    required this.joinedAt,
    required this.lastActiveAt,
    required this.currentScore,
    required this.bestScore,
    required this.currentLevel,
    required this.achievements,
    required this.isActive,
    required this.progress,
  });

  factory ChallengeParticipation.fromJson(Map<String, dynamic> json) {
    return ChallengeParticipation(
      id: json['id'] as String? ?? '',
      challengeId: json['challengeId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      username: json['username'] as String? ?? '',
      joinedAt: json['joinedAt'] is String
          ? DateTime.parse(json['joinedAt'] as String)
          : json['joinedAt'] as DateTime? ?? DateTime.now(),
      lastActiveAt: json['lastActiveAt'] is String
          ? DateTime.parse(json['lastActiveAt'] as String)
          : json['lastActiveAt'] as DateTime? ?? DateTime.now(),
      currentScore: json['currentScore'] as int? ?? 0,
      bestScore: json['bestScore'] as int? ?? 0,
      currentLevel: json['currentLevel'] as int? ?? 1,
      achievements: (json['achievements'] as List?)
              ?.map((a) => Achievement.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      isActive: json['isActive'] as bool? ?? false,
      progress: json['progress'] as Map<String, dynamic>? ?? {},
    );
  }
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final int points;
  final DateTime earnedAt;
  final String source;
  final Map<String, dynamic> metadata;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.points,
    required this.earnedAt,
    required this.source,
    required this.metadata,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      points: json['points'] as int? ?? 0,
      earnedAt: json['earnedAt'] is String
          ? DateTime.parse(json['earnedAt'] as String)
          : json['earnedAt'] as DateTime? ?? DateTime.now(),
      source: json['source'] as String? ?? 'general',
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }
}

class LeaderboardEntry {
  final int rank;
  final String userId;
  final String username;
  final String avatarUrl;
  final int score;
  final Map<String, dynamic> stats;

  const LeaderboardEntry({
    required this.rank,
    required this.userId,
    required this.username,
    required this.avatarUrl,
    required this.score,
    required this.stats,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      rank: json['rank'] as int? ?? 0,
      userId: json['userId'] as String? ?? '',
      username: json['username'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String? ?? '',
      score: json['score'] as int? ?? 0,
      stats: json['stats'] as Map<String, dynamic>? ?? {},
    );
  }
}
