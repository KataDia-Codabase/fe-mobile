import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';
import 'package:katadia_fe/features/lessons/presentation/models/grammar_lesson.dart';
import 'package:katadia_fe/features/lessons/presentation/pages/grammar_lesson_eval_page.dart';
import 'package:katadia_fe/features/lessons/presentation/widgets/index.dart';

class GrammarLessonDetailPage extends StatelessWidget {
  final GrammarLesson lesson;

  const GrammarLessonDetailPage({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final subtitle = lesson.description.isEmpty
        ? 'Practice grammar with interactive sets'
        : lesson.description;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        children: [
          SpeakingHeader(
            title: lesson.title,
            subtitle: subtitle,
            onBack: () => Navigator.pop(context),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.xxl,
                AppSpacing.lg,
                AppSpacing.xxl,
                AppSpacing.xxxl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _LessonOverview(lesson: lesson),
                  SizedBox(height: AppSpacing.xxl),
                  _ExercisesSection(lesson: lesson),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonOverview extends StatelessWidget {
  final GrammarLesson lesson;

  const _LessonOverview({required this.lesson});

  @override
  Widget build(BuildContext context) {
    final percent = (lesson.progress * 100).round();
    final completedLabel =
        '${lesson.completedSets} of ${lesson.setsCount} completed';

    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        boxShadow: AppShadows.light,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: AppTextStyles.heading3,
                    ),
                  ],
                ),
              ),
              LevelBadge(label: lesson.level),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Text(
                completedLabel,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMedium,
                ),
              ),
              const Spacer(),
              Text(
                '$percent%',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            child: LinearProgressIndicator(
              value: lesson.progress,
              minHeight: 6,
              backgroundColor: AppColors.borderLight,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExercisesSection extends StatelessWidget {
  final GrammarLesson lesson;

  const _ExercisesSection({required this.lesson});

  @override
  Widget build(BuildContext context) {
    if (lesson.exerciseSets.isEmpty) {
      return const _EmptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Grammar Exercises',
                style: AppTextStyles.heading3,
              ),
            ),
            Text(
              '${lesson.setsCount} sets',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMedium),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.md),
        ...lesson.exerciseSets.asMap().entries.map(
          (entry) => Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.md),
            child: _ExerciseSetCard(
              lesson: lesson,
              order: entry.key + 1,
              set: entry.value,
            ),
          ),
        ),
      ],
    );
  }
}

class _ExerciseSetCard extends StatelessWidget {
  final GrammarLesson lesson;
  final int order;
  final GrammarExerciseSet set;

  const _ExerciseSetCard({
    required this.lesson,
    required this.order,
    required this.set,
  });

  @override
  Widget build(BuildContext context) {
    final subtitle = '${set.duration} • ${set.exercises} questions';
    final buttonLabel = set.completed ? 'Review Quiz' : 'Start Practice';

    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        boxShadow: AppShadows.light,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _NumberBadge(value: order, completed: set.completed),
              SizedBox(width: AppSpacing.sm),
              set.completed ? const _CompletionBadge() : const _PendingBadge(),
              const Spacer(),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            set.title,
            style: AppTextStyles.heading3.copyWith(fontSize: 18),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            subtitle,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMedium,
            ),
          ),
          SizedBox(height: AppSpacing.lg),
          _PracticeButton(
            label: buttonLabel,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GrammarLessonEvalPage(
                    lesson: lesson,
                    set: set,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
class _PracticeButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PracticeButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: AppColors.bgDisabled,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.play_arrow_rounded, color: AppColors.primary),
              SizedBox(width: AppSpacing.sm),
              Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NumberBadge extends StatelessWidget {
  final int value;
  final bool completed;

  const _NumberBadge({required this.value, required this.completed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: completed
            ? AppColors.accentGreen.withValues(alpha: 0.15)
            : AppColors.bgDisabled,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Text(
        value.toString(),
        style: AppTextStyles.bodySmall.copyWith(
          color: completed ? AppColors.accentGreen : AppColors.textMedium,
        ),
      ),
    );
  }
}

class _CompletionBadge extends StatelessWidget {
  const _CompletionBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentGreen.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Text(
        'Completed',
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.accentGreen,
        ),
      ),
    );
  }
}

class _PendingBadge extends StatelessWidget {
  const _PendingBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.bgDisabled,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Text(
        'New',
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textMedium,
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No sets available',
            style: AppTextStyles.bodyLarge,
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            'Set grammar exercises belum tersedia. Silakan kembali lagi nanti.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMedium,
            ),
          ),
        ],
      ),
    );
  }
}
