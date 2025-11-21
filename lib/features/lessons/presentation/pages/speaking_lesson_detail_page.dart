import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';
import 'package:katadia_fe/features/lessons/presentation/models/speaking_lesson.dart';
import 'package:katadia_fe/features/lessons/presentation/pages/speaking_lesson_eval_page.dart';
import 'package:katadia_fe/features/lessons/presentation/widgets/index.dart';

class SpeakingLessonDetailPage extends StatelessWidget {
  final SpeakingLesson lesson;

  const SpeakingLessonDetailPage({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final subtitle = lesson.description.isEmpty
        ? 'Practice pronunciation with AI feedback'
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
                  const _HowItWorksCard(),
                  SizedBox(height: AppSpacing.xxl),
                  if (lesson.contents.isEmpty)
                    const _EmptyLessonState()
                  else
                    ...lesson.contents.map(
                      (content) => Padding(
                        padding: EdgeInsets.only(bottom: AppSpacing.lg),
                        child: _LessonContentCard(
                          lesson: lesson,
                          content: content,
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

class _LessonOverview extends StatelessWidget {
  final SpeakingLesson lesson;

  const _LessonOverview({required this.lesson});

  @override
  Widget build(BuildContext context) {
    final percent = (lesson.progress * 100).round();
    final completedLabel =
        '${lesson.completedContents} of ${lesson.totalContents} completed';

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
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      lesson.description,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textMedium,
                      ),
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
              valueColor: AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

class _HowItWorksCard extends StatelessWidget {
  const _HowItWorksCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.info_outline, color: AppColors.primary),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How it works',
                  style: AppTextStyles.bodyLarge,
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  'Tap the record button, speak the sentence clearly, and our AI will evaluate your pronunciation, fluency, and accuracy.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textMedium,
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

class _LessonContentCard extends StatelessWidget {
  final SpeakingLesson lesson;
  final LessonContent content;

  const _LessonContentCard({required this.lesson, required this.content});

  @override
  Widget build(BuildContext context) {
    final percent = (content.score * 100).round();
    final buttonLabel = content.completed ? 'Practice Again' : 'Start Practice';

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
              _NumberBadge(
                value: content.order,
                completed: content.completed,
              ),
              SizedBox(width: AppSpacing.sm),
              if (content.completed)
                _CompletionBadge(percent: percent)
              else
                _PendingBadge(),
              const Spacer(),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            content.phrase,
            style: AppTextStyles.heading3.copyWith(fontSize: 18),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            content.translation,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMedium,
            ),
          ),
          SizedBox(height: AppSpacing.md),
          _PracticeButton(
            label: buttonLabel,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SpeakingLessonEvalPage(
                    lesson: lesson,
                    content: content,
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

class _NumberBadge extends StatelessWidget {
  final int value;
  final bool completed;

  const _NumberBadge({required this.value, required this.completed});

  @override
  Widget build(BuildContext context) {
    final Color textColor =
        completed ? AppColors.accentGreen : AppColors.textMedium;
    final Color bgColor = completed
        ? AppColors.accentGreen.withValues(alpha: 0.15)
        : AppColors.bgDisabled;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Text(
        value.toString(),
        style: AppTextStyles.bodySmall.copyWith(color: textColor),
      ),
    );
  }
}

class _CompletionBadge extends StatelessWidget {
  final int percent;

  const _CompletionBadge({required this.percent});

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
        '$percent%',
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.accentGreen),
      ),
    );
  }
}

class _PendingBadge extends StatelessWidget {
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

class _PracticeButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PracticeButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
              style:
                  AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyLessonState extends StatelessWidget {
  const _EmptyLessonState();

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
            'Lesson content coming soon',
            style: AppTextStyles.bodyLarge,
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            'We are preparing interactive speaking prompts for this lesson.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMedium,
            ),
          ),
        ],
      ),
    );
  }
}
