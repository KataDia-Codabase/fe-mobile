import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/lesson.dart';
import '../../domain/entities/category.dart';
import '../state/lesson_filter_state.dart';

// Enhanced provider dengan proper error handling
final enhancedLessonNotifierProvider = StateNotifierProvider<EnhancedLessonNotifier, LessonState>(
  (ref) => EnhancedLessonNotifier(),
);

final enhancedCategoryNotifierProvider = StateNotifierProvider<EnhancedCategoryNotifier, CategoryState>(
  (ref) => EnhancedCategoryNotifier(),
);

final enhancedLessonFilterNotifierProvider = StateNotifierProvider<EnhancedLessonFilterNotifier, LessonFilterState>(
  (ref) => EnhancedLessonFilterNotifier(),
);

// Enhanced States
abstract class LessonState {
  const LessonState();
}

class LessonInitial extends LessonState {
  const LessonInitial();
}

class LessonLoading extends LessonState {
  const LessonLoading();
}

class LessonLoaded extends LessonState {
  final List<Lesson> lessons;
  final bool hasMore;
  final int? totalCount;
  
  const LessonLoaded({
    required this.lessons,
    this.hasMore = false,
    this.totalCount,
  });
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonLoaded &&
          runtimeType == other.runtimeType &&
          lessons == other.lessons &&
          hasMore == other.hasMore &&
          totalCount == other.totalCount;
  
  @override
  int get hashCode => Object.hash(lessons, hasMore, totalCount);
}

class LessonError extends LessonState {
  final String message;
  final Exception? exception;
  
  const LessonError(this.message, {this.exception});
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonError &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          exception == other.exception;
  
  @override
  int get hashCode => message.hashCode ^ exception.hashCode;
}

abstract class CategoryState {
  const CategoryState();
  
  bool get isLoading => this is CategoryLoading;
  bool get hasError => this is CategoryError;
  String? get errorMessage => switch (this) {
    CategoryError(:final message) => message,
    _ => null,
  };
}

class CategoryInitial extends CategoryState {
  const CategoryInitial();
}

class CategoryLoading extends CategoryState {
  const CategoryLoading();
}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;
  
  const CategoryLoaded(this.categories);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryLoaded &&
          runtimeType == other.runtimeType &&
          categories == other.categories;
  
  @override
  int get hashCode => categories.hashCode;
}

class CategoryError extends CategoryState {
  final String message;
  final Exception? exception;
  
  const CategoryError(this.message, {this.exception});
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryError &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          exception == other.exception;
  
  @override
  int get hashCode => message.hashCode ^ exception.hashCode;
}

// Enhanced Notifiers
class EnhancedLessonNotifier extends StateNotifier<LessonState> {
  EnhancedLessonNotifier() : super(const LessonInitial());

  Future<void> loadLessons({
    LessonFilter? filter,
    bool refresh = false,
  }) async {
    if (refresh) {
      state = const LessonInitial();
    } else {
      state = const LessonLoading();
    }

    try {
      // Simulate API call delay
      await Future<void>.delayed(const Duration(milliseconds: 800));
      
      final lessons = _getMockLessons();
      state = LessonLoaded(
        lessons: lessons,
        hasMore: false,
        totalCount: lessons.length,
      );
    } catch (e, stackTrace) {
      state = LessonError(
        'Failed to load lessons: ${e.toString()}',
        exception: e is Exception ? e : Exception(e.toString()),
      );
      // Log error for debugging
      print('Error loading lessons: $e');
      print('Stack trace: $stackTrace');
    }
  }

  Future<void> loadMoreLessons({
    LessonFilter? filter,
    String? searchQuery,
  }) async {
    final currentState = state;
    if (currentState is! LessonLoaded) return;
    if (currentState.hasMore == false) return;

    try {
      // Simulate loading more lessons
      await Future<void>.delayed(const Duration(milliseconds: 500));
      
      final additionalLessons = <Lesson>[]; // No more lessons in mock
      final updatedLessons = [...currentState.lessons, ...additionalLessons];
      
      state = LessonLoaded(
        lessons: updatedLessons,
        hasMore: false,
        totalCount: currentState.totalCount,
      );
    } catch (e, stackTrace) {
      // Keep existing lessons, just mark error
      state = currentState;
      print('Error loading more lessons: $e');
      print('Stack trace: $stackTrace');
    }
  }

