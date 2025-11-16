import 'package:equatable/equatable.dart';

enum SortOption {
  title('Title'),
  difficulty('Difficulty'),
  duration('Duration'),
  level('Level'),
  rating('Rating'),
  recent('Recently Updated');

  const SortOption(this.displayName);
  
  final String displayName;
}

enum PriceFilter {
  all('All'),
  free('Free'),
  premium('Premium');

  const PriceFilter(this.displayName);
  
  final String displayName;
}

class LessonFilter extends Equatable {
  final String searchQuery;
  final List<String> selectedCategories;
  final List<String> selectedLevels;
  final PriceFilter priceFilter;
  final SortOption sortBy;
  final bool sortAscending;

  const LessonFilter({
    this.searchQuery = '',
    this.selectedCategories = const [],
    this.selectedLevels = const [],
    this.priceFilter = PriceFilter.all,
    this.sortBy = SortOption.recent,
    this.sortAscending = false,
  });

  bool get hasActiveFilters =>
      searchQuery.isNotEmpty ||
      selectedCategories.isNotEmpty ||
      selectedLevels.isNotEmpty ||
      priceFilter != PriceFilter.all;

  LessonFilter copyWith({
    String? searchQuery,
    List<String>? selectedCategories,
    List<String>? selectedLevels,
    PriceFilter? priceFilter,
    SortOption? sortBy,
    bool? sortAscending,
  }) {
    return LessonFilter(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedLevels: selectedLevels ?? this.selectedLevels,
      priceFilter: priceFilter ?? this.priceFilter,
      sortBy: sortBy ?? this.sortBy,
      sortAscending: sortAscending ?? this.sortAscending,
    );
  }

  @override
  List<Object?> get props => [
        searchQuery,
        selectedCategories,
        selectedLevels,
        priceFilter,
        sortBy,
        sortAscending,
      ];
}

class LessonFilterState extends Equatable {
  final LessonFilter filter;

  const LessonFilterState({LessonFilter? filter}) : filter = filter ?? const LessonFilter();

  String get searchQuery => filter.searchQuery;

  LessonFilterState copyWith({LessonFilter? filter}) {
    return LessonFilterState(filter: filter ?? this.filter);
  }

  @override
  List<Object?> get props => [filter];
}
