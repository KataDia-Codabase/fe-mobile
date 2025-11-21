import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';
import 'package:katadia_fe/features/lessons/presentation/models/grammar_lesson.dart';
import 'package:katadia_fe/features/lessons/presentation/pages/grammar_lesson_detail_page.dart';
import 'package:katadia_fe/features/lessons/presentation/widgets/index.dart';

class GrammarLessonsPage extends StatelessWidget {
  const GrammarLessonsPage({super.key});

  static final List<GrammarLesson> _lessons = [
    GrammarLesson(
      title: 'Present Simple Tense',
      description: 'Learn basic present tense',
      level: 'A1',
      duration: '10 min',
      questionsCount: 8,
      status: GrammarStatus.completed,
      progress: 1.0,
      setsCount: 4,
      completedSets: 4,
      exerciseSets: const [
        GrammarExerciseSet(
          title: 'Positive Sentences',
          duration: '5 min',
          exercises: 5,
          description: 'Perkuat pola subject + verb untuk menyatakan rutinitas dan fakta.',
          completed: true,
        ),
        GrammarExerciseSet(
          title: 'Negative Sentences',
          duration: '5 min',
          exercises: 5,
          description: 'Latih penggunaan do/does + not agar kalimat tetap gramatikal.',
          completed: true,
        ),
        GrammarExerciseSet(
          title: 'Question Forms',
          duration: '6 min',
          exercises: 6,
          description: 'Susun pertanyaan yes/no dan wh- question dengan urutan kata yang tepat.',
          completed: true,
        ),
        GrammarExerciseSet(
          title: 'Mixed Practice',
          duration: '7 min',
          exercises: 8,
          description: 'Campuran kalimat positif, negatif, dan pertanyaan untuk review akhir.',
          completed: true,
        ),
      ],
      info: const GrammarLessonInfo(
        about: 'Used for habits, facts, and general truths',
        ruleTitle: 'Grammar Rule',
        ruleDescription: 'Form: Subject + Base Verb (+ s/es for third person singular)',
        examples: [
          'I work every day.',
          'She works in a hospital.',
          'They play football on weekends.',
        ],
      ),
      questions: const [
        GrammarQuestion(
          prompt: 'He _____ to school every morning.',
          options: ['go', 'goes', 'going', 'gone'],
          answerIndex: 1,
        ),
        GrammarQuestion(
          prompt: 'We _____ coffee in the evening.',
          options: ['not drink', "doesn't drink", "don't drink", 'aren\'t drinking'],
          answerIndex: 2,
        ),
        GrammarQuestion(
          prompt: '_____ your brother live near here?',
          options: ['Do', 'Does', 'Is', 'Are'],
          answerIndex: 1,
        ),
      ],
    ),
    GrammarLesson(
      title: 'Articles (A, An, The)',
      description: 'Master article usage',
      level: 'A1',
      duration: '12 min',
      questionsCount: 10,
      status: GrammarStatus.completed,
      progress: 1.0,
      setsCount: 4,
      completedSets: 4,
      exerciseSets: const [
        GrammarExerciseSet(
          title: 'Indefinite Articles',
          duration: '5 min',
          exercises: 5,
          description: 'Pilih a/an sesuai bunyi kata benda dalam konteks sederhana.',
          completed: true,
        ),
        GrammarExerciseSet(
          title: 'Definite Article',
          duration: '6 min',
          exercises: 6,
          description: 'Tentukan kapan harus memakai the untuk benda spesifik.',
          completed: true,
        ),
        GrammarExerciseSet(
          title: 'Special Cases',
          duration: '7 min',
          exercises: 8,
          description: 'Tangani pengecualian seperti unique nouns dan proper names.',
          completed: true,
        ),
        GrammarExerciseSet(
          title: 'Mixed Review',
          duration: '8 min',
          exercises: 6,
          description: 'Gabungan soal untuk memastikan konsistensi pilihan artikel.',
          completed: true,
        ),
      ],
      info: const GrammarLessonInfo(
        about: 'Choose the correct article to clarify nouns in sentences.',
        ruleTitle: 'Usage Tips',
        ruleDescription: 'Use "a" before consonant sounds, "an" before vowel sounds, and "the" for specific nouns.',
        examples: [
          'I saw a dog in the park.',
          'She wants an orange.',
          'Please close the door.',
        ],
      ),
      questions: const [
        GrammarQuestion(
          prompt: 'I bought ____ umbrella because it was raining.',
          options: ['a', 'an', 'the', 'no article'],
          answerIndex: 1,
        ),
        GrammarQuestion(
          prompt: 'Can you pass me ____ salt?',
          options: ['a', 'an', 'the', 'no article'],
          answerIndex: 2,
        ),
        GrammarQuestion(
          prompt: 'She adopted ____ cat from the shelter.',
          options: ['a', 'an', 'the', 'no article'],
          answerIndex: 0,
        ),
      ],
    ),
    GrammarLesson(
      title: 'Past Simple Tense',
      description: 'Regular and irregular verbs',
      level: 'A2',
      duration: '15 min',
      questionsCount: 10,
      status: GrammarStatus.inProgress,
      progress: 0.35,
      setsCount: 4,
      completedSets: 1,
      exerciseSets: const [
        GrammarExerciseSet(
          title: 'Regular Verbs',
          duration: '6 min',
          exercises: 6,
          description: 'Latih akhiran -ed dan ejaan khusus untuk verb beraturan.',
          completed: true,
        ),
        GrammarExerciseSet(
          title: 'Irregular Verbs',
          duration: '7 min',
          exercises: 7,
          description: 'Cocokkan bentuk lampau tidak beraturan melalui konteks cerita.',
          completed: false,
        ),
        GrammarExerciseSet(
          title: 'Questions & Negatives',
          duration: '6 min',
          exercises: 6,
          description: 'Susun kalimat tanya dan negatif dengan did + base verb.',
          completed: false,
        ),
        GrammarExerciseSet(
          title: 'Story Practice',
          duration: '8 min',
          exercises: 8,
          description: 'Isi bagian cerita pendek menggunakan bentuk past simple yang tepat.',
          completed: false,
        ),
      ],
      info: const GrammarLessonInfo(
        about: 'Describe completed actions in the past with clear timelines.',
        ruleTitle: 'Grammar Rule',
        ruleDescription: 'Regular verbs use -ed; irregular verbs have unique past forms.',
        examples: [
          'We visited Bali last year.',
          'She wrote a long letter.',
          'They did not watch TV yesterday.',
        ],
      ),
      questions: const [
        GrammarQuestion(
          prompt: 'They _____ dinner at 7 p.m. yesterday.',
          options: ['eat', 'ate', 'eaten', 'eating'],
          answerIndex: 1,
        ),
        GrammarQuestion(
          prompt: 'I _____ to the mall last weekend.',
          options: ['go', 'goes', 'went', 'gone'],
          answerIndex: 2,
        ),
        GrammarQuestion(
          prompt: 'We _____ not see the movie.',
          options: ['did', "didn't", 'do', "don't"],
          answerIndex: 1,
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
            title: 'Grammar Lessons',
            subtitle: 'Practice grammar topics with guided drills',
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
              itemCount: _lessons.length,
              itemBuilder: (context, index) {
                final lesson = _lessons[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.lg),
                  child: _GrammarLessonCard(lesson: lesson),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _GrammarLessonCard extends StatelessWidget {
  final GrammarLesson lesson;

  const _GrammarLessonCard({required this.lesson});

  Color _statusColor() {
    switch (lesson.status) {
      case GrammarStatus.completed:
        return AppColors.accentGreen;
      case GrammarStatus.inProgress:
        return AppColors.primary;
      case GrammarStatus.available:
        return AppColors.accentPurple;
    }
  }

  IconData _statusIcon() {
    switch (lesson.status) {
      case GrammarStatus.completed:
        return Icons.check_circle;
      case GrammarStatus.inProgress:
        return Icons.auto_fix_high_rounded;
      case GrammarStatus.available:
        return Icons.menu_book_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailMeta = '${lesson.duration}   ·   ${lesson.questionsCount} questions';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => GrammarLessonDetailPage(lesson: lesson),
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
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: _statusColor().withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                ),
                child: Icon(_statusIcon(), color: _statusColor()),
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            lesson.title,
                            style: AppTextStyles.heading3.copyWith(fontSize: 18),
                          ),
                        ),
                        LevelBadge(label: lesson.level),
                      ],
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      lesson.description,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),
                    SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: AppColors.textMedium, size: 16),
                        SizedBox(width: AppSpacing.xs),
                        Text(
                          detailMeta,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
