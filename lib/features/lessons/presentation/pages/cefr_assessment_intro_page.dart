import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';

import 'cefr_assessment_page.dart';

class CEFRAssessmentIntroPage extends StatelessWidget {
  const CEFRAssessmentIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        children: [
          const _ResultHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.xxl,
                AppSpacing.xxxl,
                AppSpacing.xxl,
                AppSpacing.xxxl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AssessmentCard(),
              SizedBox(height: AppSpacing.xxxl),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                        ),
                      ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CEFRAssessmentPage(),
                        ),
                      );
                    },
                      child: Text(
                        'Start Assessment',
                        style: AppTextStyles.button,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultHeader extends StatelessWidget {
  const _ResultHeader();

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xxl,
        paddingTop + AppSpacing.md,
        AppSpacing.xxl,
        AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppSpacing.radiusFull),
          bottomRight: Radius.circular(AppSpacing.radiusFull),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Level Assessment',
            style: AppTextStyles.heading3.copyWith(color: Colors.white),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            'Discover your English proficiency level',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}


class _AssessmentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        boxShadow: AppShadows.light,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
                  ),
                  child: Icon(
                    Icons.menu_book_rounded,
                    size: 40,
                    color: AppColors.primary,
                  ),
                ),
                Positioned(
                  top: -6,
                  right: -6,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentYellow,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                      boxShadow: AppShadows.light,
                    ),
                    child: Text(
                      'A-C',
                      style: AppTextStyles.labelSmall.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.xl),
          Text(
            'What is CEFR?',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            'The Common European Framework for Languages assesses your English skills from A1 (Beginner) to C2 (Mastery).',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMedium,
              height: 1.5,
            ),
          ),
          SizedBox(height: AppSpacing.xl),
          const _FeatureItem(
            icon: Icons.timer,
            title: '15 Minutes',
            description: 'Quick assessment covering key skills',
            color: AppColors.primary,
          ),
          SizedBox(height: AppSpacing.lg),
          const _FeatureItem(
            icon: Icons.hearing_rounded,
            title: 'Listening & Reading',
            description: 'Test your comprehension abilities',
            color: AppColors.accentYellow,
          ),
          SizedBox(height: AppSpacing.lg),
          const _FeatureItem(
            icon: Icons.check_circle_outline,
            title: 'Instant Results',
            description: 'Get your CEFR level immediately',
            color: AppColors.accentGreen,
          ),
          SizedBox(height: AppSpacing.xxl),
          _CefrLevels(),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          ),
          child: Icon(icon, color: color),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                description,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CefrLevels extends StatelessWidget {
  final List<_LevelData> _levels = const [
    _LevelData(level: 'A1', label: 'Beginner'),
    _LevelData(level: 'A2', label: 'Elementary'),
    _LevelData(level: 'B1', label: 'Intermediate'),
    _LevelData(level: 'B2', label: 'Upper Intermediate'),
    _LevelData(level: 'C1', label: 'Advanced'),
    _LevelData(level: 'C2', label: 'Mastery'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CEFR Levels',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: AppSpacing.md),
          ..._levels.map((level) {
            return Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      level.level,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.lg),
                  Text(
                    level.label,
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _LevelData {
  final String level;
  final String label;

  const _LevelData({
    required this.level,
    required this.label,
  });
}
