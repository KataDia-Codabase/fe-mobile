import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';
import 'package:katadia_fe/core/utils/device_utils.dart';
import 'package:katadia_fe/features/lessons/presentation/models/listening_lesson.dart';
import 'package:katadia_fe/features/lessons/presentation/widgets/index.dart';

class ListeningLessonEvalPage extends StatefulWidget {
  final ListeningLesson lesson;
  final ListeningLessonContent content;

  const ListeningLessonEvalPage({
    super.key,
    required this.lesson,
    required this.content,
  });

  @override
  State<ListeningLessonEvalPage> createState() => _ListeningLessonEvalPageState();
}

class _ListeningLessonEvalPageState extends State<ListeningLessonEvalPage> {
  late final AudioPlayer _player;
  late final List<_QuestionResult?> _results;

  bool _isPlaying = false;
  int? _selectedOption;
  int _currentQuestion = 0;
  bool _submitted = false;
  bool _isCorrect = false;
  bool _showSummary = false;

  static final List<_ListeningQuestion> _questions = [
    _ListeningQuestion(
      prompt: 'What is the speaker asking?',
      options: [
        'About the weather',
        'About your health',
        'About the time',
        'About food',
      ],
      answerIndex: 1,
    ),
    _ListeningQuestion(
      prompt: 'What is the speaker planning to do?',
      options: [
        'Visit a friend',
        'Go shopping',
        'Call family',
        'Take a taxi',
      ],
      answerIndex: 0,
    ),
    _ListeningQuestion(
      prompt: 'Where is the conversation happening?',
      options: [
        'At a cafe',
        'At a hospital',
        'At the airport',
        'At school',
      ],
      answerIndex: 2,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _results = List<_QuestionResult?>.filled(_questions.length, null);
    _player.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() => _isPlaying = false);
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _handlePlayTap() async {
    final audioUrl = widget.content.audioUrl;

    if (audioUrl.isEmpty) {
      DeviceUtils.showSnackBar(context, 'Audio belum tersedia');
      return;
    }

    try {
      if (_isPlaying) {
        await _player.stop();
        setState(() => _isPlaying = false);
        return;
      }

      setState(() => _isPlaying = true);
      await _player.stop();
      await _player.play(UrlSource(audioUrl));
    } catch (_) {
      DeviceUtils.showSnackBar(context, 'Gagal memutar audio');
      if (mounted) {
        setState(() => _isPlaying = false);
      }
    }
  }

  void _handleSelect(int index) {
    if (_submitted || _showSummary) return;
    setState(() => _selectedOption = index);
  }

  void _handleSubmit() {
    if (_selectedOption == null || _submitted || _showSummary) return;
    final question = _questions[_currentQuestion];
    final isCorrect = _selectedOption == question.answerIndex;

    setState(() {
      _submitted = true;
      _isCorrect = isCorrect;
      _results[_currentQuestion] = _QuestionResult(
        prompt: question.prompt,
        options: question.options,
        selectedIndex: _selectedOption!,
        correctIndex: question.answerIndex,
        isCorrect: isCorrect,
      );
    });
  }

  void _handleNext() {
    if (!_submitted) return;

    if (_currentQuestion == _questions.length - 1) {
      setState(() {
        _showSummary = true;
        _submitted = false;
      });
      return;
    }

    setState(() {
      _currentQuestion++;
      _selectedOption = null;
      _submitted = false;
      _isCorrect = false;
    });
  }

  void _restartEvaluation() {
    setState(() {
      for (var i = 0; i < _results.length; i++) {
        _results[i] = null;
      }
      _currentQuestion = 0;
      _selectedOption = null;
      _submitted = false;
      _isCorrect = false;
      _showSummary = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalQuestions = _questions.length;
    final currentQuestion = _questions[_currentQuestion];
    final isLastQuestion = _currentQuestion == totalQuestions - 1;
    final questionLabel = _showSummary
        ? 'Review your answers'
        : 'Question ${_currentQuestion + 1} of $totalQuestions';
    final progress = _showSummary
        ? 1.0
        : (_currentQuestion + 1) / totalQuestions;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        children: [
          SpeakingHeader(
            title: widget.lesson.title,
            subtitle: questionLabel,
            onBack: () => Navigator.pop(context),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.xxl,
              AppSpacing.md,
              AppSpacing.xxl,
              AppSpacing.lg,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.xxl,
                AppSpacing.sm,
                AppSpacing.xxl,
                AppSpacing.xxxl,
              ),
              child: _showSummary
                  ? _SummaryView(
                      results:
                          _results.whereType<_QuestionResult>().toList(growable: false),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _AudioCard(
                          content: widget.content,
                          isPlaying: _isPlaying,
                          onPlayTap: _handlePlayTap,
                        ),
                        SizedBox(height: AppSpacing.xl),
                        _QuestionCard(
                          question: currentQuestion.prompt,
                          options: currentQuestion.options,
                          selectedIndex: _selectedOption,
                          correctIndex: currentQuestion.answerIndex,
                          submitted: _submitted,
                          onOptionTap: _handleSelect,
                        ),
                        if (_submitted) ...[
                          SizedBox(height: AppSpacing.md),
                          _FeedbackCard(
                            isCorrect: _isCorrect,
                            answerText:
                                currentQuestion.options[currentQuestion.answerIndex],
                          ),
                          SizedBox(height: AppSpacing.xxxl),
                        ] else ...[
                          SizedBox(height: AppSpacing.xxxl),
                        ],
                      ],
                    ),
            ),
          ),
          if (!_showSummary)
            Container(
              decoration: BoxDecoration(
                color: AppColors.bgLight,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    offset: const Offset(0, -2),
                    blurRadius: 8,
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(
                AppSpacing.xxl,
                AppSpacing.md,
                AppSpacing.xxl,
                AppSpacing.md,
              ),
              child: SafeArea(
                top: false,
                child: _submitted
                    ? _ActionButtons(
                        onNext: _handleNext,
                        isLastQuestion: isLastQuestion,
                      )
                    : _SubmitButton(
                        enabled: _selectedOption != null,
                        onTap: _handleSubmit,
                      ),
              ),
            ),
          if (_showSummary)
            Container(
              decoration: BoxDecoration(
                color: AppColors.bgLight,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    offset: const Offset(0, -2),
                    blurRadius: 8,
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(
                AppSpacing.xxl,
                AppSpacing.md,
                AppSpacing.xxl,
                AppSpacing.md,
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _restartEvaluation,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSpacing.md,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusLarge),
                          ),
                        ),
                        child: const Text('Retake Lesson'),
                      ),
                    ),
                    SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(
                            vertical: AppSpacing.md,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusLarge),
                          ),
                        ),
                        child: Text(
                          'Done',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
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

class _AudioCard extends StatelessWidget {
  final ListeningLessonContent content;
  final bool isPlaying;
  final VoidCallback onPlayTap;

  const _AudioCard({
    required this.content,
    required this.isPlaying,
    required this.onPlayTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        boxShadow: AppShadows.light,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.volume_up_rounded,
              color: AppColors.primary,
              size: AppSpacing.iconXL,
            ),
          ),
          SizedBox(height: AppSpacing.lg),
          Text(
            'Listen to the audio',
            style: AppTextStyles.bodyLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            'Play the audio and answer the question below',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMedium,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                ),
              ),
              onPressed: onPlayTap,
              icon: Icon(
                isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded,
                color: Colors.white,
              ),
              label: Text(
                isPlaying ? 'Stop Audio' : 'Play Audio',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final String question;
  final List<String> options;
  final int? selectedIndex;
  final int correctIndex;
  final bool submitted;
  final ValueChanged<int> onOptionTap;

  const _QuestionCard({
    required this.question,
    required this.options,
    required this.selectedIndex,
    required this.correctIndex,
    required this.submitted,
    required this.onOptionTap,
  });

  @override
  Widget build(BuildContext context) {
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
          Text(
            question,
            style: AppTextStyles.bodyLarge,
          ),
          SizedBox(height: AppSpacing.md),
          ...List.generate(options.length, (index) {
            final option = options[index];
            final selected = selectedIndex == index;
            final isCorrectOption = submitted && index == correctIndex;
            final isIncorrectSelection =
                submitted && selectedIndex == index && !isCorrectOption;
            return Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.sm),
              child: _AnswerOption(
                label: option,
                selected: selected,
                submitted: submitted,
                isCorrect: isCorrectOption,
                isIncorrect: isIncorrectSelection,
                onTap: () => onOptionTap(index),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onTap;

  const _SubmitButton({required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? onTap : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.bgDisabled,
          padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          ),
        ),
        child: Text(
          'Submit Answer',
          style: AppTextStyles.bodyMedium.copyWith(
            color: enabled ? Colors.white : AppColors.textMedium,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _FeedbackCard extends StatelessWidget {
  final bool isCorrect;
  final String answerText;

  const _FeedbackCard({required this.isCorrect, required this.answerText});

  @override
  Widget build(BuildContext context) {
    final Color accent = isCorrect ? AppColors.accentGreen : AppColors.error;
    final Color bg = accent.withValues(alpha: 0.12);
    final IconData icon = isCorrect ? Icons.check_circle : Icons.cancel;
    final String title = isCorrect ? 'Correct' : 'Incorrect';
    final String subtitle = isCorrect
        ? 'Great job! Keep listening carefully.'
        : 'The correct answer is: $answerText';

    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyLarge.copyWith(color: accent),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textDark,
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

class _ActionButtons extends StatelessWidget {
  final VoidCallback onNext;
  final bool isLastQuestion;

  const _ActionButtons({
    required this.onNext,
    required this.isLastQuestion,
  });

  @override
  Widget build(BuildContext context) {
    final String nextLabel = isLastQuestion ? 'Finish Review' : 'Next Question';

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onNext,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          ),
        ),
        child: Text(
          nextLabel,
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _AnswerOption extends StatelessWidget {
  final String label;
  final bool selected;
  final bool submitted;
  final bool isCorrect;
  final bool isIncorrect;
  final VoidCallback onTap;

  const _AnswerOption({
    required this.label,
    required this.selected,
    required this.submitted,
    required this.isCorrect,
    required this.isIncorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = AppColors.borderLight;
    Color fillColor = AppColors.surface;
    Color indicatorColor = Colors.transparent;
    IconData? trailingIcon;
    Color? trailingColor;

    if (submitted) {
      if (isCorrect) {
        borderColor = AppColors.accentGreen;
        fillColor = AppColors.accentGreen.withValues(alpha: 0.12);
        indicatorColor = AppColors.accentGreen;
        trailingIcon = Icons.check_circle;
        trailingColor = AppColors.accentGreen;
      } else if (isIncorrect) {
        borderColor = AppColors.error;
        fillColor = AppColors.error.withValues(alpha: 0.12);
        indicatorColor = AppColors.error;
        trailingIcon = Icons.cancel;
        trailingColor = AppColors.error;
      }
    } else if (selected) {
      borderColor = AppColors.primary;
      fillColor = AppColors.primary.withValues(alpha: 0.08);
      indicatorColor = AppColors.primary;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: submitted ? null : onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: indicatorColor == Colors.transparent
                        ? borderColor
                        : indicatorColor,
                    width: 2,
                  ),
                  color: indicatorColor == Colors.transparent
                      ? Colors.transparent
                      : indicatorColor,
                ),
                child: indicatorColor == Colors.transparent
                    ? null
                    : const Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.white,
                      ),
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textDark,
                  ),
                ),
              ),
              if (trailingIcon != null) ...[
                SizedBox(width: AppSpacing.sm),
                Icon(trailingIcon, color: trailingColor),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryView extends StatelessWidget {
  final List<_QuestionResult> results;

  const _SummaryView({
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    final correctCount = results.where((r) => r.isCorrect).length;
    final total = results.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
            boxShadow: AppShadows.light,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Summary',
                style: AppTextStyles.heading3.copyWith(fontSize: 20),
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                '$correctCount of $total correct',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textMedium,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.lg),
        ...results.asMap().entries.map(
          (entry) {
            final index = entry.key + 1;
            final result = entry.value;
            return Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.md),
              child: _SummaryCard(index: index, result: result),
            );
          },
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final int index;
  final _QuestionResult result;

  const _SummaryCard({required this.index, required this.result});

  @override
  Widget build(BuildContext context) {
    final Color accent = result.isCorrect ? AppColors.accentGreen : AppColors.error;
    final IconData icon = result.isCorrect ? Icons.check_circle : Icons.cancel;

    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.bgDisabled,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                child: Text('Q$index'),
              ),
              SizedBox(width: AppSpacing.sm),
              Icon(icon, color: accent),
            ],
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            result.prompt,
            style: AppTextStyles.bodyLarge,
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            'Your answer: ${result.options[result.selectedIndex]}',
            style: AppTextStyles.bodySmall,
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            'Correct answer: ${result.options[result.correctIndex]}',
            style: AppTextStyles.bodySmall.copyWith(
              color: accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ListeningQuestion {
  final String prompt;
  final List<String> options;
  final int answerIndex;

  const _ListeningQuestion({
    required this.prompt,
    required this.options,
    required this.answerIndex,
  });
}

class _QuestionResult {
  final String prompt;
  final List<String> options;
  final int selectedIndex;
  final int correctIndex;
  final bool isCorrect;

  const _QuestionResult({
    required this.prompt,
    required this.options,
    required this.selectedIndex,
    required this.correctIndex,
    required this.isCorrect,
  });
}
