import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:katadia_app/features/lessons/presentation/providers/lesson_provider.dart';
import 'package:katadia_app/features/lessons/presentation/state/lesson_filter_state.dart';
import 'package:katadia_app/shared/theme/app_colors.dart';

class LessonFilterSheet extends ConsumerStatefulWidget {
  const LessonFilterSheet({Key? key}) : super(key: key);

  @override
  ConsumerState<LessonFilterSheet> createState() => _LessonFilterSheetState();
}

class _LessonFilterSheetState extends ConsumerState<LessonFilterSheet> {
  @override
  Widget build(BuildContext context) {
    final filterState = ref.watch(lessonFilterNotifierProvider);
    
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.r),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            
            // Header
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Text(
                    'Filter & Sort',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  if (filterState.filter.hasActiveFilters)
                    TextButton(
                      onPressed: () {
                        ref.read(lessonFilterNotifierProvider.notifier).clearFilters();
                        Navigator.pop(context);
                      },
                      child: Text('Clear All'),
                    ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Done'),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  // Sort section
                  _buildSortSection(filterState),
                  
                  SizedBox(height: 24.h),
                  
                  // Price filter section
                  _buildPriceSection(filterState),
                  
                  SizedBox(height: 24.h),
                  
                  // CEFR Levels section  
                  _buildLevelsSection(filterState),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortSection(LessonFilterState filterState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sort By',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        ...SortOption.values.map((option) => RadioListTile<SortOption>(
          title: Text(option.displayName),
          value: option,
          groupValue: filterState.filter.sortBy,
          onChanged: (value) {
            if (value != null) {
              ref.read(lessonFilterNotifierProvider.notifier).setSortOption(
                    value,
                    ascending: filterState.filter.sortAscending,
                  );
            }
          },
          activeColor: AppColors.primary,
        )),
        
        SizedBox(height: 12.h),
        Row(
          children: [
            Icon(Icons.sort, size: 16.w),
            SizedBox(width: 8.w),
            Text('Sort Order', style: TextStyle(fontSize: 14.sp)),
            const Spacer(),
            ToggleButtons(
              isSelected: [filterState.filter.sortAscending, !filterState.filter.sortAscending],
              onPressed: (index) {
                ref.read(lessonFilterNotifierProvider.notifier).setSortOption(
                      filterState.filter.sortBy,
                      ascending: index == 0,
                    );
              },
              children: const [
                Text('A-Z'),
                Text('Z-A'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceSection(LessonFilterState filterState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildPriceChip(
                'All',
                filterState.filter.priceFilter == PriceFilter.all,
                () => ref.read(lessonFilterNotifierProvider.notifier)
                    .setPriceFilter(PriceFilter.all),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _buildPriceChip(
                'Free',
                filterState.filter.priceFilter == PriceFilter.free,
                () => ref.read(lessonFilterNotifierProvider.notifier)
                    .setPriceFilter(PriceFilter.free),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _buildPriceChip(
                'Premium',
                filterState.filter.priceFilter == PriceFilter.premium,
                () => ref.read(lessonFilterNotifierProvider.notifier)
                    .setPriceFilter(PriceFilter.premium),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey[100],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildLevelsSection(LessonFilterState filterState) {
    final cefrLevels = [
      {'id': 'a1', 'name': 'A1 - Beginner', 'color': AppColors.cefrA1},
      {'id': 'a2', 'name': 'A2 - Elementary', 'color': AppColors.cefrA2},
      {'id': 'b1', 'name': 'B1 - Intermediate', 'color': AppColors.cefrB1},
      {'id': 'b2', 'name': 'B2 - Upper Intermediate', 'color': AppColors.cefrB2},
      {'id': 'c1', 'name': 'C1 - Advanced', 'color': AppColors.cefrC1},
      {'id': 'c2', 'name': 'C2 - Proficient', 'color': AppColors.cefrC2},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CEFR Levels',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: cefrLevels.map((level) {
            final isSelected = filterState.filter.selectedLevels.contains(level['id'] as String);
            return FilterChip(
              label: Text(level['name'] as String),
              selected: isSelected,
              onSelected: (selected) {
                final currentLevels = Set<String>.from(filterState.filter.selectedLevels);
                if (selected) {
                  currentLevels.add(level['id'] as String);
                } else {
                  currentLevels.remove(level['id'] as String);
                }
                ref.read(lessonFilterNotifierProvider.notifier)
                    .setLevelFilter(currentLevels.toList());
              },
              backgroundColor: Colors.grey[100],
              selectedColor: level['color'] as Color,
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
