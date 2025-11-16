import 'package:dartz/dartz.dart';
import 'package:katadia_app/core/errors/failures.dart';
import 'package:katadia_app/core/network/dio_client.dart';
import 'package:katadia_app/core/constants/api_endpoints.dart';
import 'package:katadia_app/features/lessons/domain/entities/category.dart';
import 'package:katadia_app/features/lessons/domain/entities/lesson.dart';
import 'package:katadia_app/features/lessons/domain/entities/lesson_content.dart';
import 'package:katadia_app/features/lessons/domain/entities/lesson_progress.dart';
import 'package:katadia_app/features/lessons/domain/repositories/lesson_repository.dart';
import 'package:katadia_app/features/lessons/presentation/state/lesson_filter_state.dart';

abstract class LessonRemoteDataSource {
  Future<Either<Failure, List<Lesson>>> getLessons({
    CategoryFilter? filter,
    int page = 1,
    int limit = 20,
    String? searchQuery,
  });

  Future<Either<Failure, Lesson>> getLessonById(String lessonId);

  Future<Either<Failure, List<LessonContent>>> getLessonContent(String lessonId);

  Future<Either<Failure, LessonContent>> getContentById(String contentId);

  Future<Either<Failure, void>> updateLessonProgress(
    String lessonId,
    LessonProgress progress,
  );

  Future<Either<Failure, LessonProgress?>> getLessonProgress(String lessonId);

  Future<Either<Failure, List<LessonProgress>>> getUserProgress();

  Future<Either<Failure, void>> toggleLessonBookmark(
    String lessonId,
    bool bookmarked,
  );

  Future<Either<Failure, List<Lesson>>> getBookmarkedLessons();

  Future<Either<Failure, List<Category>>> getCategories();

  Future<Either<Failure, List<FeaturedSection>>> getFeaturedSections();

  Future<Either<Failure, List<Lesson>>> getFeaturedLessons(String sectionId);

  Future<Either<Failure, List<Lesson>>> searchLessons({
    required String query,
    CategoryFilter? filter,
    int page = 1,
    int limit = 20,
  });

  Future<Either<Failure, List<Lesson>>> getRecommendedLessons({
    String? userId,
    int limit = 10,
  });

  Future<Either<Failure, bool>> isContentAvailable(String contentId);

  Future<Either<Failure, void>> reportLessonIssue({
    required String lessonId,
    required String issue,
    String? contentId,
  });

  Future<Either<Failure, void>> rateLesson({
    required String lessonId,
    required double rating,
    String? review,
  });

  Future<Either<Failure, List<LessonRating>>> getLessonRatings(String lessonId);
}

class LessonRemoteDataSourceImpl implements LessonRemoteDataSource {
  final DioClient _dioClient;

  LessonRemoteDataSourceImpl(this._dioClient);

