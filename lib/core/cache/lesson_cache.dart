import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'package:katadia_app/features/lessons/domain/entities/lesson.dart';

/// Cache manager for lesson content and audio files.
class LessonCache {
  /// Directory name for lesson cache.
  static const String _lessonsCacheDir = 'lessons';
  /// Directory name for audio cache.
  static const String _audioCacheDir = 'audio';
  /// Default cache duration.
  static const Duration defaultCacheDuration = Duration(days: 7);
  
  late final Directory _cacheDir;
  
  /// Initialize the cache directory.
  Future<void> initialize() async {
    final appDir = await getApplicationDocumentsDirectory();
    _cacheDir = Directory('${appDir.path}/cache');
    
    if (!await _cacheDir.exists()) {
      await _cacheDir.create(recursive: true);
    }
  }

  // Lesson content caching
  /// Cache lesson data to local storage.
  Future<void> cacheLesson(Lesson lesson) async {
    try {
      await initialize();
      
      final lessonFile = File('${_getLessonsCacheDir().path}/${lesson.id}.json');
      // Store lesson metadata as simple JSON
      final lessonJson = jsonEncode({
        'id': lesson.id,
        'title': lesson.title,
        'description': lesson.description,
        'level': lesson.level.code,
        'category': lesson.category.name,
        'type': lesson.type.name,
        'duration': lesson.duration,
        'difficulty': lesson.difficulty,
        'imageUrl': lesson.imageUrl,
        'audioUrl': lesson.audioUrl,
        'isPremium': lesson.isPremium,
        'isCompleted': lesson.isCompleted,
        'progress': lesson.progress,
        'bookmarked': lesson.bookmarked,
        'rating': lesson.rating,
        'totalRatings': lesson.totalRatings,
        'tags': lesson.tags,
        'prerequisites': lesson.prerequisites,
      });
      
      await lessonFile.writeAsString(lessonJson,);
      debugPrint('Lesson ${lesson.id} cached successfully');
    } catch (e) {
      debugPrint('Failed to cache lesson: $e');
    }
  }

  Future<Lesson?> getCachedLesson(String lessonId) async {
    try {
      await initialize();
      
      final lessonFile = File('${_getLessonsCacheDir().path}/$lessonId.json');
      
      if (!await lessonFile.exists()) {
        return null;
      }
      
      final lessonJson = await lessonFile.readAsString();
      final lessonMap = jsonDecode(lessonJson) as Map<String, dynamic>;
      
      // Reconstruct Lesson from cached data
      return _reconstructLesson(lessonMap);
    } catch (e) {
      debugPrint('Failed to get cached lesson: $e');
      return null;
    }
  }

  Future<List<Lesson>> getCachedLessons() async {
    try {
      await initialize();
      
      final lessonsDir = _getLessonsCacheDir();
      if (!await lessonsDir.exists()) {
        return [];
      }
      
      final files = await lessonsDir.list().where((entity) => 
        entity is File && entity.path.endsWith('.json')).cast<File>().toList();
      
      final lessons = <Lesson>[];
      
      for (final file in files) {
        try {
          final lessonJson = await file.readAsString();
          final lessonMap = jsonDecode(lessonJson) as Map<String, dynamic>;
          final lesson = _reconstructLesson(lessonMap);
          if (lesson != null) {
            lessons.add(lesson);
          }
        } catch (e) {
          debugPrint('Failed to parse cached lesson file ${file.path}: $e');
        }
      }
      
      return lessons;
    } catch (e) {
      debugPrint('Failed to get cached lessons: $e');
      return [];
    }
  }

  Future<void> clearCachedLesson(String lessonId) async {
    try {
      await initialize();
      
      final lessonFile = File('${_getLessonsCacheDir().path}/$lessonId.json');
      if (await lessonFile.exists()) {
        await lessonFile.delete();
        debugPrint('Cached lesson $lessonId removed');
      }
    } catch (e) {
      debugPrint('Failed to clear cached lesson: $e');
    }
  }

