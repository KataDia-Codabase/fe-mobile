import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';

import 'cefr_results_processing_page.dart';

class CEFRAssessmentPage extends StatefulWidget {
  const CEFRAssessmentPage({super.key});

  @override
  State<CEFRAssessmentPage> createState() => _CEFRAssessmentPageState();
}

class _CEFRAssessmentPageState extends State<CEFRAssessmentPage> {
  int _currentSectionIndex = 0;
  int _currentQuestionIndex = 0;
  int? _selectedAnswer;

  final List<_Section> _sections = const [
    _Section(
      icon: Icons.text_fields_rounded,
      title: 'Grammar',
      color: AppColors.primary,
      description: 'Testing your understanding of English grammar rules and structures.',
      questions: [
        _Question(
          prompt: 'Choose the correct form:\nShe _____ in London for five years.',
          answers: ['lives', 'has lived', 'is living', 'lived'],
          correctIndex: 1,
        ),
      ],
    ),
    _Section(
      icon: Icons.hearing_rounded,
      title: 'Listening',
      color: AppColors.accentPurple,
      description: 'Evaluating your ability to understand spoken English.',
      questions: [
        _Question(
          prompt: 'Listen to the audio and select what you hear:\n"The meeting starts at 9 AM tomorrow."',
          answers: ['9 AM tomorrow', '9 PM tomorrow', '8 AM tomorrow', '10 AM tomorrow'],
          correctIndex: 0,
          showAudioButton: true,
        ),
      ],
    ),
    _Section(
      icon: Icons.mic_none_rounded,
      title: 'Speaking',
      color: AppColors.accentGreen,
      description: 'Record yourself reading the sentence aloud. Speak clearly and at a natural pace.',
      questions: [
        _Question(
          prompt: 'Please read the following sentence aloud clearly:\nHello, how are you today?',
          answers: [],
          correctIndex: 0,
          showMicButton: true,
        ),
      ],
    ),
    _Section(
      icon: Icons.menu_book_rounded,
      title: 'Reading',
      color: AppColors.accentYellow,
      description: 'Measuring your reading comprehension and vocabulary skills.',
      questions: [
        _Question(
          prompt: 'Read the sentence:\n"The project was a piece of cake."\nThis means:',
          answers: [
            'The project was very easy',
            'The project involved baking',
            'The project was delicious',
            'The project was incomplete'
          ],
          correctIndex: 0,
        ),
      ],
    ),
  ];

  double get _progress => (_currentQuestionIndex + 1) /
      _sections.fold<int>(0, (total, section) => total + section.questions.length);