  @override
  Future<Either<Failure, List<Lesson>>> getLessons({
    CategoryFilter? filter,
    int page = 1,
    int limit = 20,
    String? searchQuery,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };

      if (searchQuery != null) {
        queryParams['search'] = searchQuery;
      }

      if (filter != null) {
        if (filter.selectedCategories.isNotEmpty) {
          queryParams['categories'] = filter.selectedCategories.join(',');
        }
        if (filter.selectedLevels.isNotEmpty) {
          queryParams['levels'] = filter.selectedLevels.join(',');
        }
        if (filter.selectedTypes.isNotEmpty) {
          queryParams['types'] = filter.selectedTypes.join(',');
        }
        if (filter.priceFilter != PriceFilter.all) {
          queryParams['price'] = filter.priceFilter.name;
        }
      }

      final response = await _dioClient.get<dynamic>(
        ApiEndpoints.lessons,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = (response.data['data'] as List<dynamic>?) ?? [];
        final lessons = responseData
            .map((json) => _parseLessonFromJson(json as Map<String, dynamic>))
            .whereType<Lesson>()
            .toList();

        return Right(lessons);
      } else {
        return Left(ServerFailure(
          'Failed to fetch lessons',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, Lesson>> getLessonById(String lessonId) async {
    try {
      final response = await _dioClient.get<dynamic>(
        '${ApiEndpoints.lessons}/$lessonId',
      );

      if (response.statusCode == 200) {
        final lesson = _parseLessonFromJson(response.data['data'] as Map<String, dynamic>);
        if (lesson == null) {
          return Left(ServerFailure('Failed to parse lesson data'));
        }
        return Right(lesson);
      } else if (response.statusCode == 404) {
        return Left(LessonNotFoundFailure(lessonId));
      } else {
        return Left(ServerFailure(
          'Failed to fetch lesson',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<LessonContent>>> getLessonContent(String lessonId) async {
    try {
      final response = await _dioClient.get<dynamic>(
        '${ApiEndpoints.lessons}/$lessonId/content',
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = (response.data['data'] as List<dynamic>?) ?? [];
        final content = responseData
            .map((json) => _parseLessonContentFromJson(json as Map<String, dynamic>))
            .whereType<LessonContent>()
            .toList();

        return Right(content);
      } else {
        return Left(ServerFailure(
          'Failed to fetch lesson content',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, LessonContent>> getContentById(String contentId) async {
    try {
      final response = await _dioClient.get<dynamic>(
        '${ApiEndpoints.content}/$contentId',
      );

      if (response.statusCode == 200) {
        final content = _parseLessonContentFromJson(response.data['data'] as Map<String, dynamic>);
        if (content == null) {
          return Left(ServerFailure('Failed to parse content data'));
        }
        return Right(content);
      } else if (response.statusCode == 404) {
        return Left(ContentNotFoundFailure(contentId));
      } else {
        return Left(ServerFailure(
          'Failed to fetch content',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> updateLessonProgress(
    String lessonId,
    LessonProgress progress,
  ) async {
    try {
      final response = await _dioClient.post<dynamic>(
        '${ApiEndpoints.lessons}/$lessonId/progress',
        data: _serializeProgressToJson(progress),
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(ServerFailure(
          'Failed to update progress',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, LessonProgress?>> getLessonProgress(String lessonId) async {
    try {
      final response = await _dioClient.get<dynamic>(
        '${ApiEndpoints.lessons}/$lessonId/progress',
      );

      if (response.statusCode == 200) {
        final progress = _parseProgressFromJson(response.data['data'] as Map<String, dynamic>);
        return Right(progress);
      } else if (response.statusCode == 404) {
        return const Right(null);
      } else {
        return Left(ServerFailure(
          'Failed to fetch progress',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<LessonProgress>>> getUserProgress() async {
    try {
      final response = await _dioClient.get<dynamic>(ApiEndpoints.progress);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = (response.data['data'] as List<dynamic>?) ?? [];
        final progressList = responseData
            .map((json) => _parseProgressFromJson(json as Map<String, dynamic>))
            .whereType<LessonProgress>()
            .toList();

        return Right(progressList);
      } else {
        return Left(ServerFailure(
          'Failed to fetch user progress',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> toggleLessonBookmark(
    String lessonId,
    bool bookmarked,
  ) async {
    try {
      final response = await _dioClient.post<dynamic>(
        '${ApiEndpoints.lessons}/$lessonId/bookmark',
        data: {'bookmarked': bookmarked},
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(ServerFailure(
          'Failed to update bookmark',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<Lesson>>> getBookmarkedLessons() async {
    try {
      final response = await _dioClient.get<dynamic>(ApiEndpoints.bookmarkedLessons);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = (response.data['data'] as List<dynamic>?) ?? [];
        final lessons = responseData
            .map((json) => _parseLessonFromJson(json as Map<String, dynamic>))
            .whereType<Lesson>()
            .toList();

        return Right(lessons);
      } else {
        return Left(ServerFailure(
          'Failed to fetch bookmarked lessons',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final response = await _dioClient.get<dynamic>(ApiEndpoints.categories);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = (response.data['data'] as List<dynamic>?) ?? [];
        final categories = responseData
            .map((json) => _parseCategoryFromJson(json as Map<String, dynamic>))
            .whereType<Category>()
            .toList();

        return Right(categories);
      } else {
        return Left(ServerFailure(
          'Failed to fetch categories',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<FeaturedSection>>> getFeaturedSections() async {
    try {
      final response = await _dioClient.get<dynamic>(ApiEndpoints.featuredSections);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = (response.data['data'] as List<dynamic>?) ?? [];
        final sections = responseData
            .map((json) => _parseFeaturedSectionFromJson(json as Map<String, dynamic>))
            .whereType<FeaturedSection>()
            .toList();

        return Right(sections);
      } else {
        return Left(ServerFailure(
          'Failed to fetch featured sections',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<Lesson>>> getFeaturedLessons(String sectionId) async {
    try {
      final response = await _dioClient.get<dynamic>(
        '${ApiEndpoints.featuredSections}/$sectionId/lessons',
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = (response.data['data'] as List<dynamic>?) ?? [];
        final lessons = responseData
            .map((json) => _parseLessonFromJson(json as Map<String, dynamic>))
            .whereType<Lesson>()
            .toList();

        return Right(lessons);
      } else {
        return Left(ServerFailure(
          'Failed to fetch featured lessons',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<Lesson>>> searchLessons({
    required String query,
    CategoryFilter? filter,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'q': query,
        'page': page,
        'limit': limit,
      };

      if (filter != null) {
        if (filter.selectedCategories.isNotEmpty) {
          queryParams['categories'] = filter.selectedCategories.join(',');
        }
        if (filter.selectedLevels.isNotEmpty) {
          queryParams['levels'] = filter.selectedLevels.join(',');
        }
      }

      final response = await _dioClient.get<dynamic>(
        '${ApiEndpoints.lessons}/search',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = (response.data['data'] as List<dynamic>?) ?? [];
        final lessons = responseData
            .map((json) => _parseLessonFromJson(json as Map<String, dynamic>))
            .whereType<Lesson>()
            .toList();

        return Right(lessons);
      } else {
        return Left(ServerFailure(
          'Failed to search lessons',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<Lesson>>> getRecommendedLessons({
    String? userId,
    int limit = 10,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'limit': limit,
      };

      if (userId != null) {
        queryParams['user_id'] = userId;
      }

      final response = await _dioClient.get<dynamic>(
        ApiEndpoints.recommendedLessons,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = (response.data['data'] as List<dynamic>?) ?? [];
        final lessons = responseData
            .map((json) => _parseLessonFromJson(json as Map<String, dynamic>))
            .whereType<Lesson>()
            .toList();

        return Right(lessons);
      } else {
        return Left(ServerFailure(
          'Failed to fetch recommended lessons',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, bool>> isContentAvailable(String contentId) async {
    try {
      final response = await _dioClient.head('${ApiEndpoints.content}/$contentId');

      if (response.statusCode == 200) {
        return const Right(true);
      } else if (response.statusCode == 404) {
        return const Right(false);
      } else {
        return Left(ServerFailure(
          'Failed to check content availability',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> reportLessonIssue({
    required String lessonId,
    required String issue,
    String? contentId,
  }) async {
    try {
      final data = <String, dynamic>{
        'lesson_id': lessonId,
        'issue': issue,
      };

      if (contentId != null) {
        data['content_id'] = contentId;
      }

      final response = await _dioClient.post<dynamic>(
        '${ApiEndpoints.lessons}/$lessonId/report',
        data: data,
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(ServerFailure(
          'Failed to report issue',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> rateLesson({
    required String lessonId,
    required double rating,
    String? review,
  }) async {
    try {
      final data = <String, dynamic>{
        'rating': rating,
      };

      if (review != null) {
        data['review'] = review;
      }

      final response = await _dioClient.post<dynamic>(
        '${ApiEndpoints.lessons}/$lessonId/rate',
        data: data,
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(ServerFailure(
          'Failed to rate lesson',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<LessonRating>>> getLessonRatings(String lessonId) async {
    try {
      final response = await _dioClient.get<dynamic>(
        '${ApiEndpoints.lessons}/$lessonId/ratings',
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = (response.data['data'] as List<dynamic>?) ?? [];
        final ratings = responseData
            .map((json) => _parseLessonRatingFromJson(json as Map<String, dynamic>))
            .whereType<LessonRating>()
            .toList();

        return Right(ratings);
      } else {
        return Left(ServerFailure(
          'Failed to fetch lesson ratings',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  // Helper methods for parsing and serialization
  Lesson? _parseLessonFromJson(Map<String, dynamic> json) {
    try {
      return Lesson(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        level: _parseCEFRLevel(json['level'] as String?),
        category: _parseLessonCategory(json['category'] as String?),
        type: _parseLessonType(json['type'] as String?),
        duration: json['duration'] as int? ?? 0,
        difficulty: (json['difficulty'] as num?)?.toDouble() ?? 0.0,
        imageUrl: json['image_url'] as String?,
        audioUrl: json['audio_url'] as String?,
        isPremium: json['is_premium'] as bool? ?? false,
        isCompleted: json['is_completed'] as bool? ?? false,
        progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
        bookmarked: json['bookmarked'] as bool? ?? false,
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        totalRatings: json['total_ratings'] as int? ?? 0,
        tags: (json['tags'] as List<dynamic>?)
                ?.map((tag) => tag.toString())
                .toList() ??
            [],
        prerequisites: (json['prerequisites'] as List<dynamic>?)
                ?.map((prereq) => prereq.toString())
                .toList() ??
            [],
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'] as String)
            : null,
        lastAccessed: json['last_accessed'] != null
            ? DateTime.parse(json['last_accessed'] as String)
            : null,
      );
    } catch (e) {
      // Log parsing error
      return null;
    }
  }

  LessonContent? _parseLessonContentFromJson(Map<String, dynamic> json) {
    try {
      return LessonContent(
        id: json['id'] as String,
        lessonId: json['lesson_id'] as String,
        title: json['title'] as String,
        contentType: _parseContentType(json['content_type'] as String?),
        order: json['order'] as int? ?? 0,
        text: json['text'] as String?,
        audioUrl: json['audio_url'] as String?,
        imageUrl: json['image_url'] as String?,
        videoUrl: json['video_url'] as String?,
        interactiveData: json['interactive_data'] as Map<String, dynamic>?,
        duration: json['duration'] as int?,
        phoneticTranscription: json['phonetic_transcription'] as String?,
        translation: json['translation'] as String?,
        difficulty: (json['difficulty'] as num?)?.toDouble(),
        isCompleted: json['is_completed'] as bool? ?? false,
        userScore: (json['user_score'] as num?)?.toDouble(),
        metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      );
    } catch (e) {
      // Log parsing error
      return null;
    }
  }

  LessonProgress? _parseProgressFromJson(Map<String, dynamic> json) {
    try {
      final contentProgressList = (json['content_progress'] as List<dynamic>?)
          ?.map((cp) => ContentProgress(
                contentId: cp['content_id'] as String,
                status: _parseCompletionStatus(cp['status'] as String?),
                score: (cp['score'] as num?)?.toDouble(),
                timeSpent: cp['time_spent'] as int? ?? 0,
                attempts: cp['attempts'] as int? ?? 0,
                userFeedback: cp['user_feedback'] as String?,
                metadata: cp['metadata'] as Map<String, dynamic>? ?? {},
              ))
          .toList() ??
          [];

      return LessonProgress(
        lessonId: json['lesson_id'] as String,
        userId: json['user_id'] as String,
        startedAt: json['started_at'] != null
            ? DateTime.parse(json['started_at'] as String)
            : null,
        lastAccessed: json['last_accessed'] != null
            ? DateTime.parse(json['last_accessed'] as String)
            : null,
        completedAt: json['completed_at'] != null
            ? DateTime.parse(json['completed_at'] as String)
            : null,
        completionStatus: _parseCompletionStatus(json['completion_status'] as String?),
        overallScore: (json['overall_score'] as num?)?.toDouble(),
        totalTimeSpent: json['total_time_spent'] as int? ?? 0,
        contentProgress: contentProgressList,
        streakDays: json['streak_days'] as int? ?? 0,
        attempts: json['attempts'] as int? ?? 0,
        bookmarked: json['bookmarked'] as bool? ?? false,
        notes: json['notes'] as String?,
        metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      );
    } catch (e) {
      // Log parsing error
      return null;
    }
  }

  Category? _parseCategoryFromJson(Map<String, dynamic> json) {
    try {
      return Category(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        iconUrl: json['icon_url'] as String?,
        imageUrl: json['image_url'] as String?,
        color: json['color'] as String?,
        lessonCount: json['lesson_count'] as int? ?? 0,
        totalDuration: json['total_duration'] as int? ?? 0,
        levels: (json['levels'] as List<dynamic>?)
            ?.map((level) => level.toString())
            .toList(),
        difficulty: (json['difficulty'] as num?)?.toDouble(),
        isActive: json['is_active'] as bool? ?? true,
        sortOrder: json['sort_order'] as int? ?? 0,
        featured: json['featured'] as bool? ?? false,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'] as String)
            : null,
      );
    } catch (e) {
      // Log parsing error
      return null;
    }
  }

  FeaturedSection? _parseFeaturedSectionFromJson(Map<String, dynamic> json) {
    try {
      return FeaturedSection(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        sectionType: _parseFeaturedSectionType(json['section_type'] as String?),
        lessonIds: (json['lesson_ids'] as List<dynamic>?)
                ?.map((id) => id.toString())
                .toList() ??
            [],
        imageUrl: json['image_url'] as String?,
        isActive: json['is_active'] as bool? ?? true,
        displayLimit: json['display_limit'] as int? ?? 10,
        featureOrder: json['feature_order'] as int? ?? 0,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'] as String)
            : null,
      );
    } catch (e) {
      // Log parsing error
      return null;
    }
  }

  LessonRating? _parseLessonRatingFromJson(Map<String, dynamic> json) {
    try {
      return LessonRating(
        id: json['id'] as String,
        userId: json['user_id'] as String,
        lessonId: json['lesson_id'] as String,
        rating: (json['rating'] as num).toDouble(),
        review: json['review'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
        helpful: json['helpful'] as bool? ?? false,
      );
    } catch (e) {
      // Log parsing error
      return null;
    }
  }

  Map<String, dynamic> _serializeProgressToJson(LessonProgress progress) {
    return {
      'lesson_id': progress.lessonId,
      'user_id': progress.userId,
      'completion_status': progress.completionStatus.name,
      'overall_score': progress.overallScore,
      'total_time_spent': progress.totalTimeSpent,
      'content_progress': progress.contentProgress
          .map((cp) => {
                'content_id': cp.contentId,
                'status': cp.status.name,
                'score': cp.score,
                'time_spent': cp.timeSpent,
                'attempts': cp.attempts,
                'user_feedback': cp.userFeedback,
                'metadata': cp.metadata,
              })
          .toList(),
      'streak_days': progress.streakDays,
      'attempts': progress.attempts,
      'bookmarked': progress.bookmarked,
      'notes': progress.notes,
      'metadata': progress.metadata,
    };
  }

  // Enum parsers
  CEFRLevel _parseCEFRLevel(String? level) {
    switch (level?.toLowerCase()) {
      case 'a1':
        return CEFRLevel.a1;
      case 'a2':
        return CEFRLevel.a2;
      case 'b1':
        return CEFRLevel.b1;
      case 'b2':
        return CEFRLevel.b2;
      case 'c1':
        return CEFRLevel.c1;
      case 'c2':
        return CEFRLevel.c2;
      default:
        return CEFRLevel.a1;
    }
  }

  LessonCategory _parseLessonCategory(String? category) {
    switch (category?.toLowerCase()) {
      case 'vocabulary':
        return LessonCategory.vocabulary;
      case 'grammar':
        return LessonCategory.grammar;
      case 'pronunciation':
        return LessonCategory.pronunciation;
      case 'phrases':
        return LessonCategory.phrases;
      case 'conversation':
        return LessonCategory.conversation;
      case 'listening':
        return LessonCategory.listening;
      default:
        return LessonCategory.vocabulary;
    }
  }

  LessonType _parseLessonType(String? type) {
    switch (type?.toLowerCase()) {
      case 'vocabulary':
        return LessonType.vocabulary;
      case 'grammar':
        return LessonType.grammar;
      case 'pronunciation':
        return LessonType.pronunciation;
      case 'phrase':
        return LessonType.phrase;
      case 'dialogue':
        return LessonType.dialogue;
      case 'exercise':
        return LessonType.exercise;
      default:
        return LessonType.vocabulary;
    }
  }

  ContentType _parseContentType(String? type) {
    switch (type?.toLowerCase()) {
      case 'text':
        return ContentType.text;
      case 'audio':
        return ContentType.audio;
      case 'image':
        return ContentType.image;
      case 'video':
        return ContentType.video;
      case 'interactive':
        return ContentType.interactive;
      case 'exercise':
        return ContentType.exercise;
      default:
        return ContentType.text;
    }
  }

  CompletionStatus _parseCompletionStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'inprogress':
        return CompletionStatus.inProgress;
      case 'completed':
        return CompletionStatus.completed;
      case 'skipped':
        return CompletionStatus.skipped;
      case 'failed':
        return CompletionStatus.failed;
      default:
        return CompletionStatus.notStarted;
    }
  }

  FeaturedSectionType _parseFeaturedSectionType(String? type) {
    switch (type?.toLowerCase()) {
      case 'recommended':
        return FeaturedSectionType.recommended;
      case 'trending':
        return FeaturedSectionType.trending;
      case 'newreleases':
        return FeaturedSectionType.newReleases;
      case 'continuelearning':
        return FeaturedSectionType.continueLearning;
      case 'beginners':
        return FeaturedSectionType.beginners;
      case 'advanced':
        return FeaturedSectionType.advanced;
      case 'quickpractice':
        return FeaturedSectionType.quickPractice;
      case 'weekendchallenge':
        return FeaturedSectionType.weekendChallenge;
      default:
        return FeaturedSectionType.recommended;
    }
  }

  Failure _handleException(dynamic exception) {
    if (exception is ServerFailure) return exception;
    
    // Handle network issues
    if (exception.toString().contains('SocketException') ||
        exception.toString().contains('NetworkException')) {
      return const NetworkFailure('Network connection failed');
    }
    
    // Handle timeout
    if (exception.toString().contains('TimeoutException')) {
      return const TimeoutFailure('Request timed out');
    }
    
    // Handle parsing issues
    if (exception is FormatException) {
      return const ParsingFailure('Failed to parse server response');
    }
    
    // Default to unexpected error
    return UnexpectedFailure('An unexpected error occurred: $exception');
  }
}




