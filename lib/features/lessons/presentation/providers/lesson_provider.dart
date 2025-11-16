import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/lesson.dart';
import '../../domain/entities/category.dart';
import '../state/lesson_filter_state.dart';

// Mock data providers for now
final lessonNotifierProvider = StateNotifierProvider<LessonNotifier, List<Lesson>>(
  (ref) => LessonNotifier(),
);

final categoryNotifierProvider = StateNotifierProvider<CategoryNotifier, List<Category>>(
  (ref) => CategoryNotifier(),
);

final lessonFilterNotifierProvider = StateNotifierProvider<LessonFilterNotifier, LessonFilterState>(
  (ref) => LessonFilterNotifier(),
);

final filteredLessonsProvider = Provider<List<Lesson>>(
  (ref) {
    final lessons = ref.watch(lessonNotifierProvider);
    final filterState = ref.watch(lessonFilterNotifierProvider);
    
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
        if (filterState.filter.priceFilter == PriceFilter.free && lesson.isPremium) {
          return false;
        }
        if (filterState.filter.priceFilter == PriceFilter.premium && !lesson.isPremium) {
          return false;
        }
      }
      
      // Search query
      if (filterState.searchQuery.isNotEmpty) {
        final query = filterState.searchQuery.toLowerCase();
        if (!lesson.title.toLowerCase().contains(query) &&
            !lesson.description.toLowerCase().contains(query)) {
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

final bookmarkedLessonsProvider = Provider<List<Lesson>>(
  (ref) {
    final lessons = ref.watch(lessonNotifierProvider);
    return lessons.where((lesson) => lesson.bookmarked).toList();
  },
);

final isLoadingProvider = Provider<bool>((ref) => false);

final canLoadMoreProvider = Provider<bool>((ref) => false);

final hasErrorProvider = Provider<bool>((ref) => false);

final errorMessageProvider = Provider<String?>((ref) => null);

// Notifiers
class LessonNotifier extends StateNotifier<List<Lesson>> {
  LessonNotifier() : super([]);

  Future<void> loadLessons() async {
    // Need to implement actual lesson loading
    state = _getMockLessons();
  }

  Future<void> refreshLessons({
    LessonFilter? filter,
    String? searchQuery,
  }) async {
    // Need to implement refresh logic
    state = _getMockLessons();
  }

  Future<void> addLoadMoreLessons({
    LessonFilter? filter,
    String? searchQuery,
  }) async {
    // Need to implement load more logic
  }

  Future<void> toggleBookmark(String lessonId, bool bookmarked) async {
    state = state.map((lesson) {
      if (lesson.id == lessonId) {
        return lesson.copyWith(bookmarked: bookmarked);
      }
      return lesson;
    }).toList();
  }

  List<Lesson> _getMockLessons() {
    return [
      Lesson(
        id: '1',
        title: 'Basic English Greetings',
        description: 'Learn essential English greetings for everyday conversations',
        level: CEFRLevel.a1,
        category: LessonCategory.phrases,
        type: LessonType.phrase,
        duration: 45,
        difficulty: 0.2,
        isPremium: false,
        bookmarked: false,
        rating: 4.7,
        totalRatings: 156,
        tags: ['greetings', 'beginner'],
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        updatedAt: DateTime.now(),
      ),
      Lesson(
        id: '2',
        title: 'English Pronunciation Basics',
        description: 'Master English pronunciation with our comprehensive guide',
        level: CEFRLevel.a2,
        category: LessonCategory.pronunciation,
        type: LessonType.pronunciation,
        duration: 60,
        difficulty: 0.5,
        isPremium: true,
        bookmarked: true,
        rating: 4.9,
        totalRatings: 89,
        tags: ['pronunciation', 'speaking'],
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now(),
      ),
      Lesson(
        id: '3',
        title: 'Common English Phrases',
        description: 'Essential phrases for daily English communication',
        level: CEFRLevel.b1,
        category: LessonCategory.phrases,
        type: LessonType.phrase,
        duration: 30,
        difficulty: 0.4,
        isPremium: false,
        bookmarked: false,
        rating: 4.5,
        totalRatings: 234,
        tags: ['phrases', 'communication'],
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        updatedAt: DateTime.now(),
      ),
    ];
  }
}

class CategoryNotifier extends StateNotifier<List<Category>> {
  CategoryNotifier() : super([]);

  Future<void> loadCategories() async {
    // Need to implement actual category loading
    state = _getMockCategories();
  }

  List<Category> _getMockCategories() {
    return [
      Category(
        id: '1',
        name: 'Vocabulary',
        description: 'Build your word bank',
        icon: 'book',
        color: '#9C27B0',
        lessonCount: 45,
        featured: true,
      ),
      Category(
        id: '2',
        name: 'Grammar',
        description: 'Master sentence structures',
        icon: 'library_books',
        color: '#1976D2',
        lessonCount: 38,
        featured: false,
      ),
      Category(
        id: '3',
        name: 'Pronunciation',
        description: 'Perfect your accent',
        icon: 'record_voice_over',
        color: '#2196F3',
        lessonCount: 27,
        featured: true,
      ),
      Category(
        id: '4',
        name: 'Phrases',
        description: 'Common expressions',
        icon: 'chat',
        color: '#FF9800',
        lessonCount: 52,
        featured: false,
      ),
      Category(
        id: '5',
        name: 'Conversation',
        description: 'Practice speaking',
        icon: 'group',
        color: '#E91E63',
        lessonCount: 31,
        featured: false,
      ),
      Category(
        id: '6',
        name: 'Listening',
        description: 'Improve comprehension',
        icon: 'headphones',
        color: '#00BCD4',
        lessonCount: 29,
        featured: true,
      ),
    ];
  }
}

class LessonFilterNotifier extends StateNotifier<LessonFilterState> {
  LessonFilterNotifier() : super(const LessonFilterState());

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
