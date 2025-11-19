import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import '../../../../../core/utils/index.dart';
import '../../domain/entities/question_entity.dart';
import 'cefr_results_loading_page.dart';
import '../widgets/index.dart';

class CEFRQuestionPage extends StatefulWidget {
  final List<Question> questions;
  final VoidCallback? onComplete;

  const CEFRQuestionPage({
    super.key,
    required this.questions,
    this.onComplete,
  });

  @override
  State<CEFRQuestionPage> createState() => _CEFRQuestionPageState();
}

class _CEFRQuestionPageState extends State<CEFRQuestionPage> {
  late int _currentQuestionIndex;
  late Map<int, String> _answers; // questionIndex -> selectedAnswer
  late Map<int, bool> _answered; // questionIndex -> isAnswered
  late bool _showResult;

  @override
  void initState() {
    super.initState();
    _currentQuestionIndex = 0;
    _answers = {};
    _answered = {};
    _showResult = false;
  }

  Question get _currentQuestion => widget.questions[_currentQuestionIndex];

  bool get _isLastQuestion => _currentQuestionIndex == widget.questions.length - 1;

  void _selectAnswer(String answer) {
    if (_showResult) return; // Don't allow changing answer after showing result

    setState(() {
      _answers[_currentQuestionIndex] = answer;
      _answered[_currentQuestionIndex] = true;
      _showResult = true;
    });

    Logger.info(
      'Question ${_currentQuestionIndex + 1}: Selected "$answer"',
      tag: 'CEFRQuestion',
    );
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _showResult = false;
      });
    } else {
      _completeAssessment();
    }
  }

  void _completeAssessment() {
    Logger.success('CEFR Assessment completed', tag: 'CEFRQuestion');
    
    // Calculate score
    int correctAnswers = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      if (_answers[i] == widget.questions[i].correctAnswer) {
        correctAnswers++;
      }
    }

    final percentage = (correctAnswers / widget.questions.length * 100).toInt();
    Logger.info('Score: $percentage% ($correctAnswers/${widget.questions.length})', tag: 'CEFRQuestion');
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => CEFRResultsLoadingPage(
          correctAnswers: correctAnswers,
          totalQuestions: widget.questions.length,
          onComplete: widget.onComplete,
        ),
      ),
    );
  }

  void _closeAssessment() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Assessment?'),
        content: const Text('Your progress will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAnswerCorrect = (_answered[_currentQuestionIndex] ?? false)
        ? _answers[_currentQuestionIndex] == _currentQuestion.correctAnswer
        : null;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: QuestionHeader(
                currentQuestion: _currentQuestionIndex + 1,
                totalQuestions: widget.questions.length,
                category: _currentQuestion.category,
                onClose: _closeAssessment,
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSpacing.lg),
                    // Question Card
                    QuestionCard(
                      question: _currentQuestion.question,
                      description: _currentQuestion.description,
                    ),
                    SizedBox(height: AppSpacing.xxl),
                    // Answer Options
                    ..._currentQuestion.options.asMap().entries.map((entry) {
                      final index = entry.key;
                      final option = entry.value;
                      final isSelected =
                          _answers[_currentQuestionIndex] == option;

                      return Column(
                        children: [
                          AnswerOption(
                            option: option,
                            isSelected: isSelected,
                            isCorrect: _showResult && isSelected
                                ? isAnswerCorrect
                                : _showResult &&
                                        option ==
                                            _currentQuestion.correctAnswer
                                    ? true
                                    : null,
                            onTap: () => _selectAnswer(option),
                          ),
                          if (index < _currentQuestion.options.length - 1)
                            SizedBox(height: AppSpacing.md),
                        ],
                      );
                    }),
                    SizedBox(height: AppSpacing.xxxl),
                  ],
                ),
              ),
            ),
            // Bottom Button
            Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  if (_showResult && isAnswerCorrect != null) ...[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.md,
                      ),
                      decoration: BoxDecoration(
                        color: isAnswerCorrect
                            ? AppColors.accentGreen.withValues(alpha: 0.1)
                            : AppColors.error.withValues(alpha: 0.1),
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMedium),
                        border: Border.all(
                          color: isAnswerCorrect
                              ? AppColors.accentGreen
                              : AppColors.error,
                        ),
                      ),
                      child: Text(
                        isAnswerCorrect
                            ? '✓ Correct!'
                            : '✗ Incorrect. The correct answer is: ${_currentQuestion.correctAnswer}',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: isAnswerCorrect
                              ? AppColors.accentGreen
                              : AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: AppSpacing.lg),
                  ],
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed:
                          _answered[_currentQuestionIndex] ?? false
                              ? _nextQuestion
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor:
                            AppColors.borderLight,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusLarge),
                        ),
                        elevation: 0,
                        textStyle: AppTextStyles.button,
                      ),
                      child: Text(
                        _isLastQuestion ? 'Finish Assessment' : 'Continue',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
