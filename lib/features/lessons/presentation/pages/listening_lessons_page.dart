import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';
import 'package:katadia_fe/features/lessons/presentation/models/listening_lesson.dart';
import 'package:katadia_fe/features/lessons/presentation/pages/listening_lesson_detail_page.dart';
import 'package:katadia_fe/features/lessons/presentation/widgets/index.dart';

class ListeningLessonsPage extends StatelessWidget {
  const ListeningLessonsPage({super.key});

  static final List<ListeningLesson> _lessons = [
    ListeningLesson(
      title: 'Basic Conversations',
      description: 'Build everyday listening confidence',
      duration: '8 min',
      audios: 4,
      level: 'A1',
      status: ListeningStatus.completed,
      progress: 0.8,
      contents: [
        ListeningLessonContent(
          order: 1,
          title: 'Introducing Yourself',
          durationLabel: '2 min',
          questions: 3,
          completed: true,
          audioUrl: 'https://cdn.sample/intro.m4a',
        ),
        ListeningLessonContent(
          order: 2,
          title: 'Asking for Directions',
          durationLabel: '2 min',
          questions: 3,
          completed: true,
          audioUrl: 'https://cdn.sample/directions.m4a',
        ),
        ListeningLessonContent(
          order: 3,
          title: 'Ordering Food',
          durationLabel: '3 min',
          questions: 3,
          completed: false,
          audioUrl: 'https://cdn.sample/ordering-food.m4a',
        ),
        ListeningLessonContent(
          order: 4,
          title: 'Shopping Dialogue',
          durationLabel: '3 min',
          questions: 3,
          completed: false,
          audioUrl: 'https://cdn.sample/shopping.m4a',
        ),
      ],
    ),
    ListeningLesson(
      title: 'At the Restaurant',
      description: 'Understand food ordering scenarios',
      duration: '10 min',
      audios: 6,
      level: 'A1',
      status: ListeningStatus.completed,
      progress: 0.6,
      contents: [
        ListeningLessonContent(
          order: 1,
          title: 'Booking a Table',
          durationLabel: '2 min',
          questions: 4,
          completed: true,
          audioUrl: 'https://cdn.sample/table.m4a',
        ),
        ListeningLessonContent(
          order: 2,
          title: 'Ordering Drinks',
          durationLabel: '2 min',
          questions: 3,
          completed: false,
          audioUrl: 'https://cdn.sample/drinks.m4a',
        ),
        ListeningLessonContent(
          order: 3,
          title: 'Dealing with Issues',
          durationLabel: '3 min',
          questions: 4,
          completed: false,
          audioUrl: 'https://cdn.sample/issues.m4a',
        ),
      ],
    ),
    ListeningLesson(
      title: 'Shopping Dialogue',
      description: 'Master shopping conversations',
      duration: '12 min',
      audios: 7,
      level: 'A2',
      status: ListeningStatus.inProgress,
      progress: 0.3,
      contents: [
        ListeningLessonContent(
          order: 1,
          title: 'Comparing Prices',
          durationLabel: '3 min',
          questions: 4,
          completed: false,
          audioUrl: 'https://cdn.sample/prices.m4a',
        ),
        ListeningLessonContent(
          order: 2,
          title: 'Asking for Sizes',
          durationLabel: '2 min',
          questions: 3,
          completed: false,
          audioUrl: 'https://cdn.sample/sizes.m4a',
        ),
        ListeningLessonContent(
          order: 3,
          title: 'Making Returns',
          durationLabel: '3 min',
          questions: 4,
          completed: false,
          audioUrl: 'https://cdn.sample/returns.m4a',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        children: [
          SpeakingHeader(
            title: 'Listening Practice',
            subtitle: 'Latihan Mendengar',
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
                  _SectionHeader(totalLessons: _lessons.length),
                  SizedBox(height: AppSpacing.lg),
                  ..._lessons.map(
                    (lesson) => Padding(
                      padding: EdgeInsets.only(bottom: AppSpacing.md),
                      child: _ListeningLessonCard(lesson: lesson),
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

class _SectionHeader extends StatelessWidget {
  final int totalLessons;

  const _SectionHeader({required this.totalLessons});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Listening Contents',
              style: AppTextStyles.heading3,
            ),
            SizedBox(height: AppSpacing.xs),
            Text(
              'Latihan mendengar harian',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textMedium,
              ),
            ),
          ],
        ),
        const Spacer(),
        Text(
          '$totalLessons lessons',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textMedium,
          ),
        ),
      ],
    );
  }
}

class _ListeningLessonCard extends StatelessWidget {
  final ListeningLesson lesson;

  const _ListeningLessonCard({required this.lesson});

  Color _statusColor() {
    switch (lesson.status) {
      case ListeningStatus.completed:
        return AppColors.accentGreen;
      case ListeningStatus.inProgress:
        return AppColors.accentPurple;
    }
  }

  IconData _statusIcon() {
    switch (lesson.status) {
      case ListeningStatus.completed:
        return Icons.check_circle;
      case ListeningStatus.inProgress:
        return Icons.play_circle_outline;
    }
  }

  void _openDetail(BuildContext context) {
    debugPrint('Opening listening detail: ${lesson.title}');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ListeningLessonDetailPage(lesson: lesson),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () => _openDetail(context),
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
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
                  Container(
                    padding: EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: _statusColor().withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                    ),
                    child: Icon(
                      _statusIcon(),
                      color: _statusColor(),
                    ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LevelBadge(label: lesson.level),
                            SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                lesson.description,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.md),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${(lesson.progress * 100).round()}%',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textMedium,
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.xs),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                child: LinearProgressIndicator(
                  value: lesson.progress,
                  minHeight: 6,
                  backgroundColor: AppColors.borderLight,
                  valueColor: AlwaysStoppedAnimation(_statusColor()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
