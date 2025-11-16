import 'package:katadia_app/features/lessons/domain/entities/lesson.dart';
import 'package:katadia_app/features/lessons/domain/entities/lesson_content.dart';
import 'package:katadia_app/features/lessons/domain/entities/lesson_progress.dart';

abstract class LessonLocalDataSource {
  Future<Lesson?> getLessonById(String id);
  Future<List<Lesson>> getLessons({int limit = 20, int offset = 0});
  Future<List<Lesson>> searchLessons(String query);
  Future<void> cacheLesson(Lesson lesson);
  Future<void> cacheLessons(List<Lesson> lessons);
  Future<void> cacheLessonContent(String lessonId, List<LessonContent> content);
  Future<List<LessonContent>> getLessonContent(String lessonId);
  Future<void> updateLessonProgress(LessonProgress progress);
  Future<LessonProgress?> getLessonProgress(String lessonId);
  Future<List<LessonProgress>> getUserProgress();
  Future<void> toggleBookmark(String lessonId, bool bookmarked);
  Future<List<Lesson>> getBookmarkedLessons();
  Future<List<Category>> getCategories();
  Future<void> deleteCachedLesson(String id);
  Future<void> clearAllCache();
  Future<bool> isLessonCached(String lessonId);
  Future<int> getCacheSize();
  Future<DateTime?> getLastSyncTime();
  Future<void> setLastSyncTime(DateTime time);
}

// Simple in-memory implementation for MVP
class LessonLocalDataSourceImpl implements LessonLocalDataSource {
  // In-memory cache
  final Map<String, Lesson> _lessonsCache = {};
  final Map<String, List<LessonContent>> _contentCache = {};
  final Map<String, LessonProgress> _progressCache = {};
  DateTime? _lastSyncTime;

  @override
  Future<Lesson?> getLessonById(String id) async {
    return _lessonsCache[id];
  }

  @override
  Future<List<Lesson>> getLessons({int limit = 20, int offset = 0}) async {
    final lessons = _lessonsCache.values.toList();
    final endIndex = (offset + limit).clamp(0, lessons.length);
    return lessons.sublist(offset.clamp(0, lessons.length), endIndex);
  }

  @override
  Future<List<Lesson>> searchLessons(String query) async {
    final lowerQuery = query.toLowerCase();
    return _lessonsCache.values
        .where((lesson) =>
            lesson.title.toLowerCase().contains(lowerQuery) ||
            lesson.description.toLowerCase().contains(lowerQuery))
        .toList();
  }

  @override
  Future<void> cacheLesson(Lesson lesson) async {
    _lessonsCache[lesson.id] = lesson;
  }

  @override
  Future<void> cacheLessons(List<Lesson> lessons) async {
    for (final lesson in lessons) {
      _lessonsCache[lesson.id] = lesson;
    }
  }

  @override
  Future<void> cacheLessonContent(String lessonId, List<LessonContent> content) async {
    _contentCache[lessonId] = content;
  }

  @override
  Future<List<LessonContent>> getLessonContent(String lessonId) async {
    return _contentCache[lessonId] ?? [];
  }

  @override
  Future<void> updateLessonProgress(LessonProgress progress) async {
    _progressCache[progress.lessonId] = progress;
  }

  @override
  Future<LessonProgress?> getLessonProgress(String lessonId) async {
    return _progressCache[lessonId];
  }

  @override
  Future<List<LessonProgress>> getUserProgress() async {
    return _progressCache.values.toList();
  }

  @override
  Future<void> toggleBookmark(String lessonId, bool bookmarked) async {
    final lesson = _lessonsCache[lessonId];
    if (lesson != null) {
      _lessonsCache[lessonId] = lesson.copyWith(bookmarked: bookmarked);
    }
  }

  @override
  Future<List<Lesson>> getBookmarkedLessons() async {
    return _lessonsCache.values.where((lesson) => lesson.bookmarked).toList();
  }

  @override
  Future<List<Category>> getCategories() async {
    return LessonCategory.values.map((category) => 
      Category(
        id: category.name,
        name: category.name,
        description: category.description,
      )
    ).toList();
  }

  @override
  Future<void> deleteCachedLesson(String id) async {
    _lessonsCache.remove(id);
    _contentCache.remove(id);
    _progressCache.remove(id);
  }

  @override
  Future<void> clearAllCache() async {
    _lessonsCache.clear();
    _contentCache.clear();
    _progressCache.clear();
  }

  @override
  Future<bool> isLessonCached(String lessonId) async {
    return _lessonsCache.containsKey(lessonId);
  }

  @override
  Future<int> getCacheSize() async {
    return _lessonsCache.length;
  }

  @override
  Future<DateTime?> getLastSyncTime() async {
    return _lastSyncTime;
  }

  @override
  Future<void> setLastSyncTime(DateTime time) async {
    _lastSyncTime = time;
  }
}


class Category {
  final String id;
  final String name;
  final String description;
  final String? iconUrl;
  final String? imageUrl;
  final String? color;
  final int? lessonCount;
  final int? totalDuration;
  final List<String>? levels;
  final double? difficulty;
  final bool? isActive;
  final int? sortOrder;
  final bool? featured;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.description,
    this.iconUrl,
    this.imageUrl,
    this.color,
    this.lessonCount,
    this.totalDuration,
    this.levels,
    this.difficulty,
    this.isActive,
    this.sortOrder,
    this.featured,
    this.createdAt,
    this.updatedAt,
  });
}
