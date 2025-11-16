import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:katadia_app/features/lessons/domain/entities/lesson.dart';
import 'package:katadia_app/features/lessons/domain/entities/lesson_content.dart';
import 'package:katadia_app/features/lessons/domain/entities/lesson_progress.dart';
import 'package:katadia_app/shared/theme/app_colors.dart';
import 'package:katadia_app/shared/widgets/loading_widget.dart';

class LessonDetailScreen extends ConsumerStatefulWidget {
  final String lessonId;

  const LessonDetailScreen({
    Key? key,
    required this.lessonId,
  }) : super(key: key);

  @override
  ConsumerState<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends ConsumerState<LessonDetailScreen>
    with SingleTickerProviderStateMixin {
  Lesson? _lesson;
  List<LessonContent> _content = [];
  LessonProgress? _progress;
  bool _isLoading = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadLessonData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadLessonData() async {
    // Need to load lesson data from repository
    // For now, use mock data
    await Future<void>.delayed(const Duration(milliseconds: 800));
    
    setState(() {
      _lesson = _getMockLesson();
      _content = _getMockContent();
      _progress = _getMockProgress();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const FullScreenLoader(message: 'Loading lesson...');
    }

    if (_lesson == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Lesson Not Found')),
        body: const Center(
          child: Text('Lesson not found'),
        ),
      );
    }

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
        body: Column(
          children: [
            // App Bar with Hero Image using regular AppBar
            SizedBox(
              height: 250.h,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background image
                  _lesson!.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: _lesson!.imageUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[200],
                            child: Center(
                              child: Icon(
                                _getCategoryIcon(_lesson!.category),
                                size: 48.w,
                                color: _getCategoryColor(_lesson!.category),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[200],
                            child: Center(
                              child: Icon(
                                Icons.broken_image,
                                size: 48.w,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        )
                      : Container(
                          color: _getCategoryColor(_lesson!.category).withOpacity(0.1),
                          child: Center(
                            child: Icon(
                              _getCategoryIcon(_lesson!.category),
                              size: 48.w,
                              color: _getCategoryColor(_lesson!.category),
                            ),
                          ),
                        ),
                  
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  
                  // Back button and title
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: const Icon(Icons.arrow_back, color: Colors.black87),
                            ),
                            onPressed: () {
                              if (context.canPop()) {
                                context.pop();
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                          Expanded(
                            child: Text(
                              _lesson!.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: _toggleBookmark,
                                icon: Icon(
                                  _lesson!.bookmarked ? Icons.bookmark : Icons.bookmark_border,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: _shareLesson,
                                icon: Icon(
                                  Icons.share,
                                  color: Colors.white,
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
            
            // Tab Bar
            _buildTabBar(),
            
            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOverviewTab(),
                  _buildContentTab(),
                  _buildProgressTab(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _startLesson,
          backgroundColor: AppColors.primary,
          icon: Icon(Icons.play_arrow),
          label: Text('Start Lesson'),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'Content'),
          Tab(text: 'Progress'),
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
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course Info
          _buildCourseInfo(),
          
          SizedBox(height: 24.h),
          
          // Description
          _buildDescription(),
          
          SizedBox(height: 24.h),
          
          // Learning Objectives
          _buildLearningObjectives(),
          
          SizedBox(height: 24.h),
          
          // Prerequisites
          _buildPrerequisites(),
          
          SizedBox(height: 24.h),
          
          // Related Lessons
          _buildRelatedLessons(),
        ],
      ),
    );
  }

  Widget _buildContentTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: _content.length,
      itemBuilder: (context, index) {
        final item = _content[index];
        return _buildContentCard(item);
      },
    );
  }

  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Overview
          _buildProgressOverview(),
          
          SizedBox(height: 24.h),
          
          // Progress Chart
          _buildProgressChart(),
          
          SizedBox(height: 24.h),
          
          // Statistics
          _buildStatistics(),
        ],
      ),
    );
  }

  Widget _buildCourseInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badges row
        Row(
          children: [
            _buildLevelBadge(_lesson!.level),
            SizedBox(width: 8.w),
            _buildCategoryChip(_lesson!.category),
            if (_lesson!.isPremium) ...[
              SizedBox(width: 8.w),
              _buildPremiumBadge(),
            ],
          ],
        ),
        SizedBox(height: 16.h),
        
        // Stats row
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildStatItem(Icons.access_time, '${_lesson!.duration} min'),
              SizedBox(width: 16.w),
              _buildStatItem(Icons.timer, _formatDuration(_lesson!.totalRatings * 5)),
              SizedBox(width: 16.w),
              _buildStatItem(Icons.star, _lesson!.rating.toStringAsFixed(1)),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        
        // Difficulty
        Row(
          children: [
            Text(
              'Difficulty: ',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) {
                final difficulty = _lesson!.difficulty * 5;
                return Icon(
                  index < difficulty ? Icons.circle : Icons.circle_outlined,
                  size: 12.w,
                  color: index < difficulty 
                      ? _getDifficultyColor(_lesson!.difficulty)
                      : Colors.grey[300],
                );
              }),
            ),
            SizedBox(width: 8.w),
            Text(
              _getDifficultyText(_lesson!.difficulty),
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLevelBadge(CEFRLevel level) {
    Color badgeColor;
    switch (level) {
      case CEFRLevel.a1:
        badgeColor = AppColors.cefrA1;
        break;
      case CEFRLevel.a2:
        badgeColor = AppColors.cefrA2;
        break;
      case CEFRLevel.b1:
        badgeColor = AppColors.cefrB1;
        break;
      case CEFRLevel.b2:
        badgeColor = AppColors.cefrB2;
        break;
      case CEFRLevel.c1:
        badgeColor = AppColors.cefrC1;
        break;
      case CEFRLevel.c2:
        badgeColor = AppColors.cefrC2;
        break;
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        level.name.toUpperCase(),
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: badgeColor,
        ),
      ),
    );
  }

  Widget _buildCategoryChip(LessonCategory category) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _getCategoryColor(category).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        category.name,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: _getCategoryColor(category),
        ),
      ),
    );
  }

  Widget _buildPremiumBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        'PREMIUM',
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: Colors.amber.shade700,
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16.w, color: AppColors.textSecondary),
        SizedBox(width: 4.w),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          _lesson!.description,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textPrimary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildLearningObjectives() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What You\'ll Learn',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 12.h),
        ...['Learn proper pronunciation techniques.',
          'Build vocabulary with interactive exercises.',
          'Practice speaking with AI feedback.',
          'Master common phrases and expressions.'].map((objective) => 
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle, size: 16.w, color: AppColors.success),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      objective,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).toList(),
      ],
    );
  }

  Widget _buildPrerequisites() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prerequisites',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 12.h),
        if (_lesson!.prerequisites.isEmpty)
          Text(
            'None - suitable for all levels',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          )
        else
          ..._lesson!.prerequisites.map((prereq) => Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Text(
              '• $prereq',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary,
              ),
            ),
          )).toList(),
      ],
    );
  }

  Widget _buildRelatedLessons() {
    // Need to implement related lessons
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Related Lessons',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          height: 120.h,
          child: Center(
            child: Text(
              'Coming soon...',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressOverview() {
    final progress = _progress?.progressPercentage ?? 0.0;
    final completed = _progress?.isCompleted ?? false;
    
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                completed ? Icons.emoji_events : Icons.pending_actions,
                color: completed ? AppColors.success : AppColors.warning,
                size: 24.w,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  completed ? 'Lesson Completed!' : 'In Progress',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: completed ? AppColors.success : AppColors.warning,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          
          // Progress bar
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              completed ? AppColors.success : AppColors.primary,
            ),
          ),
          SizedBox(height: 8.h),
          
          // Progress text
          Text(
            '${(progress * 100).round()}% Complete',
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressChart() {
    // Need to implement progress chart
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'Progress chart coming soon...',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildStatistics() {
    final stats = [
      {'label': 'Total Time', 'value': _formatDuration((_progress?.totalTimeSpent ?? 0))},
      {'label': 'Days Streak', 'value': '${_progress?.streakDays ?? 0}'},
      {'label': 'Attempts', 'value': '${_progress?.attempts ?? 0}'},
      {'label': 'Best Score', 'value': '${((_progress?.overallScore ?? 0.0) * 100).round()}%'},
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 12.h,
      childAspectRatio: 1.5,
      children: stats.map((stat) => Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stat['label']!,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textSecondary,
              ),
            ),
            Spacer(),
            Text(
              stat['value']!,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  // Actions
  void _toggleBookmark() {
    // Need to implement bookmark toggle
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_lesson!.bookmarked ? 'Removed from bookmarks' : 'Added to bookmarks'),
      ),
    );
  }

  void _shareLesson() {
    // Need to implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality coming soon')),
    );
  }

  void _startLesson() {
    // Need to navigate to lesson content player
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Starting lesson...')),
    );
  }

  Widget _buildContentCard(LessonContent item) {
    // Lesson content renderer placeholder
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: Text(
                    '${item.order}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      item.contentType.displayName,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                _getContentTypeIcon(item.contentType),
                size: 24.w,
                color: Colors.grey[600],
              ),
            ],
          ),
          if (item.text != null) ...[
            SizedBox(height: 12.h),
            Text(
              item.text!,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black87,
              ),
            ),
          ],
          if (item.audioUrl != null) ...[
            SizedBox(height: 12.h),
            Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  SizedBox(width: 12.w),
                  Icon(Icons.play_arrow, size: 16.w, color: Colors.grey[600]),
                  SizedBox(width: 8.w),
                  Text(
                    'Tap to play audio',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  

  // Helper methods
  Color _getCategoryColor(LessonCategory category) {
    switch (category) {
      case LessonCategory.vocabulary:
        return AppColors.vocabularyColor;
      case LessonCategory.grammar:
        return AppColors.grammarColor;
      case LessonCategory.pronunciation:
        return AppColors.pronunciationColor;
      case LessonCategory.phrases:
        return AppColors.phrasesColor;
      case LessonCategory.conversation:
        return AppColors.conversationColor;
      case LessonCategory.listening:
        return AppColors.listeningColor;
    }
  }

  IconData _getCategoryIcon(LessonCategory category) {
    switch (category) {
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
    if (difficulty <= 0.33) return AppColors.difficultyEasy;
    if (difficulty <= 0.67) return AppColors.difficultyMedium;
    return AppColors.difficultyHard;
  }

  IconData _getContentTypeIcon(ContentType contentType) {
    switch (contentType) {
      case ContentType.text:
        return Icons.text_fields;
      case ContentType.audio:
        return Icons.audiotrack;
      case ContentType.image:
        return Icons.image;
      case ContentType.video:
        return Icons.videocam;
      case ContentType.interactive:
        return Icons.touch_app;
      case ContentType.exercise:
        return Icons.assignment;
    }
  }

  String _getDifficultyText(double difficulty) {
    if (difficulty <= 0.33) return 'Easy';
    if (difficulty <= 0.67) return 'Medium';
    return 'Hard';
  }

  String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m ${secs}s';
    } else {
      return '${secs}s';
    }
  }

  // Mock data methods (remove when connecting to real data)
  Lesson _getMockLesson() {
    return Lesson(
      id: 'lesson-1',
      title: 'Basic English Greetings',
      description: 'Learn essential English greetings and introductions for everyday conversations.',
      level: CEFRLevel.a1,
      category: LessonCategory.phrases,
      type: LessonType.phrase,
      duration: 45,
      difficulty: 0.2,
      imageUrl: 'https://picsum.photos/seed/english-lesson/400/300.jpg',
      audioUrl: 'https://example.com/lesson-audio.mp3',
      isPremium: false,
      isCompleted: false,
      progress: 0.3,
      bookmarked: false,
      rating: 4.7,
      totalRatings: 156,
      tags: ['greetings', 'beginner', 'conversation'],
      prerequisites: [],
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now(),
    );
  }

  List<LessonContent> _getMockContent() {
    return [
      LessonContent(
        id: 'content-1',
        lessonId: 'lesson-1',
        title: 'Common Greetings',
        contentType: ContentType.text,
        order: 1,
        text: 'Hello!\n\nHi there!\n\nGood morning/afternoon/evening!',
        audioUrl: 'https://example.com/greetings-audio.mp3',
        duration: 30,
        phoneticTranscription: 'həˈləʊ/ /haɪ ˈðeə/',
        translation: 'Halo! / Hai!',
        isCompleted: false,
      ),
      LessonContent(
        id: 'content-2',
        lessonId: 'lesson-1',
        title: 'Introductions',
        contentType: ContentType.audio,
        order: 2,
        text: 'My name is [John].\nWhat\'s your name?',
        audioUrl: 'https://example.com/intro-audio.mp3',
        duration: 45,
        phoneticTranscription: 'maɪ neɪm ɪz/ /wɒts jə neɪm/',
        translation: 'Nama saya [John]. / Siapa nama anda?',
        isCompleted: false,
      ),
      LessonContent(
        id: 'content-3',
        lessonId: 'lesson-1',
        title: 'Practice Exercise',
        contentType: ContentType.exercise,
        order: 3,
        text: 'Introduce yourself with the phrases above.',
        interactiveData: {
          'type': 'pronunciation_practice',
          'phrases': [
            {'text': 'Hello, my name is...', 'audio': 'greeting.mp3'},
            {'text': 'Nice to meet you!', 'audio': 'nice-to-meet.mp3'},
          ],
        },
        duration: 0,
        isCompleted: false,
      ),
    ];
  }

  LessonProgress _getMockProgress() {
    return LessonProgress(
      lessonId: 'lesson-1',
      userId: 'user-1',
      startedAt: DateTime.now().subtract(const Duration(days: 1)),
      lastAccessed: DateTime.now(),
      completionStatus: CompletionStatus.inProgress,
      overallScore: 0.75,
      totalTimeSpent: 1800, // 30 minutes
      contentProgress: [
        ContentProgress(
          contentId: 'content-1',
          status: CompletionStatus.completed,
          score: 0.85,
          timeSpent: 300,
          attempts: 2,
        ),
        ContentProgress(
          contentId: 'content-2',
          status: CompletionStatus.inProgress,
          score: 0.70,
          timeSpent: 240,
          attempts: 1,
        ),
        ContentProgress(
          contentId: 'content-3',
          status: CompletionStatus.notStarted,
          timeSpent: 0,
          attempts: 0,
        ),
      ],
      streakDays: 3,
      attempts: 1,
    );
  }
}
