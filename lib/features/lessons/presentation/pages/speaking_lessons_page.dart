import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';
import 'package:katadia_fe/features/lessons/presentation/models/speaking_lesson.dart';
import 'package:katadia_fe/features/lessons/presentation/pages/speaking_lesson_detail_page.dart';
import 'package:katadia_fe/features/lessons/presentation/widgets/index.dart';

class SpeakingLessonsPage extends StatelessWidget {
  const SpeakingLessonsPage({super.key});

  static final List<SpeakingLesson> _lessons = [
    SpeakingLesson(
      title: 'Basic Greetings',
      level: 'A1',
      sentences: 5,
      xpReward: 50,
      progress: 0.4,
      status: LessonStatus.completed,
      description: 'Learn how to greet people in different situations',
      completedContents: 2,
      totalContents: 5,
      contents: const [
        LessonContent(
          order: 1,
          phrase: 'Hello, how are you?',
          translation: 'Halo, apa kabar?',
          phonetic: '/həˈloʊ, haʊ ɑr juː/',
          tip: 'Pronounce "how" with a clear /h/ sound at the beginning.',
          score: 0.95,
          completed: true,
          audioUrl:
              'https://storage.googleapis.com/katadia-audio/basic-greetings-1.mp3',
        ),
        LessonContent(
          order: 2,
          phrase: 'Good morning, have a nice day!',
          translation: 'Selamat pagi, semoga harimu menyenangkan!',
          phonetic: '/ɡʊd ˈmɔːrnɪŋ/',
          tip: 'Keep your tone rising slightly at the end for friendliness.',
          score: 0.88,
          completed: true,
          audioUrl:
              'https://storage.googleapis.com/katadia-audio/basic-greetings-2.mp3',
        ),
        LessonContent(
          order: 3,
          phrase: 'Nice to meet you.',
          translation: 'Senang bertemu denganmu.',
          phonetic: '/naɪs tə miːt juː/',
          tip: 'Stress the word "meet" to sound more natural.',
          completed: false,
          audioUrl:
              'https://storage.googleapis.com/katadia-audio/basic-greetings-3.mp3',
        ),
      ],
    ),
    SpeakingLesson(
      title: 'Introducing Yourself',
      level: 'A1',
      sentences: 6,
      xpReward: 60,
      progress: 0.88,
      status: LessonStatus.completed,
      description: 'Share personal details confidently in conversations',
      completedContents: 5,
      totalContents: 6,
    ),
    SpeakingLesson(
      title: 'Ordering Food',
      level: 'A2',
      sentences: 8,
      xpReward: 80,
      progress: 0.0,
      status: LessonStatus.available,
      description: 'Practice useful phrases for cafes and restaurants',
      completedContents: 0,
      totalContents: 8,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        children: [
          SpeakingHeader(
            title: 'Speaking Lessons',
            subtitle: 'Practice pronunciation with AI feedback',
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
                      child: _SpeakingLessonCard(lesson: lesson),
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

class _SpeakingLessonCard extends StatelessWidget {
  final SpeakingLesson lesson;

  const _SpeakingLessonCard({required this.lesson});

  Color _statusColor() {
    switch (lesson.status) {
      case LessonStatus.completed:
        return AppColors.accentGreen;
      case LessonStatus.available:
        return AppColors.primary;
    }
  }

  IconData _statusIcon() {
    switch (lesson.status) {
      case LessonStatus.completed:
        return Icons.check_circle;
      case LessonStatus.available:
        return Icons.mic_none_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressPercent = (lesson.progress * 100).round();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SpeakingLessonDetailPage(lesson: lesson),
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
                              '${lesson.sentences} sentences',
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
              if (lesson.status == LessonStatus.completed)
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
              if (lesson.status == LessonStatus.completed)
                _LessonProgress(progress: lesson.progress)
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
        valueColor: AlwaysStoppedAnimation(AppColors.accentGreen),
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