  Future<void> refreshLessons({
    LessonFilter? filter,
    String? searchQuery,
  }) async {
    await loadLessons(filter: filter, refresh: true);
  }

  Future<void> toggleBookmark(String lessonId, bool bookmarked) async {
    final currentState = state;
    if (currentState is! LessonLoaded) return;

    try {
      final updatedLessons = currentState.lessons.map((lesson) {
        if (lesson.id == lessonId) {
          return lesson.copyWith(bookmarked: bookmarked);
        }
        return lesson;
      }).toList();

      state = LessonLoaded(
        lessons: updatedLessons,
        hasMore: currentState.hasMore,
        totalCount: currentState.totalCount,
      );
      
      // TODO: Save to backend
      print('Toggled bookmark for lesson $lessonId to $bookmarked');
    } catch (e, stackTrace) {
      print('Error toggling bookmark: $e');
      print('Stack trace: $stackTrace');
    }
  }

  void reset() {
    state = const LessonInitial();
  }

  List<Lesson> get currentLessons {
    return switch (state) {
      LessonLoaded(:final lessons) => lessons,
      _ => [],
    };
  }

  bool get isLoading => state is LessonLoading;
  bool get hasError => state is LessonError;
  bool get hasMore => switch (state) {
    LessonLoaded(:final hasMore) => hasMore,
    _ => false,
  };

  String? get errorMessage => switch (state) {
    LessonError(:final message) => message,
    _ => null,
  };

  List<Lesson> _getMockLessons() {
    return [
      Lesson(
        id: '1',
        title: 'Basic English Greetings',
        description: 'Learn essential English greetings for everyday conversations. Master hello, goodbye, and common pleasantries.',
        level: CEFRLevel.a1,
        category: LessonCategory.phrases,
        type: LessonType.phrase,
        duration: 45,
        difficulty: 0.2,
        isPremium: false,
        bookmarked: false,
        rating: 4.7,
        totalRatings: 156,
        tags: ['greetings', 'beginner', 'everyday'],
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        updatedAt: DateTime.now(),
        progress: 0.3,
      ),
      Lesson(
        id: '2',
        title: 'English Pronunciation Basics',
        description: 'Master English pronunciation with our comprehensive guide. Perfect your accent and sound like a native speaker.',
        level: CEFRLevel.a2,
        category: LessonCategory.pronunciation,
        type: LessonType.pronunciation,
        duration: 60,
        difficulty: 0.5,
        isPremium: true,
        bookmarked: true,
        rating: 4.9,
        totalRatings: 89,
        tags: ['pronunciation', 'speaking', 'accent'],
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now(),
        progress: 0.7,
      ),
      Lesson(
        id: '3',
        title: 'Common English Phrases',
        description: 'Essential phrases for daily English communication. Learn expressions used in everyday conversations.',
        level: CEFRLevel.b1,
        category: LessonCategory.phrases,
        type: LessonType.phrase,
        duration: 30,
        difficulty: 0.4,
        isPremium: false,
        bookmarked: false,
        rating: 4.5,
        totalRatings: 234,
        tags: ['phrases', 'communication', 'daily'],
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        updatedAt: DateTime.now(),
        progress: 0.0,
      ),
      Lesson(
        id: '4',
        title: 'Indonesian Basic Vocabulary',
        description: 'Build your Indonesian vocabulary foundation with common words and phrases used in daily life.',
        level: CEFRLevel.a1,
        category: LessonCategory.vocabulary,
        type: LessonType.vocabulary,
        duration: 40,
        difficulty: 0.3,
        isPremium: false,
        bookmarked: false,
        rating: 4.6,
        totalRatings: 178,
        tags: ['indonesian', 'vocabulary', 'basic'],
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now(),
        progress: 0.5,
      ),
      Lesson(
        id: '5',
        title: 'Advanced Grammar Structures',
        description: 'Deep dive into complex English grammar patterns and structures for fluent communication.',
        level: CEFRLevel.b2,
        category: LessonCategory.grammar,
        type: LessonType.grammar,
        duration: 75,
        difficulty: 0.8,
        isPremium: true,
        bookmarked: true,
        rating: 4.8,
        totalRatings: 92,
        tags: ['grammar', 'advanced', 'structures'],
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now(),
        progress: 0.2,
      ),
    ];
  }
}

