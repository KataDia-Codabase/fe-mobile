import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable()
class SocialChallenge {
  final String id;
  final String title;
  final String description;
  final String type;
  final String? imageUrl;
  final String category;
  final String creatorId;
  final String creatorName;
  final DateTime createdAt;
  final DateTime startDate;
  final DateTime endDate;
  final int participantCount;
  final int maxParticipants;
  final int currentLevel;
  final int maxLevel;
  final bool isPublic;
  final bool isActive;
  final String status;
  final List<String> requirements;
  final Map<String, dynamic> rules;
  final Map<String, dynamic> rewards;
  final Map<String, dynamic> statistics;

  const SocialChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.imageUrl,
    required this.category,
    required this.creatorId,
    required this.creatorName,
    required this.createdAt,
    required this.startDate,
    required this.endDate,
    this.participantCount = 0,
    this.maxParticipants = 100,
    this.currentLevel = 0,
    this.maxLevel = 5,
    this.isPublic = false,
    this.isActive = false,
    this.status = 'draft',
    this.requirements = const [],
    this.rules = const {},
    this.rewards = const {},
    this.statistics = const {},
  });
  
  factory SocialChallenge.fromJson(Map<String, dynamic> json) {
    return SocialChallenge(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      type: json['type'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
      category: json['category'] as String? ?? '',
      creatorId: json['creatorId'] as String? ?? '',
      creatorName: json['creatorName'] as String? ?? '',
      createdAt: json['createdAt'] is String
          ? DateTime.parse(json['createdAt'] as String)
          : json['createdAt'] as DateTime? ?? DateTime.now(),
      startDate: json['startDate'] is String
          ? DateTime.parse(json['startDate'] as String)
          : json['startDate'] as DateTime? ?? DateTime.now(),
      endDate: json['endDate'] is String
          ? DateTime.parse(json['endDate'] as String)
          : json['endDate'] as DateTime? ?? DateTime.now(),
      participantCount: json['participantCount'] as int? ?? 0,
      maxParticipants: json['maxParticipants'] as int? ?? 100,
      currentLevel: json['currentLevel'] as int? ?? 0,
      maxLevel: json['maxLevel'] as int? ?? 5,
      isPublic: json['isPublic'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? false,
      status: json['status'] as String? ?? 'draft',
      requirements: List<String>.from(json['requirements'] as List? ?? []),
      rules: Map<String, dynamic>.from(json['rules'] as Map? ?? {}),
      rewards: Map<String, dynamic>.from(json['rewards'] as Map? ?? {}),
      statistics: Map<String, dynamic>.from(json['statistics'] as Map? ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'type': type,
    'imageUrl': imageUrl,
    'category': category,
    'creatorId': creatorId,
    'creatorName': creatorName,
    'createdAt': createdAt.toIso8601String(),
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'participantCount': participantCount,
    'maxParticipants': maxParticipants,
    'currentLevel': currentLevel,
    'maxLevel': maxLevel,
    'isPublic': isPublic,
    'isActive': isActive,
    'status': status,
    'requirements': requirements,
    'rules': rules,
    'rewards': rewards,
    'statistics': statistics,
  };

  SocialChallenge copyWith({
    String? id,
    String? title,
    String? description,
    String? type,
    String? imageUrl,
    String? category,
    String? creatorId,
    String? creatorName,
    DateTime? createdAt,
    DateTime? startDate,
    DateTime? endDate,
    int? participantCount,
    int? maxParticipants,
    int? currentLevel,
    int? maxLevel,
    bool? isPublic,
    bool? isActive,
    String? status,
    List<String>? requirements,
    Map<String, dynamic>? rules,
    Map<String, dynamic>? rewards,
    Map<String, dynamic>? statistics,
  }) {
    return SocialChallenge(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      createdAt: createdAt ?? this.createdAt,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      participantCount: participantCount ?? this.participantCount,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      currentLevel: currentLevel ?? this.currentLevel,
      maxLevel: maxLevel ?? this.maxLevel,
      isPublic: isPublic ?? this.isPublic,
      isActive: isActive ?? this.isActive,
      status: status ?? this.status,
      requirements: requirements ?? this.requirements,
      rules: rules ?? this.rules,
      rewards: rewards ?? this.rewards,
      statistics: statistics ?? this.statistics,
    );
  }
}

enum ChallengeStatus {
  draft,
  active,
  completed,
  cancelled,
  paused,
}

enum ChallengeType {
  pronunciation_duel,
  learning_streak,
  vocabulary_master,
  conversation_challenge,
  accent_challenge,
  speed_reading,
}
