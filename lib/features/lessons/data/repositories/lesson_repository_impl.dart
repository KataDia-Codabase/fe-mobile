import 'package:dartz/dartz.dart';
import 'package:katadia_app/core/errors/failures.dart';
import 'package:katadia_app/features/lessons/domain/entities/category.dart' as domain_category;
import 'package:katadia_app/features/lessons/domain/entities/lesson.dart';
import 'package:katadia_app/features/lessons/domain/entities/lesson_content.dart';
import 'package:katadia_app/features/lessons/domain/entities/lesson_progress.dart';
import 'package:katadia_app/features/lessons/domain/repositories/lesson_repository.dart';
import 'package:katadia_app/features/lessons/data/datasources/lesson_local_datasource.dart' as local_ds;
import 'package:katadia_app/features/lessons/data/datasources/lesson_remote_datasource.dart';
import 'package:katadia_app/core/network/network_info.dart';

class LessonRepositoryImpl implements LessonRepository {
  final LessonRemoteDataSource remoteDataSource;
  final local_ds.LessonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LessonRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Lesson>>> getLessons({
    domain_category.CategoryFilter? filter,
    int page = 1,
    int limit = 20,
    String? searchQuery,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        // Try remote first, then cache locally
        final remoteResult = await remoteDataSource.getLessons(
          filter: filter,
          page: page,
          limit: limit,
          searchQuery: searchQuery,
        );

        return remoteResult.fold(
          (failure) async {
            // If remote fails, try local cache
            final localResult = await _getLessonsFromCache(
              filter: filter,
              page: page,
              limit: limit,
              searchQuery: searchQuery,
            );
            return localResult;
          },
          (lessons) async {
            // Cache the results
            await _cacheLessons(lessons);
            return Right(lessons);
          },
        );
      } else {
        // Offline, use cache
        return await _getLessonsFromCache(
          filter: filter,
          page: page,
          limit: limit,
          searchQuery: searchQuery,
        );
      }
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get lessons: $e'));
    }
  }

  @override
  Future<Either<Failure, Lesson>> getLessonById(String lessonId) async {
    try {
      if (await networkInfo.isConnected) {
        final remoteResult = await remoteDataSource.getLessonById(lessonId);
        
        return remoteResult.fold(
          (failure) async {
            // Try local cache if remote fails
            final localLesson = await localDataSource.getLessonById(lessonId);
            if (localLesson != null) {
              return Right(localLesson);
            }
            return Left(failure);
          },
          (lesson) async {
            // Cache the lesson
            await localDataSource.cacheLesson(lesson);
            return Right(lesson);
          },
        );
      } else {
        final localLesson = await localDataSource.getLessonById(lessonId);
        if (localLesson != null) {
          return Right(localLesson);
        }
        return Left(NetworkFailure('No internet connection and lesson not cached'));
      }
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get lesson: $e'));
    }
  }

  @override
  Future<Either<Failure, List<LessonContent>>> getLessonContent(String lessonId) async {
    try {
      if (await networkInfo.isConnected) {
        final remoteResult = await remoteDataSource.getLessonContent(lessonId);
        
        return remoteResult.fold(
          (failure) async {
            // Try local cache if remote fails
            final localContent = await localDataSource.getLessonContent(lessonId);
            if (localContent.isNotEmpty) {
              return Right(localContent);
            }
            return Left(failure);
          },
          (content) async {
            // Cache the content
            await localDataSource.cacheLessonContent(lessonId, content);
            return Right(content);
          },
        );
      } else {
        final localContent = await localDataSource.getLessonContent(lessonId);
        if (localContent.isNotEmpty) {
          return Right(localContent);
        }
        return Left(NetworkFailure('No internet connection and content not cached'));
      }
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get lesson content: $e'));
    }
  }

  @override
  Future<Either<Failure, LessonContent>> getContentById(String contentId) async {
    try {
      if (await networkInfo.isConnected) {
        final remoteResult = await remoteDataSource.getContentById(contentId);
        
        return remoteResult.fold(
          (failure) async {
            return Left(failure); // Content not in local cache for individual items
          },
          (content) {
            return Right(content);
          },
        );
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get content: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateLessonProgress(
    String lessonId,
    LessonProgress progress,
  ) async {
    try {
      // Always update local cache first
      await localDataSource.updateLessonProgress(progress);
      
      // Then try to sync with remote if online
      if (await networkInfo.isConnected) {
        final remoteResult = await remoteDataSource.updateLessonProgress(
          lessonId,
          progress,
        );
        
        return remoteResult.fold(
          (failure) {
            // Local update succeeded, remote failed - still consider success
            return const Right(null);
          },
          (_) {
            return const Right(null);
          },
        );
      }
      
      // Offline already updated locally
      return const Right(null);
    } catch (e) {
      return Left(UnexpectedFailure('Failed to update progress: $e'));
    }
  }

  @override
  Future<Either<Failure, LessonProgress?>> getLessonProgress(String lessonId) async {
    try {
      // Check local cache first
      final localProgress = await localDataSource.getLessonProgress(lessonId);
      
      if (await networkInfo.isConnected) {
        final remoteResult = await remoteDataSource.getLessonProgress(lessonId);
        
        return remoteResult.fold(
          (failure) {
            // Return local if available
            return Right(localProgress);
          },
          (remoteProgress) async {
            // Update local with remote data if Remote has newer data
            if (remoteProgress != null) {
              await localDataSource.updateLessonProgress(remoteProgress);
              return Right(remoteProgress);
            }
            return Right(localProgress);
          },
        );
      }
      
      return Right(localProgress);
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get lesson progress: $e'));
    }
  }

  @override
  Future<Either<Failure, List<LessonProgress>>> getUserProgress() async {
    try {
      // Always get from local cache first
      final localProgress = await localDataSource.getUserProgress();
      
      if (await networkInfo.isConnected) {
        final remoteResult = await remoteDataSource.getUserProgress();
        
        return remoteResult.fold(
          (failure) {
            // Return local if available
            return Right(localProgress);
          },
          (remoteProgress) async {
            // Update local with remote data
            for (final progress in remoteProgress) {
              await localDataSource.updateLessonProgress(progress);
            }
            return Right(remoteProgress);
          },
        );
      }
      
      return Right(localProgress);
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get user progress: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> toggleLessonBookmark(
    String lessonId,
    bool bookmarked,
  ) async {
    try {
      // Update local cache first
      await localDataSource.toggleBookmark(lessonId, bookmarked);
      
      // Then try to sync with remote if online
      if (await networkInfo.isConnected) {
        final remoteResult = await remoteDataSource.toggleLessonBookmark(
          lessonId,
          bookmarked,
        );
        
        return remoteResult.fold(
          (failure) {
            // Local update succeeded, remote failed - still consider success
            return const Right(null);
          },
          (_) {
            return const Right(null);
          },
        );
      }
      
      // Offline already updated locally
      return const Right(null);
    } catch (e) {
      return Left(UnexpectedFailure('Failed to toggle bookmark: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Lesson>>> getBookmarkedLessons() async {
    try {
      if (await networkInfo.isConnected) {
        final remoteResult = await remoteDataSource.getBookmarkedLessons();
        
        return remoteResult.fold(
          (failure) async {
            // Try local cache if remote fails
            return Right(await localDataSource.getBookmarkedLessons());
          },
          (lessons) async {
            // Cache the results
            await _cacheLessons(lessons);
            return Right(lessons);
          },
        );
      } else {
        return Right(await localDataSource.getBookmarkedLessons());
      }
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get bookmarked lessons: $e'));
    }
  }

  @override
  Future<Either<Failure, List<domain_category.Category>>> getCategories() async {
    try {
      if (await networkInfo.isConnected) {
        final remoteResult = await remoteDataSource.getCategories();
        
        return remoteResult.fold(
          (failure) async {
            // Try local cache if remote fails
            final localCategories = await localDataSource.getCategories();
            return Right(_convertLocalCategoriesToDomain(localCategories));
          },
          (categories) {
            // Cache the results
            _cacheCategories(categories);
            return Right(categories);
          },
        );
      } else {
        final localCategories = await localDataSource.getCategories();
        return Right(_convertLocalCategoriesToDomain(localCategories));
      }
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get categories: $e'));
    }
  }

  @override
  Future<Either<Failure, List<domain_category.FeaturedSection>>> getFeaturedSections() async {
    try {
      if (await networkInfo.isConnected) {
        final remoteResult = await remoteDataSource.getFeaturedSections();
        
        return remoteResult.fold(
          (failure) {
            return Left(failure); // Featured sections not cached locally
          },
          (sections) {
            return Right(sections);
          },
        );
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get featured sections: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Lesson>>> getFeaturedLessons(String sectionId) async {
    try {
      if (await networkInfo.isConnected) {
        final remoteResult = await remoteDataSource.getFeaturedLessons(sectionId);
        
        return remoteResult.fold(
          (failure) {
            return Left(failure);
          },
          (lessons) async {
            await _cacheLessons(lessons);
            return Right(lessons);
          },
        );
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get featured lessons: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Lesson>>> searchLessons({
    required String query,
    domain_category.CategoryFilter? filter,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final remoteResult = await remoteDataSource.searchLessons(
          query: query,
          filter: filter,
          page: page,
          limit: limit,
        );
        
        return remoteResult.fold(
          (failure) async {
            // Try local search if remote fails
            final localLessons = await localDataSource.searchLessons(query);
            return Right(localLessons);
          },
          (lessons) async {
            await _cacheLessons(lessons);
            return Right(lessons);
          },
        );
      } else {
        final localLessons = await localDataSource.searchLessons(query);
        return Right(localLessons);
      }
    } catch (e) {
      return Left(UnexpectedFailure('Failed to search lessons: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Lesson>>> getRecommendedLessons({
    String? userId,
    int limit = 10,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final remoteResult = await remoteDataSource.getRecommendedLessons(
          userId: userId,
          limit: limit,
        );
        
        return remoteResult.fold(
          (failure) {
            return Left(failure);
          },
          (lessons) async {
            await _cacheLessons(lessons);
            return Right(lessons);
          },
        );
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get recommended lessons: $e'));
    }
  }

  // Placeholder methods for future implementation
  
  @override
  Future<Either<Failure, List<Lesson>>> getDownloadableLessons() async {
    // TODO: Implement downloadable lessons logic
    return const Right([]);
  }

  @override
  Future<Either<Failure, bool>> downloadLesson(String lessonId) async {
    // TODO: Implement lesson download logic
    return const Right(false);
  }

  @override
  Future<Either<Failure, void>> removeCachedLesson(String lessonId) async {
    try {
      await localDataSource.deleteCachedLesson(lessonId);
      return const Right(null);
    } catch (e) {
      return Left(UnexpectedFailure('Failed to remove cached lesson: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, bool>>> getSyncStatus() async {
    try {
      final isCached = await localDataSource.isLessonCached('dummy_id');
      return Right({'online': await networkInfo.isConnected, 'hasCache': isCached});
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get sync status: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> syncLessons() async {
    try {
      if (await networkInfo.isConnected) {
        // TODO: Implement sync logic
        return const Right(null);
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(UnexpectedFailure('Failed to sync lessons: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> reportLessonIssue({
    required String lessonId,
    required String issue,
    String? contentId,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        return await remoteDataSource.reportLessonIssue(
          lessonId: lessonId,
          issue: issue,
          contentId: contentId,
        );
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(UnexpectedFailure('Failed to report issue: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> rateLesson({
    required String lessonId,
    required double rating,
    String? review,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        return await remoteDataSource.rateLesson(
          lessonId: lessonId,
          rating: rating,
          review: review,
        );
      } else {
        // Store rating locally and sync later
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(UnexpectedFailure('Failed to rate lesson: $e'));
    }
  }

  @override
  Future<Either<Failure, List<LessonRating>>> getLessonRatings(String lessonId) async {
    try {
      if (await networkInfo.isConnected) {
        return await remoteDataSource.getLessonRatings(lessonId);
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get lesson ratings: $e'));
    }
  }

  // Helper methods
  Future<Either<Failure, List<Lesson>>> _getLessonsFromCache({
    domain_category.CategoryFilter? filter,
    int page = 1,
    int limit = 20,
    String? searchQuery,
  }) async {
    try {
      if (searchQuery != null) {
        final lessons = await localDataSource.searchLessons(searchQuery);
        return Right(lessons.skip((page - 1) * limit).take(limit).toList());
      } else {
        final lessons = await localDataSource.getLessons(limit: limit, offset: (page - 1) * limit);
        return Right(lessons);
      }
    } catch (e) {
      return Left(CacheFailure('Failed to get lessons from cache: $e'));
    }
  }

  Future<void> _cacheLessons(List<Lesson> lessons) async {
    try {
      await localDataSource.cacheLessons(lessons);
    } catch (e) {
      // Cache failure shouldn't block the main flow
    }
  }

  Future<void> _cacheCategories(List<domain_category.Category> categories) async {
    try {
      // TODO: Implement category caching
    } catch (e) {
      // Cache failure shouldn't block the main flow
    }
  }

  List<domain_category.Category> _convertLocalCategoriesToDomain(
      List<local_ds.Category> localCategories) {
    return localCategories
        .map((localCat) => domain_category.Category(
              id: localCat.id,
              name: localCat.name,
              description: localCat.description,
              iconUrl: localCat.iconUrl,
              imageUrl: localCat.imageUrl,
              color: localCat.color,
              lessonCount: localCat.lessonCount ?? 0,
              totalDuration: localCat.totalDuration ?? 0,
              levels: localCat.levels,
              difficulty: localCat.difficulty,
              isActive: localCat.isActive ?? true,
              sortOrder: localCat.sortOrder ?? 0,
              featured: localCat.featured ?? false,
              createdAt: localCat.createdAt,
              updatedAt: localCat.updatedAt,
            ))
        .toList();
  }
  
  @override
  Future<Either<Failure, void>> trackLessonStart(String lessonId) async {
    // TODO: Implement tracking logic
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> trackLessonComplete({
    required String lessonId,
    required double score,
    required int timeSpent,
  }) async {
    // TODO: Implement tracking logic
    return const Right(null);
  }

  @override
  Future<Either<Failure, LearningStreak>> getLearningStreak(String userId) async {
    // TODO: Implement streak logic
    return Right(LearningStreak(userId: userId));
  }

  @override
  Future<Either<Failure, LearningStreak>> updateLearningStreak({
    required String userId,
    DateTime? activityDate,
  }) async {
    // TODO: Implement streak update logic
    return Right(LearningStreak(userId: userId));
  }

  @override
  Future<Either<Failure, CEFRLevel>> getUserSkillLevel(String userId) async {
    // TODO: Implement skill level assessment
    return const Right(CEFRLevel.a1);
  }

  @override
  Future<Either<Failure, void>> updateUserSkillLevel({
    required String userId,
    required CEFRLevel newLevel,
  }) async {
    // TODO: Implement skill level update
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> clearCache() async {
    try {
      await localDataSource.clearAllCache();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to clear cache: $e'));
    }
  }

  @override
  Future<Either<Failure, int>> getCacheSize() async {
    try {
      final size = await localDataSource.getCacheSize();
      return Right(size);
    } catch (e) {
      return Left(CacheFailure('Failed to get cache size: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isLessonCached(String lessonId) async {
    try {
      final isCached = await localDataSource.isLessonCached(lessonId);
      return Right(isCached);
    } catch (e) {
      return Left(CacheFailure('Failed to check cache status: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> batchUpdateProgress(
    List<LessonProgress> progressList,
  ) async {
    try {
      for (final progress in progressList) {
        await localDataSource.updateLessonProgress(progress);
      }
      return const Right(null);
    } catch (e) {
      return Left(UnexpectedFailure('Failed to batch update progress: $e'));
    }
  }

  @override
  Future<Either<Failure, LearningAnalytics>> getLearningAnalytics(String userId) async {
    // TODO: Implement analytics logic
    throw UnimplementedError('Learning analytics not yet implemented');
  }

  @override
  Future<Either<Failure, bool>> isContentAvailable(String contentId) async {
    try {
      if (await networkInfo.isConnected) {
        return await remoteDataSource.isContentAvailable(contentId);
      } else {
        // Check local cache
        // TODO: Implement local availability check
        return const Right(false);
      }
    } catch (e) {
      return Left(UnexpectedFailure('Failed to check content availability: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> preloadContent(List<String> contentIds) async {
    try {
      if (await networkInfo.isConnected) {
        // TODO: Implement preloading logic
        return const Right(null);
      } else {
        return Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(UnexpectedFailure('Failed to preload content: $e'));
    }
  }
}

