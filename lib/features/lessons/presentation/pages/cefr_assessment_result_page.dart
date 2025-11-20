import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';

import 'lesson_categories_page.dart';

class CEFRAssessmentResultPage extends StatefulWidget {
  final String level;
  final String levelLabel;

  const CEFRAssessmentResultPage({
    super.key,
    this.level = 'B1',
    this.levelLabel = 'Intermediate',
  });

  @override
  State<CEFRAssessmentResultPage> createState() => _CEFRAssessmentResultPageState();
}

class _CEFRAssessmentResultPageState extends State<CEFRAssessmentResultPage> {
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
                children: [
                  _ResultCard(
                    level: widget.level,
                    levelLabel: widget.levelLabel,
                  ),
                  SizedBox(height: AppSpacing.xxxl),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LessonCategoriesPage()),
                        );
                      },
                      icon: const Icon(Icons.menu_book_outlined, color: Colors.white),
                      label: Text('Take Lessons', style: AppTextStyles.button),
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

class _ResultCard extends StatelessWidget {
  final String level;
  final String levelLabel;

  const _ResultCard({
    required this.level,
    required this.levelLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.xxl),
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
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.bgLight,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    size: 56,
                    color: AppColors.primary,
                  ),
                ),
                Positioned(
                  top: -8,
                  right: -8,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentYellow,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                    ),
                    child: Text(
                      level,
                      style: AppTextStyles.labelSmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.xxl),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _ScoreDot(label: '82', color: AppColors.accentYellow),
              _ScoreDot(label: '75', color: AppColors.primary),
              _ScoreDot(label: '88', color: AppColors.accentGreen),
            ],
          ),
          SizedBox(height: AppSpacing.xxl),
          Text(
            'CEFR Level Progress',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMedium),
          ),
          SizedBox(height: AppSpacing.sm),
          _LevelProgress(level: level),
          SizedBox(height: AppSpacing.xxl),
          _LevelDescription(level: level, levelLabel: levelLabel),
          SizedBox(height: AppSpacing.xxl),
          _StatsList(),
          SizedBox(height: AppSpacing.xxl),
          _NextLevelCard(),
        ],
      ),
    );
  }
}

class _ScoreDot extends StatelessWidget {
  final String label;
  final Color color;

  const _ScoreDot({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTextStyles.bodyLarge.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _LevelProgress extends StatelessWidget {
  final String level;

  const _LevelProgress({required this.level});

  @override
  Widget build(BuildContext context) {
    final labels = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];
    final activeIndex = labels.indexOf(level);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: labels.map((label) {
            final isActive = label == level;
            return Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: isActive ? AppColors.primary : AppColors.textMedium,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: (activeIndex + 1) / labels.length,
            minHeight: 6,
            backgroundColor: AppColors.borderLight,
            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
          ),
        ),
      ],
    );
  }
}

class _LevelDescription extends StatelessWidget {
  final String level;
  final String levelLabel;

  const _LevelDescription({
    required this.level,
    required this.levelLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      ),
      child: RichText(
        text: TextSpan(
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textMedium,
            height: 1.5,
          ),
          children: [
            const TextSpan(text: 'Congratulations! '),
            TextSpan(
              text: 'You\'re at $level level ($levelLabel). ',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(
              text: 'You can understand main points of clear standard input and deal with most situations in the target language area.',
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsList extends StatelessWidget {
  final Map<String, double> stats = const {
    'Vocabulary': 0.82,
    'Grammar': 0.75,
    'Listening': 0.88,
  };

  const _StatsList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: stats.entries.map((entry) {
        Color color;
        if (entry.value >= 0.85) {
          color = AppColors.accentGreen;
        } else if (entry.value >= 0.75) {
          color = AppColors.primary;
        } else {
          color = AppColors.accentYellow;
        }
        return Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                entry.key,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMedium),
              ),
              Text(
                '${(entry.value * 100).round()}%',
                style: AppTextStyles.bodyMedium.copyWith(color: color, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _NextLevelCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Next: Level Up to B2',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            'Continue learning to reach Upper Intermediate level',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMedium),
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            'Progress to B2  0 / 2000 XP',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMedium),
          ),
          SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: 0.2,
              minHeight: 6,
              backgroundColor: AppColors.borderLight,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: const [
              _FocusChip(label: 'Advanced grammar'),
              _FocusChip(label: 'Complex conversations'),
              _FocusChip(label: 'Academic writing'),
            ],
          ),
        ],
      ),
    );
  }
}

class _FocusChip extends StatelessWidget {
  final String label;

  const _FocusChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textDark),
      ),
    );
  }
}

