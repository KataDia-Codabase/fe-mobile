import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';
import 'package:katadia_fe/features/lessons/presentation/models/listening_lesson.dart';
import 'package:katadia_fe/features/lessons/presentation/pages/listening_lesson_eval_page.dart';
import 'package:katadia_fe/features/lessons/presentation/widgets/index.dart';

class ListeningLessonDetailPage extends StatelessWidget {
  final ListeningLesson lesson;

  const ListeningLessonDetailPage({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final subtitle = lesson.description.isEmpty
        ? 'Practice listening comprehension'
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
                  const _ListeningTipsCard(),
                  SizedBox(height: AppSpacing.xxl),
                  _ContentsSection(lesson: lesson),
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
  final ListeningLesson lesson;

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

class _ListeningTipsCard extends StatelessWidget {
  const _ListeningTipsCard();

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
                  'Listening tips',
                  style: AppTextStyles.bodyLarge,
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  'Gunakan headphone dan fokus pada kata kunci. Putar ulang audio jika perlu, lalu jawab pertanyaannya.',
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

class _ContentsSection extends StatelessWidget {
  final ListeningLesson lesson;

  const _ContentsSection({required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (lesson.contents.isEmpty)
          const _EmptyState()
        else
          ...lesson.contents.map(
            (content) => Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.md),
              child: _ListeningContentCard(
                lesson: lesson,
                content: content,
              ),
            ),
          ),
      ],
    );
  }
}

class _ListeningContentCard extends StatelessWidget {
  final ListeningLesson lesson;
  final ListeningLessonContent content;

  const _ListeningContentCard({required this.lesson, required this.content});

  @override
  Widget build(BuildContext context) {
    final subtitle = '${content.durationLabel} • ${content.questions} questions';
    final buttonLabel = content.completed ? 'Review Audio' : 'Start Listening';

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
              content.completed
                  ? const _CompletionBadge()
                  : const _PendingBadge(),
              const Spacer(),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            content.title,
            style: AppTextStyles.heading3.copyWith(fontSize: 18),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            subtitle,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMedium,
            ),
          ),
          SizedBox(height: AppSpacing.md),
          _ListenButton(
            label: buttonLabel,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ListeningLessonEvalPage(
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

class _ListenButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _ListenButton({required this.label, required this.onTap});

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
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
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
            'Belum ada konten',
            style: AppTextStyles.bodyLarge,
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            'Tim kami sedang menyiapkan audio latihan baru.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMedium,
            ),
          ),
        ],
      ),
    );
  }
}
