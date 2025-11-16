import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:katadia_app/features/lessons/domain/entities/lesson.dart';
import 'package:katadia_app/shared/theme/app_colors.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  final bool showBookmark;
  final bool showProgress;
  final double? width;
  final double? height;

  const LessonCard({
    Key? key,
    required this.lesson,
    this.onTap,
    this.onBookmarkTap,
    this.showBookmark = true,
    this.showProgress = true,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 140.h,
      margin: EdgeInsets.only(bottom: 12.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              _buildThumbnail(),
              // Content
              Expanded(
                child: _buildContent(),
              ),
              // Bookmark button
              if (showBookmark) _buildBookmarkButton(),
              if (showBookmark) SizedBox(width: 12.w),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return Container(
      width: 120.w,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          bottomLeft: Radius.circular(16.r),
        ),
        color: Colors.grey.shade100,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          bottomLeft: Radius.circular(16.r),
        ),
        child: lesson.imageUrl != null
            ? CachedNetworkImage(
                imageUrl: lesson.imageUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => _buildPlaceholder(),
                errorWidget: (context, url, error) => _buildPlaceholder(),
              )
            : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: _getCategoryColor().withOpacity(0.1),
      child: Center(
        child: Icon(
          _getCategoryIcon(),
          size: 32.w,
          color: _getCategoryColor(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and CEFR Level
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        lesson.title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    _buildLevelBadge(),
                  ],
                ),
                SizedBox(height: 4.h),
                
                // Category and Type
                Row(
                  children: [
                    _buildCategoryChip(),
                    SizedBox(width: 8.w),
                    _buildTypeChip(),
                  ],
                ),
                SizedBox(height: 8.h),
                
                // Description
                Expanded(
                  child: Text(
                    lesson.description,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Duration
                  _buildInfoItem(Icons.access_time, lesson.duration),
                  SizedBox(width: 16.w),
                  
                  // Difficulty
                  _buildDifficultyIndicator(),
                  SizedBox(width: 16.w),
                  
                  // Rating if available
                  if (lesson.totalRatings > 0)
                    _buildInfoItem(Icons.star, lesson.rating),
                ],
              ),
              
              // Progress bar
              if (showProgress && (lesson.progress > 0 || lesson.isCompleted))
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: _buildProgressBar(),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLevelBadge() {
    Color badgeColor;
    switch (lesson.level) {
      case CEFRLevel.a1:
        badgeColor = Colors.green.shade100;
        break;
      case CEFRLevel.a2:
        badgeColor = Colors.lightGreen.shade100;
        break;
      case CEFRLevel.b1:
        badgeColor = Colors.yellow.shade100;
        break;
      case CEFRLevel.b2:
        badgeColor = Colors.orange.shade100;
        break;
      case CEFRLevel.c1:
        badgeColor = Colors.red.shade100;
        break;
      case CEFRLevel.c2:
        badgeColor = Colors.red.shade300;
        break;
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        lesson.level.name.toUpperCase(),
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: badgeColor.computeLuminance() > 0.5 
              ? Colors.black87 
              : Colors.white,
        ),
      ),
    );
  }

  Widget _buildCategoryChip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: _getCategoryColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        lesson.category.name,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: _getCategoryColor(),
        ),
      ),
    );
  }

  Widget _buildTypeChip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        lesson.type.name,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, dynamic value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.w, color: Colors.grey[600]),
        SizedBox(width: 4.w),
        if (value is String)
          Text(
            value,
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          )
        else if (value is num)
          Text(
            value.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          )
        else if (value is int)
          Text(
            '$value min',
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  Widget _buildDifficultyIndicator() {
    final difficulty = lesson.difficulty;
    int filledDots = (difficulty * 3).round();
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Icon(
          index < filledDots ? Icons.circle : Icons.circle_outlined,
          size: 10.w,
          color: index < filledDots 
              ? _getDifficultyColor(difficulty)
              : Colors.grey[300],
        );
      }),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: lesson.progress,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  lesson.isCompleted ? Colors.green : AppColors.primary,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              '${(lesson.progress * 100).round()}%',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: lesson.isCompleted ? Colors.green : AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBookmarkButton() {
    return Padding(
      padding: EdgeInsets.only(top: 16.w),
      child: InkWell(
        onTap: () => onBookmarkTap?.call(),
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: lesson.bookmarked 
                ? AppColors.primary.withOpacity(0.1)
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            lesson.bookmarked ? Icons.bookmark : Icons.bookmark_border,
            size: 18.w,
            color: lesson.bookmarked ? AppColors.primary : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor() {
    switch (lesson.category) {
      case LessonCategory.vocabulary:
        return Colors.purple;
      case LessonCategory.grammar:
        return Colors.blue;
      case LessonCategory.pronunciation:
        return Colors.green;
      case LessonCategory.phrases:
        return Colors.orange;
      case LessonCategory.conversation:
        return Colors.red;
      case LessonCategory.listening:
        return Colors.teal;
    }
  }

  IconData _getCategoryIcon() {
    switch (lesson.category) {
      case LessonCategory.vocabulary:
        return Icons.book;
      case LessonCategory.grammar:
        return Icons.library_books;
      case LessonCategory.pronunciation:
        return Icons.record_voice_over;
      case LessonCategory.phrases:
        return Icons.chat;
      case LessonCategory.conversation:
        return Icons.group;
      case LessonCategory.listening:
        return Icons.headphones;
    }
  }

  Color _getDifficultyColor(double difficulty) {
    if (difficulty <= 0.33) return Colors.green;
    if (difficulty <= 0.67) return Colors.orange;
    return Colors.red;
  }
}

// Featured lesson card for home screen
class FeaturedLessonCard extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback? onTap;
  final String categoryLabel;

  const FeaturedLessonCard({
    Key? key,
    required this.lesson,
    this.onTap,
    this.categoryLabel = 'Featured',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180.h,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Row(
          children: [
            // Image section
            Container(
              width: 140.w,
              height: double.infinity,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: lesson.imageUrl != null
                        ? CachedNetworkImage(
                            imageUrl: lesson.imageUrl!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[200],
                              child: Center(
                                child: Icon(
                                  _getCategoryIcon(),
                                  size: 32.w,
                                  color: _getCategoryColor(),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[200],
                              child: Center(
                                child: Icon(
                                  _getCategoryIcon(),
                                  size: 32.w,
                                  color: _getCategoryColor(),
                                ),
                              ),
                            ),
                          )
                        : Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: Icon(
                              _getCategoryIcon(),
                              size: 32.w,
                              color: _getCategoryColor(),
                            ),
                          ),
                        ),
                  ),
                  // Category label overlay
                  Positioned(
                    top: 12.h,
                    left: 12.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        categoryLabel,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Premium badge
                  if (lesson.isPremium)
                    Positioned(
                      top: 12.h,
                      right: 12.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'PRO',
                          style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // Content section
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Level badge
                    _buildLevelBadge(),
                    SizedBox(height: 8.h),
                    
                    // Title
                    Expanded(
                      child: Text(
                        lesson.title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    
                    // Bottom info
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        _buildInfoItem(Icons.access_time, lesson.duration),
                        SizedBox(width: 12.w),
                        _buildInfoItem(Icons.star, lesson.rating),
                        Spacer(),
                        if (lesson.isCompleted)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 12.w,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Done',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelBadge() {
    Color badgeColor;
    switch (lesson.level) {
      case CEFRLevel.a1:
        badgeColor = Colors.green;
        break;
      case CEFRLevel.a2:
        badgeColor = Colors.lightGreen;
        break;
      case CEFRLevel.b1:
        badgeColor = Colors.yellow;
        break;
      case CEFRLevel.b2:
        badgeColor = Colors.orange;
        break;
      case CEFRLevel.c1:
        badgeColor = Colors.red;
        break;
      case CEFRLevel.c2:
        badgeColor = Colors.red.shade300;
        break;
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        lesson.level.name.toUpperCase(),
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: badgeColor,
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, dynamic value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.w, color: Colors.grey[600]),
        SizedBox(width: 4.w),
        if (value is num)
          Text(
            value is int ? '$value min' : value.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  Color _getCategoryColor() {
    switch (lesson.category) {
      case LessonCategory.vocabulary:
        return Colors.purple;
      case LessonCategory.grammar:
        return Colors.blue;
      case LessonCategory.pronunciation:
        return Colors.green;
      case LessonCategory.phrases:
        return Colors.orange;
      case LessonCategory.conversation:
        return Colors.red;
      case LessonCategory.listening:
        return Colors.teal;
    }
  }

  IconData _getCategoryIcon() {
    switch (lesson.category) {
      case LessonCategory.vocabulary:
        return Icons.book;
      case LessonCategory.grammar:
        return Icons.library_books;
      case LessonCategory.pronunciation:
        return Icons.record_voice_over;
      case LessonCategory.phrases:
        return Icons.chat;
      case LessonCategory.conversation:
        return Icons.group;
      case LessonCategory.listening:
        return Icons.headphones;
    }
  }
}

// Quick fix for PeopleAlt icon if not available

