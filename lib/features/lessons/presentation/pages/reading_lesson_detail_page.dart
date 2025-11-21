import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';
import 'package:katadia_fe/features/lessons/presentation/models/reading_lesson.dart';
import 'package:katadia_fe/features/lessons/presentation/pages/reading_lesson_eval_page.dart';
import 'package:katadia_fe/features/lessons/presentation/widgets/index.dart';

class ReadingLessonDetailPage extends StatelessWidget {
  final ReadingLesson lesson;

  const ReadingLessonDetailPage({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        children: [
          SpeakingHeader(
            title: lesson.title,
            subtitle: lesson.description,
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
                  const _ReadingTipsCard(),
                  SizedBox(height: AppSpacing.xxl),
                  _PassagesSection(lesson: lesson),
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
  final ReadingLesson lesson;

  const _LessonOverview({required this.lesson});

  @override
  Widget build(BuildContext context) {
    final percent = (lesson.progress * 100).round();
    final completedLabel =
        '${lesson.completedPassages} of ${lesson.totalPassages} completed';

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

class _ReadingTipsCard extends StatelessWidget {
  const _ReadingTipsCard();

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
            child: Icon(Icons.menu_book_rounded, color: AppColors.primary),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reading strategies',
                  style: AppTextStyles.bodyLarge,
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  'Baca judul dan kalimat pertama untuk memahami konteks. Tandai kata kunci penting sebelum menjawab pertanyaan.',
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

class _PassagesSection extends StatelessWidget {
  final ReadingLesson lesson;

  const _PassagesSection({required this.lesson});

  @override
  Widget build(BuildContext context) {
    if (lesson.passages.isEmpty) {
      return const _EmptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...lesson.passages.map(
          (passage) => Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.md),
            child: _ReadingPassageCard(lesson: lesson, passage: passage),
          ),
        ),
      ],
    );
  }
}

class _ReadingPassageCard extends StatelessWidget {
  final ReadingLesson lesson;
  final ReadingPassage passage;

  const _ReadingPassageCard({required this.lesson, required this.passage});

  @override
  Widget build(BuildContext context) {
    final subtitle = '${passage.durationLabel} • ${passage.questions} questions';
    final buttonLabel = passage.completed ? 'Review Passage' : 'Start Reading';
    final preview = passage.paragraphs.isNotEmpty ? passage.paragraphs.first : '';

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
              _NumberBadge(value: passage.order, completed: passage.completed),
              SizedBox(width: AppSpacing.sm),
              passage.completed
                  ? const _CompletionBadge()
                  : const _PendingBadge(),
              const Spacer(),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            passage.title,
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
          Text(
            preview,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: AppSpacing.lg),
          _ReadButton(
            label: buttonLabel,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReadingLessonEvalPage(
                    lesson: lesson,
                    passage: passage,
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

class _ReadButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _ReadButton({required this.label, required this.onTap});

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
            Icon(Icons.menu_book_rounded, color: AppColors.primary),
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
            'No passages yet',
            style: AppTextStyles.bodyLarge,
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            'Silakan kembali lagi nanti untuk materi membaca berikutnya.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMedium,
            ),
          ),
        ],
      ),
    );
  }
}
