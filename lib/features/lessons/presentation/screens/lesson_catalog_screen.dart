import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:katadia_app/features/lessons/domain/entities/category.dart';
import 'package:katadia_app/features/lessons/domain/entities/lesson.dart';
import 'package:katadia_app/features/lessons/presentation/providers/lesson_provider.dart';
import 'package:katadia_app/features/lessons/presentation/state/lesson_filter_state.dart';
import 'package:katadia_app/features/lessons/presentation/widgets/lesson_card.dart';
import 'package:katadia_app/features/lessons/presentation/widgets/lesson_filter_sheet.dart';
import 'package:katadia_app/features/lessons/presentation/widgets/search_bar.dart' as custom;
import 'package:katadia_app/shared/theme/app_colors.dart';
import 'package:katadia_app/shared/widgets/loading_widget.dart';

class LessonCatalogScreen extends ConsumerStatefulWidget {
  const LessonCatalogScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LessonCatalogScreen> createState() => _LessonCatalogScreenState();
}

class _LessonCatalogScreenState extends ConsumerState<LessonCatalogScreen>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final TextEditingController _searchController;
  late final TabController _tabController;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchController = TextEditingController();
    _tabController = TabController(length: 3, vsync: this);
    
    // Add scroll listener for infinite loading
    _scrollController.addListener(_onScroll);
    
    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(lessonNotifierProvider.notifier).loadLessons();
      ref.read(categoryNotifierProvider.notifier).loadCategories();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200.h) {
      final canLoadMore = ref.read(canLoadMoreProvider);
      if (canLoadMore) {
        final filterState = ref.read(lessonFilterNotifierProvider);
        ref.read(lessonNotifierProvider.notifier).addLoadMoreLessons(
          filter: filterState.filter,
          searchQuery: filterState.searchQuery,
        );
      }
    }
  }

  void _onSearchChanged(String query) {
    ref.read(lessonFilterNotifierProvider.notifier).setSearchQuery(query);
    
    // Debounce search
    Future.delayed(const Duration(milliseconds: 500), () {
      final currentQuery = ref.read(lessonFilterNotifierProvider).searchQuery;
      if (currentQuery == query) {
        _refreshLessons();
      }
    });
  }

  void _refreshLessons() {
    final filterState = ref.read(lessonFilterNotifierProvider);
    ref.read(lessonNotifierProvider.notifier).refreshLessons(
      filter: filterState.filter,
      searchQuery: filterState.searchQuery,
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryNotifierProvider);
    final filterState = ref.watch(lessonFilterNotifierProvider);
    final filteredLessons = ref.watch(filteredLessonsProvider);

    return WillPopScope(
      onWillPop: () async {
        if (context.canPop()) {
          context.pop();
        } else {
          Navigator.of(context).pop();
        }
        return false;
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: RefreshIndicator(
          onRefresh: () async => _refreshLessons(),
          backgroundColor: Colors.white,
          child: Column(
            children: [
              // Search Bar
              _buildSearchBar(filterState),
              
              // Filter Chips
              if (filterState.filter.hasActiveFilters)
                _buildActiveFilters(filterState),
              
              // Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildLessonsList(filteredLessons),
                    _buildCategoriesGrid(categoryState),
                    _buildBookmarkedList(),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showFilterBottomSheet,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.filter_alt, color: Colors.white),
          mini: true,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Explore Lessons',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (_isSearching)
            Text(
              'Search results',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ),
      bottom: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: 'All Lessons'),
          Tab(text: 'Categories'),
          Tab(text: 'Bookmarked'),
        ],
        labelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        indicatorColor: AppColors.primary,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
      ),
      actions: [
        IconButton(
          icon: Icon(_isSearching ? Icons.close : Icons.search),
          onPressed: () {
            if (_isSearching) {
              _onSearchChanged('');
              _searchController.clear();
              setState(() => _isSearching = false);
            } else {
              setState(() => _isSearching = true);
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.tune),
          onPressed: _showFilterBottomSheet,
        ),
      ],
    );
  }

  Widget _buildSearchBar(LessonFilterState filterState) {
    if (!_isSearching) {
      return Padding(
        padding: EdgeInsets.all(16.w),
        child: custom.SearchBar(
          controller: _searchController,
          onChanged: _onSearchChanged,
          onTap: () {
            setState(() => _isSearching = true);
          },
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search lessons...',
          prefixIcon: Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _onSearchChanged('');
                  },
                )
              : null,
        ),
        onChanged: _onSearchChanged,
      ),
    );
  }

  Widget _buildActiveFilters(LessonFilterState filterState) {
    final chips = <Widget>[];
    
    if (filterState.filter.selectedCategories.isNotEmpty) {
      chips.add(
        ActionChip(
          label: Text('Categories (${filterState.filter.selectedCategories.length})'),
          onPressed: () {
            ref.read(lessonFilterNotifierProvider.notifier).setCategoryFilter([]);
          },
        ),
      );
    }
    
    if (filterState.filter.selectedLevels.isNotEmpty) {
      chips.add(
        ActionChip(
          label: Text('Levels (${filterState.filter.selectedLevels.length})'),
          onPressed: () {
            ref.read(lessonFilterNotifierProvider.notifier).setLevelFilter([]);
          },
        ),
      );
    }
    
    if (filterState.filter.priceFilter != PriceFilter.all) {
      chips.add(
        ActionChip(
          label: Text(filterState.filter.priceFilter.displayName),
          onPressed: () {
            ref.read(lessonFilterNotifierProvider.notifier)
                .setPriceFilter(PriceFilter.all);
          },
        ),
      );
    }

    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...chips.map((chip) => Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: chip,
            )),
            SizedBox(width: 8.w),
            InkWell(
              onTap: () {
                ref.read(lessonFilterNotifierProvider.notifier).clearFilters();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Clear All',
                  style: TextStyle(color: AppColors.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonsList(List<Lesson> lessons) {
    final isLoading = ref.watch(isLoadingProvider);
    final hasError = ref.watch(hasErrorProvider);
    final errorMessage = ref.watch(errorMessageProvider);

    if (hasError && lessons.isEmpty) {
      return _buildErrorState(errorMessage);
    }

    if (lessons.isEmpty && !isLoading) {
      return _buildEmptyState();
    }

    return Column(
      children: [
        // Sort dropdown
        _buildSortDropdown(),
        
        // Lessons list
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: lessons.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == lessons.length && isLoading) {
                return _buildLoadingIndicator();
              }

              if (index >= lessons.length) {
                return const SizedBox.shrink();
              }

              final lesson = lessons[index];
              return LessonCard(
                lesson: lesson,
                onTap: () => _navigateToLessonDetail(lesson),
                onBookmarkTap: () async {
                  await ref.read(lessonNotifierProvider.notifier)
                      .toggleBookmark(lesson.id, !lesson.bookmarked);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesGrid(List<Category> categories) {
    if (categories.isEmpty) {
      return _buildEmptyState(message: 'No categories available');
    }

    return GridView.builder(
      padding: EdgeInsets.all(16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _buildCategoryCard(category);
      },
    );
  }

  Widget _buildBookmarkedList() {
    final bookmarkedLessons = ref.watch(bookmarkedLessonsProvider);

    if (bookmarkedLessons.isEmpty) {
      return _buildEmptyState(
        message: 'No bookmarked lessons yet',
        action: 'Explore lessons',
        onAction: _refreshLessons,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: bookmarkedLessons.length,
      itemBuilder: (context, index) {
        final lesson = bookmarkedLessons[index];
        return LessonCard(
          lesson: lesson,
          onTap: () => _navigateToLessonDetail(lesson),
          onBookmarkTap: () async {
            await ref.read(lessonNotifierProvider.notifier)
                .toggleBookmark(lesson.id, !lesson.bookmarked);
          },
        );
      },
    );
  }

  Widget _buildCategoryCard(Category category) {
    return InkWell(
      onTap: () {
        // Filter by this category
        ref.read(lessonFilterNotifierProvider.notifier)
            .setCategoryFilter([category.name]);
        _tabController.animateTo(0); // Switch to lessons tab
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category icon and name
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: _getCategoryColor(category.name).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Icon(
                      _getCategoryIcon(category.name),
                      size: 32.w,
                      color: _getCategoryColor(category.name),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              
              // Category name
              Text(
                category.name,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              
              // Description
              Text(
                category.description,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppColors.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.h),
              
              // Stats
              Row(
                children: [
                  Icon(
                    Icons.book,
                    size: 12.w,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${category.lessonCount} lessons',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Spacer(),
                  if (category.featured)
                    Icon(
                      Icons.grade,
                      size: 12.w,
                      color: AppColors.warning,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSortDropdown() {
    final filterState = ref.watch(lessonFilterNotifierProvider);
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Text('Sort by:', style: TextStyle(fontSize: 12.sp)),
          SizedBox(width: 8.w),
          Expanded(
            child: DropdownButtonFormField<SortOption>(
              initialValue: filterState.filter.sortBy,
              onChanged: (SortOption? value) {
                if (value != null) {
                  ref.read(lessonFilterNotifierProvider.notifier)
                      .setSortOption(value);
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppColors.borderColor),
                ),
                isDense: true,
              ),
              items: SortOption.values.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(
                    option.displayName,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(width: 8.w),
          IconButton(
            icon: Icon(
              filterState.filter.sortAscending
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
            ),
            onPressed: () {
              ref.read(lessonFilterNotifierProvider.notifier).setSortOption(
                    filterState.filter.sortBy,
                    ascending: !filterState.filter.sortAscending,
                  );
            },
            tooltip: 'Sort order',
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Center(
        child: LoadingSpinner(),
      ),
    );
  }

  Widget _buildErrorState(String? error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.w,
              color: AppColors.error,
            ),
            SizedBox(height: 16.h),
            Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              error ?? 'Failed to load lessons',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: _refreshLessons,
              child: Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState({
    String? message,
    String? action,
    VoidCallback? onAction,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 48.w,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 16.h),
            Text(
              message ?? 'No lessons found',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Try adjusting your filters or search query',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
            ),
            if (action != null && onAction != null) ...[
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: onAction,
                child: Text(action),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (context) => LessonFilterSheet(),
    );
  }

  void _navigateToLessonDetail(Lesson lesson) {
    // Need to navigate to lesson detail screen
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => LessonDetailScreen(lessonId: lesson.id),
    //   ),
    // );
  }

  Color _getCategoryColor(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'vocabulary':
        return AppColors.vocabularyColor;
      case 'grammar':
        return AppColors.grammarColor;
      case 'pronunciation':
        return AppColors.pronunciationColor;
      case 'phrases':
        return AppColors.phrasesColor;
      case 'conversation':
        return AppColors.conversationColor;
      case 'listening':
        return AppColors.listeningColor;
      default:
        return AppColors.primary;
    }
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'vocabulary':
        return Icons.book;
      case 'grammar':
        return Icons.library_books;
      case 'pronunciation':
        return Icons.record_voice_over;
      case 'phrases':
        return Icons.chat;
      case 'conversation':
        return Icons.group;
      case 'listening':
        return Icons.headphones;
      default:
        return Icons.school;
    }
  }
}
