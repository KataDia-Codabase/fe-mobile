import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';
import 'package:katadia_fe/features/lessons/presentation/models/reading_lesson.dart';
import 'package:katadia_fe/features/lessons/presentation/pages/reading_lesson_detail_page.dart';
import 'package:katadia_fe/features/lessons/presentation/widgets/index.dart';

class ReadingLessonsPage extends StatelessWidget {
  const ReadingLessonsPage({super.key});

  static final List<ReadingLesson> _lessons = [
    ReadingLesson(
      title: 'Daily Stories',
      description: 'Short passages to improve everyday reading skills',
      level: 'A2',
      duration: '10 min',
      articles: 6,
      xpReward: 60,
      progress: 0.45,
      status: ReadingStatus.inProgress,
      completedPassages: 3,
      totalPassages: 6,
      passages: [
        ReadingPassage(
          order: 1,
          title: 'A Day at the Beach',
          durationLabel: '5 min',
          questions: 3,
          completed: false,
          paragraphs: [
            'Last Saturday, I went to the beach with my family. The weather was perfect - sunny and warm with a gentle breeze. We arrived early in the morning when the beach was still quiet.',
            'My sister and I played in the water while our parents relaxed under a big umbrella. We built a sandcastle and collected pretty shells. For lunch, we had sandwiches and fresh fruit.',
            'In the afternoon, my father taught me how to swim. It was scary at first, but soon I was having fun! We stayed until sunset, watching the sky turn orange and pink.',
            'It was a wonderful day. I cannot wait to go back to the beach again!',
          ],
        ),
        ReadingPassage(
          order: 2,
          title: 'Morning Routine',
          durationLabel: '4 min',
          questions: 3,
          completed: true,
          paragraphs: [
            'Every weekday, I wake up at 6:00 a.m. I make my bed, brush my teeth, and wash my face. After that, I prepare a cup of warm tea and eat a bowl of oatmeal.',
            'Before leaving for work, I check my schedule and pack my bag. This routine helps me start the day calmly and stay focused.',
          ],
        ),
      ],
    ),
    ReadingLesson(
      title: 'Short Articles',
      description: 'Practice scanning longer paragraphs for details',
      level: 'B1',
      duration: '15 min',
      articles: 4,
      xpReward: 90,
      progress: 0.2,
      status: ReadingStatus.available,
      completedPassages: 0,
      totalPassages: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        children: [
          SpeakingHeader(
            title: 'Reading Lessons',
            subtitle: 'Enhance comprehension with guided practice',
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
                  ..._lessons.map(
                    (lesson) => Padding(
                      padding: EdgeInsets.only(bottom: AppSpacing.lg),
                      child: _ReadingLessonCard(lesson: lesson),
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

class _ReadingLessonCard extends StatelessWidget {
  final ReadingLesson lesson;

  const _ReadingLessonCard({required this.lesson});

  Color _statusColor() {
    switch (lesson.status) {
      case ReadingStatus.completed:
        return AppColors.accentGreen;
      case ReadingStatus.inProgress:
        return AppColors.primary;
      case ReadingStatus.available:
        return AppColors.accentYellowDark;
    }
  }

  IconData _statusIcon() {
    switch (lesson.status) {
      case ReadingStatus.completed:
        return Icons.check_circle;
      case ReadingStatus.inProgress:
        return Icons.menu_book_rounded;
      case ReadingStatus.available:
        return Icons.auto_stories_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressPercent = (lesson.progress * 100).round();
    final detailLabel = '${lesson.articles} articles • ${lesson.duration}';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ReadingLessonDetailPage(lesson: lesson),
            ),
          );
        },
        child: Container(
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
                  _LessonIcon(
                    icon: _statusIcon(),
                    background: _statusColor().withValues(alpha: 0.12),
                    color: _statusColor(),
                  ),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lesson.title,
                          style: AppTextStyles.heading3.copyWith(fontSize: 18),
                        ),
                        SizedBox(height: AppSpacing.xs),
                        Row(
                          children: [
                            LevelBadge(label: lesson.level),
                            SizedBox(width: AppSpacing.sm),
                            Text(
                              detailLabel,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _XpBadge(xp: lesson.xpReward),
                ],
              ),
              SizedBox(height: AppSpacing.md),
              Text(
                lesson.description,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMedium,
                ),
              ),
              SizedBox(height: AppSpacing.sm),
              if (lesson.status == ReadingStatus.completed ||
                  lesson.status == ReadingStatus.inProgress)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '$progressPercent%',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: AppSpacing.sm),
                    _LessonProgress(progress: lesson.progress),
                  ],
                )
              else
                _LessonCTA(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LessonIcon extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color color;

  const _LessonIcon({
    required this.icon,
    required this.background,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      ),
      child: Icon(icon, color: color),
    );
  }
}

class _LessonProgress extends StatelessWidget {
  final double progress;

  const _LessonProgress({required this.progress});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 6,
        backgroundColor: AppColors.borderLight,
        valueColor: AlwaysStoppedAnimation(AppColors.primary),
      ),
    );
  }
}

class _LessonCTA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Start Lesson',
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
        ),
        SizedBox(width: AppSpacing.sm),
        Icon(Icons.arrow_forward_rounded, color: AppColors.primary),
      ],
    );
  }
}

class _XpBadge extends StatelessWidget {
  final int xp;

  const _XpBadge({required this.xp});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentYellow.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Text(
        '+$xp XP',
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.accentYellowDark),
      ),
    );
  }
}
