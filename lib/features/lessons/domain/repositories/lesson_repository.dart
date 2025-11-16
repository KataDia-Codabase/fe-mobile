import 'package:dartz/dartz.dart';
import 'package:katadia_app/core/errors/failures.dart';
import 'package:katadia_app/features/lessons/domain/entities/category.dart';
import 'package:katadia_app/features/lessons/domain/entities/lesson.dart';
import 'package:katadia_app/features/lessons/domain/entities/lesson_content.dart';
import 'package:katadia_app/features/lessons/domain/entities/lesson_progress.dart';

abstract class LessonRepository {
  /// Get lessons with filtering and pagination
  Future<Either<Failure, List<Lesson>>> getLessons({
    CategoryFilter? filter,
    int page = 1,
    int limit = 20,
    String? searchQuery,
  });

  /// Get a specific lesson by ID
  Future<Either<Failure, Lesson>> getLessonById(String lessonId);

  /// Get full lesson content including all content items
  Future<Either<Failure, List<LessonContent>>> getLessonContent(String lessonId);

  /// Get specific content item by ID
  Future<Either<Failure, LessonContent>> getContentById(String contentId);

  /// Update lesson progress
  Future<Either<Failure, void>> updateLessonProgress(
    String lessonId,
    LessonProgress progress,
  );

  /// Get user's progress for a lesson
  Future<Either<Failure, LessonProgress?>> getLessonProgress(String lessonId);

  /// Get all user's lesson progress
  Future<Either<Failure, List<LessonProgress>>> getUserProgress();

  /// Bookmark or unbookmark a lesson
  Future<Either<Failure, void>> toggleLessonBookmark(
    String lessonId,
    bool bookmarked,
  );

  /// Get bookmarked lessons
  Future<Either<Failure, List<Lesson>>> getBookmarkedLessons();

  /// Get categories
  Future<Either<Failure, List<Category>>> getCategories();

  /// Get featured sections
  Future<Either<Failure, List<FeaturedSection>>> getFeaturedSections();

  /// Get lessons for featured section
  Future<Either<Failure, List<Lesson>>> getFeaturedLessons(String sectionId);

  /// Search lessons
  Future<Either<Failure, List<Lesson>>> searchLessons({
    required String query,
    CategoryFilter? filter,
    int page = 1,
    int limit = 20,
  });

  /// Get recommended lessons based on user progress and preferences
  Future<Either<Failure, List<Lesson>>> getRecommendedLessons({
    String? userId,
    int limit = 10,
  });

  /// Get lessons for offline download
  Future<Either<Failure, List<Lesson>>> getDownloadableLessons();

  /// Download lesson for offline access
  Future<Either<Failure, bool>> downloadLesson(String lessonId);

  /// Remove cached lesson
  Future<Either<Failure, void>> removeCachedLesson(String lessonId);

  /// Get sync status for lessons
  Future<Either<Failure, Map<String, bool>>> getSyncStatus();

  /// Sync lesson data
  Future<Either<Failure, void>> syncLessons();

  /// Report lesson issue
  Future<Either<Failure, void>> reportLessonIssue({
    required String lessonId,
    required String issue,
    String? contentId,
  });

  /// Rate lesson
  Future<Either<Failure, void>> rateLesson({
    required String lessonId,
    required double rating,
    String? review,
  });

  /// Get lesson ratings
  Future<Either<Failure, List<LessonRating>>> getLessonRatings(String lessonId);

  /// Track lesson start
  Future<Either<Failure, void>> trackLessonStart(String lessonId);

  /// Track lesson complete
  Future<Either<Failure, void>> trackLessonComplete({
    required String lessonId,
    required double score,
    required int timeSpent,
  });

  /// Get learning streak
  Future<Either<Failure, LearningStreak>> getLearningStreak(String userId);

  /// Update learning streak
  Future<Either<Failure, LearningStreak>> updateLearningStreak({
    required String userId,
    DateTime? activityDate,
  });

  /// Get user's current skill level assessment
  Future<Either<Failure, CEFRLevel>> getUserSkillLevel(String userId);

  /// Update user skill level based on performance
  Future<Either<Failure, void>> updateUserSkillLevel({
    required String userId,
    required CEFRLevel newLevel,
  });

  /// Cache management
  Future<Either<Failure, void>> clearCache();
  Future<Either<Failure, int>> getCacheSize();
  Future<Either<Failure, bool>> isLessonCached(String lessonId);

  /// Batch operations
  Future<Either<Failure, void>> batchUpdateProgress(
    List<LessonProgress> progressList,
  );

  /// Analytics and insights
  Future<Either<Failure, LearningAnalytics>> getLearningAnalytics(String userId);

  /// Content availability check
  Future<Either<Failure, bool>> isContentAvailable(String contentId);

  /// Preload content for better performance
  Future<Either<Failure, void>> preloadContent(List<String> contentIds);
}

class LessonRating {
  final String id;
  final String userId;
  final String lessonId;
  final double rating;
  final String? review;
  final DateTime createdAt;
  final bool helpful;

  const LessonRating({
    required this.id,
    required this.userId,
    required this.lessonId,
    required this.rating,
    this.review,
    required this.createdAt,
    this.helpful = false,
  });
}

class LearningAnalytics {
  final String userId;
  final Map<CEFRLevel, int> lessonsCompleted;
  final Map<LessonCategory, double> categoryScores;
  final int totalStudyTime;
  final int averageSessionTime;
  final double overallAccuracy;
  final List<String> weakAreas;
  final List<String> strongAreas;
  final DateTime lastUpdated;

  const LearningAnalytics({
    required this.userId,
    required this.lessonsCompleted,
    required this.categoryScores,
    required this.totalStudyTime,
    required this.averageSessionTime,
    required this.overallAccuracy,
    required this.weakAreas,
    required this.strongAreas,
    required this.lastUpdated,
  });
}