  _Section get _currentSection => _sections[_currentSectionIndex];
  _Question get _currentQuestion => _currentSection.questions[_currentQuestionIndex];

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _currentSection.questions.length - 1) {
        _currentQuestionIndex++;
      } else if (_currentSectionIndex < _sections.length - 1) {
        _currentSectionIndex++;
        _currentQuestionIndex = 0;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const CEFRAssessmentProcessingPage(),
          ),
        );
      }
      _selectedAnswer = null;
    });
  }

  void _handleAnswer(int index) {
    setState(() => _selectedAnswer = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        children: [
          _AssessmentHeader(
            section: _currentSection,
            questionIndex: _currentQuestionIndex,
            totalQuestions: _sections.fold(0, (sum, s) => sum + s.questions.length),
            onClose: () => Navigator.pop(context),
            progress: _progress,
            sections: _sections,
            currentSectionIndex: _currentSectionIndex,
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
                children: [
                  _QuestionCard(
                    section: _currentSection,
                    question: _currentQuestion,
                    selectedAnswer: _selectedAnswer,
                    onAnswerSelected: _handleAnswer,
                  ),
                  SizedBox(height: AppSpacing.xxl),
                  _SectionInfoCard(section: _currentSection),
                ],
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.xxl,
                0,
                AppSpacing.xxl,
                AppSpacing.xxl,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedAnswer != null || _currentQuestion.showMicButton || _currentQuestion.showAudioButton
                      ? _nextQuestion
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.bgDisabled,
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                    ),
                  ),
                  child: Text(
                    'Next Question',
                    style: AppTextStyles.button,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AssessmentHeader extends StatelessWidget {
  final _Section section;
  final int questionIndex;
  final int totalQuestions;
  final VoidCallback onClose;
  final double progress;
  final List<_Section> sections;
  final int currentSectionIndex;

  const _AssessmentHeader({
    required this.section,
    required this.questionIndex,
    required this.totalQuestions,
    required this.onClose,
    required this.progress,
    required this.sections,
    required this.currentSectionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xxl,
        MediaQuery.of(context).padding.top + AppSpacing.lg,
        AppSpacing.xxl,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: AppShadows.light,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppSpacing.radiusXL),
          bottomRight: Radius.circular(AppSpacing.radiusXL),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconCircle(color: section.color, icon: section.icon),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.title,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      'Question ${questionIndex + 1} of $totalQuestions',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Overall Progress',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMedium,
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.borderLight,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(sections.length, (index) {
              final s = sections[index];
              final isActive = index == currentSectionIndex;
              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: isActive
                        ? s.color.withValues(alpha: 0.15)
                        : AppColors.bgLight,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        s.icon,
                        size: 18,
                        color: isActive ? s.color : AppColors.textLight,
                      ),
                      SizedBox(height: AppSpacing.xs),
                      Text(
                        '${s.questions.length}/4',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: isActive ? s.color : AppColors.textLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final _Section section;
  final _Question question;
  final int? selectedAnswer;
  final ValueChanged<int> onAnswerSelected;

  const _QuestionCard({
    required this.section,
    required this.question,
    required this.selectedAnswer,
    required this.onAnswerSelected,
  });

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
          if (question.showAudioButton)
            Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.lg),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: section.color,
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.lg),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Audio playback coming soon.')),
                  );
                },
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Play Audio'),
              ),
            ),
          Text(
            question.prompt,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: AppSpacing.xl),
          if (question.showMicButton)
            Center(
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: section.color.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.mic_rounded, color: section.color, size: 36),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Recording... (simulation)')),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: AppSpacing.md),
                  Text(
                    'Tap the microphone to start recording',
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMedium),
                  ),
                ],
              ),
            ),
          if (question.answers.isNotEmpty)
            ...question.answers.asMap().entries.map((entry) {
              final index = entry.key;
              final answer = entry.value;
              final isSelected = selectedAnswer == index;
              return Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.md),
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                  onTap: () => onAnswerSelected(index),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                      border: Border.all(
                        color: isSelected ? section.color : AppColors.borderLight,
                        width: isSelected ? 2 : 1,
                      ),
                      color: isSelected
                          ? section.color.withValues(alpha: 0.08)
                          : AppColors.surface,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? section.color : AppColors.borderLight,
                              width: 2,
                            ),
                            color: Colors.white,
                          ),
                          child: isSelected
                              ? Center(
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: section.color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            answer,
                            style: AppTextStyles.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}

class _SectionInfoCard extends StatelessWidget {
  final _Section section;

  const _SectionInfoCard({required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: section.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconCircle(color: section.color, icon: section.icon),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${section.title} Section',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: section.color,
                  ),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  section.description,
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

class _IconCircle extends StatelessWidget {
  final Color color;
  final IconData icon;

  const _IconCircle({required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color),
    );
  }
}

class _Section {
  final IconData icon;
  final String title;
  final Color color;
  final String description;
  final List<_Question> questions;

  const _Section({
    required this.icon,
    required this.title,
    required this.color,
    required this.description,
    required this.questions,
  });
}

class _Question {
  final String prompt;
  final List<String> answers;
  final int correctIndex;
  final bool showAudioButton;
  final bool showMicButton;

  const _Question({
    required this.prompt,
    required this.answers,
    required this.correctIndex,
    this.showAudioButton = false,
    this.showMicButton = false,
  });
}