class EnhancedCategoryNotifier extends StateNotifier<CategoryState> {
  EnhancedCategoryNotifier() : super(const CategoryInitial());

  Future<void> loadCategories() async {
    state = const CategoryLoading();
    
    try {
      // Simulate API call
      await Future<void>.delayed(const Duration(milliseconds: 600));
      
      final categories = _getMockCategories();
      state = CategoryLoaded(categories);
    } catch (e, stackTrace) {
      state = CategoryError(
        'Failed to load categories: ${e.toString()}',
        exception: e is Exception ? e : Exception(e.toString()),
      );
      print('Error loading categories: $e');
      print('Stack trace: $stackTrace');
    }
  }

  void reset() {
    state = const CategoryInitial();
  }

  List<Category> get currentCategories {
    return switch (state) {
      CategoryLoaded(:final categories) => categories,
      _ => [],
    };
  }

  bool get isLoading => state is CategoryLoading;
  bool get hasError => state is CategoryError;
  String? get errorMessage => switch (state) {
    CategoryError(:final message) => message,
    _ => null,
  };

  List<Category> _getMockCategories() {
    return [
      Category(
        id: '1',
        name: 'Vocabulary',
        description: 'Build your word bank with essential terms',
        icon: 'book',
        color: '#9C27B0',
        lessonCount: 45,
        featured: true,
      ),
      Category(
        id: '2',
        name: 'Grammar',
        description: 'Master sentence structures and rules',
        icon: 'library_books',
        color: '#1976D2',
        lessonCount: 38,
        featured: false,
      ),
      Category(
        id: '3',
        name: 'Pronunciation',
        description: 'Perfect your accent and speaking skills',
        icon: 'record_voice_over',
        color: '#2196F3',
        lessonCount: 27,
        featured: true,
      ),
      Category(
        id: '4',
        name: 'Phrases',
        description: 'Common expressions and idioms',
        icon: 'chat',
        color: '#FF9800',
        lessonCount: 52,
        featured: false,
      ),
      Category(
        id: '5',
        name: 'Conversation',
        description: 'Practice real-life dialogues',
        icon: 'group',
        color: '#E91E63',
        lessonCount: 31,
        featured: false,
      ),
      Category(
        id: '6',
        name: 'Listening',
        description: 'Improve comprehension skills',
        icon: 'headphones',
        color: '#00BCD4',
        lessonCount: 29,
        featured: true,
      ),
    ];
  }
}

class EnhancedLessonFilterNotifier extends StateNotifier<LessonFilterState> {
  EnhancedLessonFilterNotifier() : super(const LessonFilterState());

  void setSearchQuery(String query) {
    state = state.copyWith(
      filter: state.filter.copyWith(searchQuery: query),
    );
  }

  void setCategoryFilter(List<String> categories) {
    state = state.copyWith(
      filter: state.filter.copyWith(selectedCategories: categories),
    );
  }

  void setLevelFilter(List<String> levels) {
    state = state.copyWith(
      filter: state.filter.copyWith(selectedLevels: levels),
    );
  }

  void setPriceFilter(PriceFilter priceFilter) {
    state = state.copyWith(
      filter: state.filter.copyWith(priceFilter: priceFilter),
    );
  }

  void setSortOption(SortOption sortBy, {bool? ascending}) {
    state = state.copyWith(
      filter: state.filter.copyWith(
        sortBy: sortBy,
        sortAscending: ascending ?? state.filter.sortAscending,
      ),
    );
  }

  void clearFilters() {
    state = const LessonFilterState();
  }
}

