import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? profilePicture;
  final String? preferredLanguage;
  final String? cefrLevel;
  final int? learningStreak;
  final int? xp;
  final int? currentLevel;
  final int? totalLessonsCompleted;
  final int? pronunciationSessions;
  final double? averageScore;
  final bool? isPremium;
  final DateTime? subscriptionExpiry;
  final String? socialLoginProvider;
  final String? googleUserId;
  final String? appleUserId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? metadata;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.profilePicture,
    this.preferredLanguage,
    this.cefrLevel,
    this.learningStreak,
    this.xp,
    this.currentLevel,
    this.totalLessonsCompleted,
    this.pronunciationSessions,
    this.averageScore,
    this.isPremium,
    this.subscriptionExpiry,
    this.socialLoginProvider,
    this.googleUserId,
    this.appleUserId,
    this.createdAt,
    this.updatedAt,
    this.metadata,
  });

  // Getters for computed properties
  bool get isBasicAuth => socialLoginProvider == null;
  bool get isGoogleAuth => socialLoginProvider == 'google';
  bool get isAppleAuth => socialLoginProvider == 'apple';
  
  bool get hasPremiumAccess => 
      isPremium == true && 
      (subscriptionExpiry == null || subscriptionExpiry!.isAfter(DateTime.now()));
  
  String get displayName => name.isNotEmpty ? name : email.split('@').first;
  
  bool get isBeginner => cefrLevel == null || 'A1A2'.contains(cefrLevel!);
  bool get isIntermediateBeg => 'B1B2'.contains(cefrLevel ?? '');
  bool get isAdvanced => 'C1C2'.contains(cefrLevel ?? '');
  
  int get progressPercentage => (totalLessonsCompleted != null && totalLessonsCompleted! > 0) 
      ? ((totalLessonsCompleted! % 50) / 50 * 100).round()
      : 0;

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? profilePicture,
    String? preferredLanguage,
    String? cefrLevel,
    int? learningStreak,
    int? xp,
    int? currentLevel,
    int? totalLessonsCompleted,
    int? pronunciationSessions,
    double? averageScore,
    bool? isPremium,
    DateTime? subscriptionExpiry,
    String? socialLoginProvider,
    String? googleUserId,
    String? appleUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      cefrLevel: cefrLevel ?? this.cefrLevel,
      learningStreak: learningStreak ?? this.learningStreak,
      xp: xp ?? this.xp,
      currentLevel: currentLevel ?? this.currentLevel,
      totalLessonsCompleted: totalLessonsCompleted ?? this.totalLessonsCompleted,
      pronunciationSessions: pronunciationSessions ?? this.pronunciationSessions,
      averageScore: averageScore ?? this.averageScore,
      isPremium: isPremium ?? this.isPremium,
      subscriptionExpiry: subscriptionExpiry ?? this.subscriptionExpiry,
      socialLoginProvider: socialLoginProvider ?? this.socialLoginProvider,
      googleUserId: googleUserId ?? this.googleUserId,
      appleUserId: appleUserId ?? this.appleUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profile_picture': profilePicture,
      'preferred_language': preferredLanguage,
      'cefr_level': cefrLevel,
      'learning_streak': learningStreak,
      'xp': xp,
      'current_level': currentLevel,
      'total_lessons_completed': totalLessonsCompleted,
      'pronunciation_sessions': pronunciationSessions,
      'average_score': averageScore,
      'is_premium': isPremium,
      'subscription_expiry': subscriptionExpiry?.toIso8601String(),
      'social_login_provider': socialLoginProvider,
      'google_user_id': googleUserId,
      'apple_user_id': appleUserId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'metadata': metadata,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      profilePicture: json['profile_picture'] as String?,
      preferredLanguage: json['preferred_language'] as String?,
      cefrLevel: json['cefr_level'] as String?,
      learningStreak: json['learning_streak'] as int?,
      xp: json['xp'] as int?,
      currentLevel: json['current_level'] as int?,
      totalLessonsCompleted: json['total_lessons_completed'] as int?,
      pronunciationSessions: json['pronunciation_sessions'] as int?,
      averageScore: json['average_score'] as double?,
      isPremium: json['is_premium'] as bool?,
      subscriptionExpiry: json['subscription_expiry'] != null 
          ? DateTime.parse(json['subscription_expiry'] as String)
          : null,
      socialLoginProvider: json['social_login_provider'] as String?,
      googleUserId: json['google_user_id'] as String?,
      appleUserId: json['apple_user_id'] as String?,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  // Extensions for additional functionality
  User copyWithUpdatedStreak(int newStreak) {
    return copyWith(learningStreak: newStreak);
  }

  User copyWithAddedXp(int additionalXp) {
    final currentXp = xp ?? 0;
    final newXp = currentXp + additionalXp;
    return copyWith(xp: newXp);
  }

  User copyWithCompletedLesson() {
    final completed = (totalLessonsCompleted ?? 0) + 1;
    return copyWith(totalLessonsCompleted: completed);
  }

  User copyWithPronunciationSession(double score) {
    final sessions = (pronunciationSessions ?? 0) + 1;
    final currentAvg = averageScore ?? 0.0;
    final newAvg = ((currentAvg * (sessions - 1)) + score) / sessions;
    
    return copyWith(
      pronunciationSessions: sessions,
      averageScore: newAvg,
    );
  }

  Map<String, dynamic> toApiJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profile_picture': profilePicture,
      'preferred_language': preferredLanguage,
      'cefr_level': cefrLevel,
    };
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        profilePicture,
        preferredLanguage,
        cefrLevel,
        learningStreak,
        xp,
        currentLevel,
        totalLessonsCompleted,
        pronunciationSessions,
        averageScore,
        isPremium,
        subscriptionExpiry,
        socialLoginProvider,
        googleUserId,
        appleUserId,
        createdAt,
        updatedAt,
        metadata,
      ];
}