  // Audio file caching
  Future<String?> cacheAudioFile(String audioUrl, {String? customKey}) async {
    try {
      await initialize();
      
      final audioKey = customKey ?? _generateKeyFromUrl(audioUrl);
      final audioFile = File('${_getAudioCacheDir().path}/$audioKey');
      
      // If already cached, return path
      if (await audioFile.exists()) {
        return audioFile.path;
      }
      
      // Download and cache audio (mock implementation)
      // In real implementation, would download from audioUrl
      await audioFile.create(recursive: true);
      
      debugPrint('Audio file cached: ${audioFile.path}');
      return audioFile.path;
    } catch (e) {
      debugPrint('Failed to cache audio file: $e');
      return null;
    }
  }

  Future<String?> getCachedAudio(String audioUrl, {String? customKey}) async {
    try {
      await initialize();
      
      final audioKey = customKey ?? _generateKeyFromUrl(audioUrl);
      final audioFile = File('${_getAudioCacheDir().path}/$audioKey');
      
      if (await audioFile.exists()) {
        return audioFile.path;
      }
      
      return null;
    } catch (e) {
      debugPrint('Failed to get cached audio: $e');
      return null;
    }
  }

  Future<void> clearCachedAudio(String audioUrl, {String? customKey}) async {
    try {
      await initialize();
      
      final audioKey = customKey ?? _generateKeyFromUrl(audioUrl);
      final audioFile = File('${_getAudioCacheDir().path}/$audioKey');
      
      if (await audioFile.exists()) {
        await audioFile.delete();
        debugPrint('Cached audio file removed: $audioKey');
      }
    } catch (e) {
      debugPrint('Failed to clear cached audio: $e');
    }
  }

  // Cache management
  Future<CacheStats> getCacheStats() async {
    try {
      await initialize();
      
      final lessonsDir = _getLessonsCacheDir();
      final audioDir = _getAudioCacheDir();
      
      int lessonCount = 0;
      int lessonSize = 0;
      int audioCount = 0;
      int audioSize = 0;
      
      if (await lessonsDir.exists()) {
        final files = await lessonsDir.list().where((entity) => 
          entity is File).cast<File>().toList();
        
        for (final file in files) {
          lessonCount++;
          lessonSize += await file.length();
        }
      }
      
      if (await audioDir.exists()) {
        final files = await audioDir.list().where((entity) => 
          entity is File).cast<File>().toList();
        
        for (final file in files) {
          audioCount++;
          audioSize += await file.length();
        }
      }
      
      return CacheStats(
        lessonCount: lessonCount,
        lessonSize: lessonSize,
        audioCount: audioCount,
        audioSize: audioSize,
        totalSize: lessonSize + audioSize,
      );
    } catch (e) {
      debugPrint('Failed to get cache stats: $e');
      return const CacheStats();
    }
  }

  Future<void> clearAllCache() async {
    try {
      await initialize();
      
      if (await _cacheDir.exists()) {
        await _cacheDir.delete(recursive: true);
        debugPrint('All cache cleared');
      }
    } catch (e) {
      debugPrint('Failed to clear cache: $e');
    }
  }

  Future<void> cleanupOldCache({Duration? maxAge}) async {
    final age = maxAge ?? defaultCacheDuration;
    final cutoffDate = DateTime.now().subtract(age);
    
    try {
      await initialize();
      
      // Clean lesson cache
      if (await _getLessonsCacheDir().exists()) {
        final files = await _getLessonsCacheDir().list().where((entity) => 
          entity is File).cast<File>().toList();
        
        for (final file in files) {
          final stat = await file.stat();
          if (stat.modified.isBefore(cutoffDate)) {
            await file.delete();
            debugPrint('Removed old cache file: ${file.path}');
          }
        }
      }
      
      // Clean audio cache
      if (await _getAudioCacheDir().exists()) {
        final files = await _getAudioCacheDir().list().where((entity) => 
          entity is File).cast<File>().toList();
        
        for (final file in files) {
          final stat = await file.stat();
          if (stat.modified.isBefore(cutoffDate)) {
            await file.delete();
            debugPrint('Removed old audio file: ${file.path}');
          }
        }
      }
      
      debugPrint('Cache cleanup completed');
    } catch (e) {
      debugPrint('Failed to cleanup cache: $e');
    }
  }

