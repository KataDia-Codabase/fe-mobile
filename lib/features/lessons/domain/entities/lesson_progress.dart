import 'package:equatable/equatable.dart';

class LessonProgress extends Equatable {
  const LessonProgress({
    required this.lessonId,
    required this.userId,
    this.startedAt,
    this.lastAccessed,
    this.completedAt,
    this.completionStatus = CompletionStatus.notStarted,
    this.overallScore,
    this.totalTimeSpent = 0,
    this.contentProgress = const [],
    this.streakDays = 0,
    this.attempts = 0,
    this.bookmarked = false,
    this.notes,
    this.metadata = const {},
  });

  final String lessonId;
  final String userId;
  final DateTime? startedAt;
  final DateTime? lastAccessed;
  final DateTime? completedAt;
  final CompletionStatus completionStatus;
  final double? overallScore;
  final int totalTimeSpent; // in seconds
  final List<ContentProgress> contentProgress;
  final int streakDays;
  final int attempts;
  final bool bookmarked;
  final String? notes;
  final Map<String, dynamic> metadata;

  double get progressPercentage {
    if (contentProgress.isEmpty) return 0.0;
    
    final completedCount = contentProgress
        .where((cp) => cp.status == CompletionStatus.completed)
        .length;
    
    return completedCount / contentProgress.length;
  }

  bool get isCompleted => completionStatus == CompletionStatus.completed;
  
  bool get isStarted => completionStatus != CompletionStatus.notStarted;

  Duration get formattedTimeSpent {
    return Duration(seconds: totalTimeSpent);
  }

  LessonProgress copyWith({
    String? lessonId,
    String? userId,
    DateTime? startedAt,
    DateTime? lastAccessed,
    DateTime? completedAt,
    CompletionStatus? completionStatus,
    double? overallScore,
    int? totalTimeSpent,
    List<ContentProgress>? contentProgress,
    int? streakDays,
    int? attempts,
    bool? bookmarked,
    String? notes,
    Map<String, dynamic>? metadata,
  }) {
    return LessonProgress(
      lessonId: lessonId ?? this.lessonId,
      userId: userId ?? this.userId,
      startedAt: startedAt ?? this.startedAt,
      lastAccessed: lastAccessed ?? this.lastAccessed,
      completedAt: completedAt ?? this.completedAt,
      completionStatus: completionStatus ?? this.completionStatus,
      overallScore: overallScore ?? this.overallScore,
      totalTimeSpent: totalTimeSpent ?? this.totalTimeSpent,
      contentProgress: contentProgress ?? this.contentProgress,
      streakDays: streakDays ?? this.streakDays,
      attempts: attempts ?? this.attempts,
      bookmarked: bookmarked ?? this.bookmarked,
      notes: notes ?? this.notes,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
        lessonId,
        userId,
        startedAt,
        lastAccessed,
        completedAt,
        completionStatus,
        overallScore,
        totalTimeSpent,
        contentProgress,
        streakDays,
        attempts,
        bookmarked,
        notes,
        metadata,
      ];

  @override
  String toString() {
    return 'LessonProgress(lessonId: $lessonId, status: $completionStatus, progress: ${(progressPercentage * 100).toStringAsFixed(1)}%)';
  }
}

class ContentProgress extends Equatable {
  const ContentProgress({
    required this.contentId,
    this.status = CompletionStatus.notStarted,
    this.score,
    this.timeSpent = 0,
    this.attempts = 0,
    this.userFeedback,
    this.metadata = const {},
  });

  final String contentId;
  final CompletionStatus status;
  final double? score;
  final int timeSpent; // in seconds
  final int attempts;
  final String? userFeedback;
  final Map<String, dynamic> metadata;

  Duration get formattedTimeSpent {
    return Duration(seconds: timeSpent);
  }

  ContentProgress copyWith({
    String? contentId,
    CompletionStatus? status,
    double? score,
    int? timeSpent,
    int? attempts,
    String? userFeedback,
    Map<String, dynamic>? metadata,
  }) {
    return ContentProgress(
      contentId: contentId ?? this.contentId,
      status: status ?? this.status,
      score: score ?? this.score,
      timeSpent: timeSpent ?? this.timeSpent,
      attempts: attempts ?? this.attempts,
      userFeedback: userFeedback ?? this.userFeedback,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
        contentId,
        status,
        score,
        timeSpent,
        attempts,
        userFeedback,
        metadata,
      ];

  @override
  String toString() {
    return 'ContentProgress(contentId: $contentId, status: $status, score: $score)';
  }
}

enum CompletionStatus {
  notStarted('Not Started'),
  inProgress('In Progress'),
  completed('Completed'),
  skipped('Skipped'),
  failed('Failed');

  const CompletionStatus(this.displayName);
  
  final String displayName;
}

class LearningStreak extends Equatable {
  const LearningStreak({
    required this.userId,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastActiveDate,
    this.weeklyGoal = 7, // days
    this.weeklyProgress = 0,
    this.totalDaysLearned = 0,
    this.streakHistory = const [],
  });

  final String userId;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastActiveDate;
  final int weeklyGoal;
  final int weeklyProgress;
  final int totalDaysLearned;
  final List<DateTime> streakHistory;

  bool get isStreakActive {
    if (lastActiveDate == null) return false;
    
    final now = DateTime.now();
    final daysDiff = now.difference(lastActiveDate!).inDays;
    
    return daysDiff <= 1; // Active if learned yesterday or today
  }

  double get weeklyProgressPercentage {
    if (weeklyGoal == 0) return 0.0;
    return weeklyProgress / weeklyGoal;
  }

  LearningStreak copyWith({
    String? userId,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastActiveDate,
    int? weeklyGoal,
    int? weeklyProgress,
    int? totalDaysLearned,
    List<DateTime>? streakHistory,
  }) {
    return LearningStreak(
      userId: userId ?? this.userId,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      weeklyGoal: weeklyGoal ?? this.weeklyGoal,
      weeklyProgress: weeklyProgress ?? this.weeklyProgress,
      totalDaysLearned: totalDaysLearned ?? this.totalDaysLearned,
      streakHistory: streakHistory ?? this.streakHistory,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        currentStreak,
        longestStreak,
        lastActiveDate,
        weeklyGoal,
        weeklyProgress,
        totalDaysLearned,
        streakHistory,
      ];

  @override
  String toString() {
    return 'LearningStreak(userId: $userId, current: $currentStreak, longest: $longestStreak)';
  }
}
