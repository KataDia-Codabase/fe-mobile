import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';

import '../widgets/index.dart';
import 'cefr_assessment_intro_page.dart';

class LessonCategoriesPage extends StatelessWidget {
  LessonCategoriesPage({super.key});

  final List<_LessonCategory> _categories = [
    _LessonCategory(
      title: 'CEFR Assessment',
      subtitle: 'Tes Level CEFR',
      description: 'Test your English proficiency level',
      lessons: 15,
      duration: '30 min',
      icon: Icons.auto_graph_rounded,
      accentColor: AppColors.primary,
      backgroundColor: AppColors.surface,
      routeBuilder: () => const CEFRAssessmentIntroPage(),
    ),
    _LessonCategory(
      title: 'Speaking Lessons',
      subtitle: 'Latihan Speaking',
      description: 'Practice pronunciation with AI feedback',
      lessons: 24,
      duration: '5-10 min',
      icon: Icons.mic_none_rounded,
      accentColor: AppColors.accentGreen,
      backgroundColor: AppColors.surface,
    ),
    _LessonCategory(
      title: 'Listening Practice',
      subtitle: 'Latihan Listening',
      description: 'Improve comprehension skills',
      lessons: 30,
      duration: '10-15 min',
      icon: Icons.headphones_rounded,
      accentColor: AppColors.accentPurple,
      backgroundColor: AppColors.surface,
    ),
    _LessonCategory(
      title: 'Reading Comprehension',
      subtitle: 'Pemahaman Bacaan',
      description: 'Enhance reading skills',
      lessons: 20,
      duration: '15-20 min',
      icon: Icons.menu_book_rounded,
      accentColor: AppColors.accentYellow,
      backgroundColor: AppColors.surface,
    ),
    _LessonCategory(
      title: 'Vocabulary Builder',
      subtitle: 'Kosakata',
      description: 'Learn new words daily',
      lessons: 100,
      duration: '5 min',
      icon: Icons.bookmarks_outlined,
      accentColor: AppColors.primary,
      backgroundColor: AppColors.surface,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        children: [
          _LessonHeader(
            onBack: () => Navigator.pop(context),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.xxl,
                AppSpacing.lg,
                AppSpacing.xxl,
                AppSpacing.xxxl,
              ),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.lg),
                  child: LessonCategoryCard(
                    icon: category.icon,
                    title: category.title,
                    subtitle: category.subtitle,
                    description: category.description,
                    lessonsCount: category.lessons,
                    duration: category.duration,
                    accentColor: category.accentColor,
                    backgroundColor: category.backgroundColor,
                    onTap: () {
                      final target = category.routeBuilder?.call();
                      if (target != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => target),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonHeader extends StatelessWidget {
  final VoidCallback onBack;

  const _LessonHeader({required this.onBack});

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppSpacing.radiusFull),
          bottomRight: Radius.circular(AppSpacing.radiusFull),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xxl,
        paddingTop + AppSpacing.md,
        AppSpacing.xxl,
        AppSpacing.xl,
      ),
      child: Row(
        children: [
          _HeaderButton(
            icon: Icons.arrow_back,
            onTap: onBack,
          ),
          SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lesson Categories',
                  style: AppTextStyles.heading3.copyWith(color: Colors.white),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  'Kategori Pembelajaran',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.15),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.sm),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _LessonCategory {
  final String title;
  final String subtitle;
  final String description;
  final int lessons;
  final String duration;
  final IconData icon;
  final Color accentColor;
  final Color backgroundColor;
  final Widget Function()? routeBuilder;

  _LessonCategory({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.lessons,
    required this.duration,
    required this.icon,
    required this.accentColor,
    required this.backgroundColor,
    this.routeBuilder,
  });
}