  // Private helper methods
  Lesson? _reconstructLesson(Map<String, dynamic> data) {
    try {
      final levelCode = data['level'] as String?;
      final level = CEFRLevel.values.firstWhere(
        (l) => l.code == levelCode,
        orElse: () => CEFRLevel.a1,
      );

      final categoryName = data['category'] as String?;
      final category = LessonCategory.values.firstWhere(
        (c) => c.name == categoryName,
        orElse: () => LessonCategory.vocabulary,
      );

      final typeName = data['type'] as String?;
      final type = LessonType.values.firstWhere(
        (t) => t.name == typeName,
        orElse: () => LessonType.vocabulary,
      );

      return Lesson(
        id: data['id'] as String,
        title: data['title'] as String,
        description: data['description'] as String,
        level: level,
        category: category,
        type: type,
        duration: data['duration'] as int? ?? 0,
        difficulty: (data['difficulty'] as num?)?.toDouble() ?? 0.0,
        imageUrl: data['imageUrl'] as String?,
        audioUrl: data['audioUrl'] as String?,
        isPremium: data['isPremium'] as bool? ?? false,
        isCompleted: data['isCompleted'] as bool? ?? false,
        progress: (data['progress'] as num?)?.toDouble() ?? 0.0,
        bookmarked: data['bookmarked'] as bool? ?? false,
        rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
        totalRatings: data['totalRatings'] as int? ?? 0,
        tags: List<String>.from(data['tags'] as List? ?? []),
        prerequisites: List<String>.from(data['prerequisites'] as List? ?? []),
      );
    } catch (e) {
      debugPrint('Failed to reconstruct lesson: $e');
      return null;
    }
  }

  Directory _getLessonsCacheDir() {
    return Directory('${_cacheDir.path}/$_lessonsCacheDir');
  }

  Directory _getAudioCacheDir() {
    return Directory('${_cacheDir.path}/$_audioCacheDir');
  }

  String _generateKeyFromUrl(String url) {
    return url.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
  }
}

/// Cache statistics data class.
class CacheStats {
  /// Number of cached lessons.
  final int lessonCount;
  /// Total size of lesson cache in bytes.
  final int lessonSize;
  /// Number of cached audio files.
  final int audioCount;
  /// Total size of audio cache in bytes.
  final int audioSize;
  /// Total cache size in bytes.
  final int totalSize;

  const CacheStats({
    this.lessonCount = 0,
    this.lessonSize = 0,
    this.audioCount = 0,
    this.audioSize = 0,
    this.totalSize = 0,
  });

  /// Formatted total cache size string.
  String get totalSizeFormatted {
    if (totalSize < 1024) {
      return '${totalSize}B';
    } else if (totalSize < 1024 * 1024) {
      return '${(totalSize / 1024).toStringAsFixed(1)}KB';
    } else if (totalSize < 1024 * 1024 * 1024) {
      return '${(totalSize / (1024 * 1024)).toStringAsFixed(1)}MB';
    } else {
      return '${(totalSize / (1024 * 1024 * 1024)).toStringAsFixed(1)}GB';
    }
  }

  /// Formatted lesson cache size string.
  String get lessonSizeFormatted {
    if (lessonSize < 1024) {
      return '${lessonSize}B';
    } else if (lessonSize < 1024 * 1024) {
      return '${(lessonSize / 1024).toStringAsFixed(1)}KB';
    } else {
      return '${(lessonSize / (1024 * 1024)).toStringAsFixed(1)}MB';
    }
  }

  /// Formatted audio cache size string.
  String get audioSizeFormatted {
    if (audioSize < 1024) {
      return '${audioSize}B';
    } else if (audioSize < 1024 * 1024) {
      return '${(audioSize / 1024).toStringAsFixed(1)}KB';
    } else {
      return '${(audioSize / (1024 * 1024)).toStringAsFixed(1)}MB';
    }
  }
}
