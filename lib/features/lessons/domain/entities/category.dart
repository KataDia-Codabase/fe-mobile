import 'package:equatable/equatable.dart';
import '../../presentation/state/lesson_filter_state.dart';

class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    required this.description,
    this.icon,
    this.iconUrl,
    this.imageUrl,
    this.color,
    this.lessonCount = 0,
    this.totalDuration = 0,
    this.levels,
    this.difficulty,
    this.isActive = true,
    this.sortOrder = 0,
    this.featured = false,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String name;
  final String description;
  final String? icon;
  final String? iconUrl;
  final String? imageUrl;
  final String? color;
  final int lessonCount;
  final int totalDuration; // in minutes
  final List<String>? levels; // CEFR levels available
  final double? difficulty; // average difficulty
  final bool isActive;
  final int sortOrder;
  final bool featured;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Category copyWith({
    String? id,
    String? name,
    String? description,
    String? icon,
    String? iconUrl,
    String? imageUrl,
    String? color,
    int? lessonCount,
    int? totalDuration,
    List<String>? levels,
    double? difficulty,
    bool? isActive,
    int? sortOrder,
    bool? featured,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      iconUrl: iconUrl ?? this.iconUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      color: color ?? this.color,
      lessonCount: lessonCount ?? this.lessonCount,
      totalDuration: totalDuration ?? this.totalDuration,
      levels: levels ?? this.levels,
      difficulty: difficulty ?? this.difficulty,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      featured: featured ?? this.featured,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        icon,
        iconUrl,
        imageUrl,
        color,
        lessonCount,
        totalDuration,
        levels,
        difficulty,
        isActive,
        sortOrder,
        featured,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'Category(id: $id, name: $name, lessons: $lessonCount)';
  }
}

class CategoryFilter extends Equatable {
  const CategoryFilter({
    this.selectedCategories = const [],
    this.selectedLevels = const [],
    this.selectedTypes = const [],
    this.selectedDifficulties = const [],
    this.priceFilter = PriceFilter.all,
    this.searchQuery,
    this.sortBy = SortOption.recent,
    this.sortAscending = false,
  });

  final List<String> selectedCategories;
  final List<String> selectedLevels;
  final List<String> selectedTypes;
  final List<double> selectedDifficulties;
  final PriceFilter priceFilter;
  final String? searchQuery;
  final SortOption sortBy;
  final bool sortAscending;

  bool get hasActiveFilters =>
      selectedCategories.isNotEmpty ||
      selectedLevels.isNotEmpty ||
      selectedTypes.isNotEmpty ||
      selectedDifficulties.isNotEmpty ||
      priceFilter != PriceFilter.all ||
      (searchQuery?.isNotEmpty ?? false);

  CategoryFilter copyWith({
    List<String>? selectedCategories,
    List<String>? selectedLevels,
    List<String>? selectedTypes,
    List<double>? selectedDifficulties,
    PriceFilter? priceFilter,
    String? searchQuery,
    SortOption? sortBy,
    bool? sortAscending,
  }) {
    return CategoryFilter(
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedLevels: selectedLevels ?? this.selectedLevels,
      selectedTypes: selectedTypes ?? this.selectedTypes,
      selectedDifficulties: selectedDifficulties ?? this.selectedDifficulties,
      priceFilter: priceFilter ?? this.priceFilter,
      searchQuery: searchQuery,
      sortBy: sortBy ?? this.sortBy,
      sortAscending: sortAscending ?? this.sortAscending,
    );
  }

  CategoryFilter clearFilters() {
    return const CategoryFilter();
  }

  @override
  List<Object?> get props => [
        selectedCategories,
        selectedLevels,
        selectedTypes,
        selectedDifficulties,
        priceFilter,
        searchQuery,
        sortBy,
        sortAscending,
      ];

  @override
  String toString() {
    return 'CategoryFilter(categories: ${selectedCategories.length}, levels: ${selectedLevels.length})';
  }
}



class FeaturedSection extends Equatable {
  const FeaturedSection({
    required this.id,
    required this.title,
    required this.description,
    required this.sectionType,
    this.lessonIds = const [],
    this.imageUrl,
    this.isActive = true,
    this.displayLimit = 10,
    this.featureOrder = 0,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String title;
  final String description;
  final FeaturedSectionType sectionType;
  final List<String> lessonIds;
  final String? imageUrl;
  final bool isActive;
  final int displayLimit;
  final int featureOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FeaturedSection copyWith({
    String? id,
    String? title,
    String? description,
    FeaturedSectionType? sectionType,
    List<String>? lessonIds,
    String? imageUrl,
    bool? isActive,
    int? displayLimit,
    int? featureOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FeaturedSection(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      sectionType: sectionType ?? this.sectionType,
      lessonIds: lessonIds ?? this.lessonIds,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      displayLimit: displayLimit ?? this.displayLimit,
      featureOrder: featureOrder ?? this.featureOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        sectionType,
        lessonIds,
        imageUrl,
        isActive,
        displayLimit,
        featureOrder,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'FeaturedSection(id: $id, title: $title, type: $sectionType)';
  }
}

enum FeaturedSectionType {
  recommended('Recommended for You'),
  trending('Trending Now'),
  newReleases('New Releases'),
  continueLearning('Continue Learning'),
  beginners('Perfect for Beginners'),
  advanced('Advanced Learners'),
  quickPractice('Quick Practice'),
  weekendChallenge('Weekend Challenge');

  const FeaturedSectionType(this.displayName);
  
  final String displayName;
}