// Enhanced Providers untuk consumption
final enhancedFilteredLessonsProvider = Provider<List<Lesson>>(
  (ref) {
    final lessonState = ref.watch(enhancedLessonNotifierProvider);
    final filterState = ref.watch(enhancedLessonFilterNotifierProvider);
    
    final lessons = switch (lessonState) {
      LessonLoaded(:final lessons) => lessons,
      _ => <Lesson>[],
    };
    
    // Apply filters
    var filtered = lessons.where((lesson) {
      // Category filter
      if (filterState.filter.selectedCategories.isNotEmpty) {
        if (!filterState.filter.selectedCategories.contains(lesson.category.name)) {
          return false;
        }
      }
      
      // Level filter
      if (filterState.filter.selectedLevels.isNotEmpty) {
        if (!filterState.filter.selectedLevels.contains(lesson.level.name)) {
          return false;
        }
      }
      
      // Price filter
      if (filterState.filter.priceFilter != PriceFilter.all) {
        if (filterState.filter.priceFilter == PriceFilter.free && lesson.isPremium == true) {
          return false;
        }
        if (filterState.filter.priceFilter == PriceFilter.premium && lesson.isPremium == false) {
          return false;
        }
      }
      
      // Search query
      if (filterState.searchQuery.isNotEmpty) {
        final query = filterState.searchQuery.toLowerCase();
        if (!lesson.title.toLowerCase().contains(query) &&
            !lesson.description.toLowerCase().contains(query) &&
            !lesson.tags.any((tag) => tag.toLowerCase().contains(query))) {
          return false;
        }
      }
      
      return true;
    }).toList();
    
    // Sort
    filtered.sort((a, b) {
      int comparison = 0;
      
      switch (filterState.filter.sortBy) {
        case SortOption.title:
          comparison = a.title.compareTo(b.title);
          break;
        case SortOption.level:
          comparison = a.level.name.compareTo(b.level.name);
          break;
        case SortOption.duration:
          comparison = a.duration.compareTo(b.duration);
          break;
        case SortOption.difficulty:
          comparison = a.difficulty.compareTo(b.difficulty);
          break;
        case SortOption.rating:
          comparison = b.rating.compareTo(a.rating);
          break;
        case SortOption.recent:
          comparison = (b.updatedAt ?? DateTime.now()).compareTo(a.updatedAt ?? DateTime.now());
          break;
      }
      
      return filterState.filter.sortAscending ? comparison : -comparison;
    });
    
    return filtered;
  },
);

final enhancedBookmarkedLessonsProvider = Provider<List<Lesson>>(
  (ref) {
    final lessonState = ref.watch(enhancedLessonNotifierProvider);
    final lessons = switch (lessonState) {
      LessonLoaded(:final lessons) => lessons,
      _ => <Lesson>[],
    };
    return lessons.where((lesson) => lesson.bookmarked).toList();
  },
);

// Loading states
final isLoadingLessonsProvider = Provider<bool>((ref) {
  final state = ref.watch(enhancedLessonNotifierProvider);
  return state is LessonLoading;
});

final isLoadingCategoriesProvider = Provider<bool>((ref) {
  return ref.watch(enhancedCategoryNotifierProvider).isLoading;
});

final canLoadMoreLessonsProvider = Provider<bool>((ref) {
  final state = ref.watch(enhancedLessonNotifierProvider);
  return switch (state) {
    LessonLoaded(:final hasMore) => hasMore,
    _ => false,
  };
});

final hasLessonsErrorProvider = Provider<bool>((ref) {
  final state = ref.watch(enhancedLessonNotifierProvider);
  return state is LessonError;
});

final hasCategoriesErrorProvider = Provider<bool>((ref) {
  return ref.watch(enhancedCategoryNotifierProvider).hasError;
});

final lessonsErrorMessageProvider = Provider<String?>((ref) {
  final state = ref.watch(enhancedLessonNotifierProvider);
  return switch (state) {
    LessonError(:final message) => message,
    _ => null,
  };
});

final categoriesErrorMessageProvider = Provider<String?>((ref) {
  return ref.watch(enhancedCategoryNotifierProvider).errorMessage;
});
