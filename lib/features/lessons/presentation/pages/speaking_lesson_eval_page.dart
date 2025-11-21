import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:katadia_fe/core/theme/index.dart';
import 'package:katadia_fe/core/utils/device_utils.dart';
import 'package:katadia_fe/features/lessons/presentation/models/speaking_lesson.dart';
import 'package:katadia_fe/features/lessons/presentation/widgets/index.dart';

class SpeakingLessonEvalPage extends StatelessWidget {
  final SpeakingLesson lesson;
  final LessonContent content;

  const SpeakingLessonEvalPage({
    super.key,
    required this.lesson,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        children: [
          SpeakingHeader(
            title: 'Recording',
            subtitle: lesson.title,
            onBack: () => Navigator.pop(context),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.xxl,
                AppSpacing.xl,
                AppSpacing.xxl,
                AppSpacing.xxxl,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _PromptCard(content: content),
                          SizedBox(height: AppSpacing.xl),
                          const _RecordingTipsCard(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.lg),
                  const _RecorderButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PromptCard extends StatefulWidget {
  final LessonContent content;

  const _PromptCard({required this.content});

  @override
  State<_PromptCard> createState() => _PromptCardState();
}

class _PromptCardState extends State<_PromptCard> {
  late final AudioPlayer _player;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
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

  Future<void> _handleAudioTap() async {
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
    } catch (error) {
      DeviceUtils.showSnackBar(context, 'Gagal memutar audio');
      if (mounted) {
        setState(() => _isPlaying = false);
      }
    }
  }

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
          Row(
            children: [
              Expanded(
                child: Text(
                  'Speak this sentence:',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textMedium,
                  ),
                ),
              ),
              InkWell(
                onTap: _handleAudioTap,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                child: Container(
                  padding: EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: _isPlaying
                        ? AppColors.primary.withValues(alpha: 0.15)
                        : AppColors.bgDisabled,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isPlaying
                        ? Icons.stop_rounded
                        : Icons.volume_up_rounded,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            widget.content.phrase,
            style: AppTextStyles.heading3.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class _RecordingTipsCard extends StatelessWidget {
  static const _tips = [
    'Find a quiet place',
    'Speak clearly and naturally',
    'Maintain normal speaking pace',
    'Pronounce each word carefully',
  ];

  const _RecordingTipsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.accentYellow.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: AppColors.accentYellowDark),
              SizedBox(width: AppSpacing.sm),
              Text(
                'Recording Tips',
                style: AppTextStyles.bodyLarge,
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          ..._tips.map(
            (tip) => Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ', style: AppTextStyles.bodySmall),
                  Expanded(
                    child: Text(
                      tip,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textDark,
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

class _RecorderButton extends StatelessWidget {
  const _RecorderButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
              boxShadow: AppShadows.light,
            ),
            child: Icon(
              Icons.mic_rounded,
              size: AppSpacing.iconXXL,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: AppSpacing.md),
        Text(
          'Tap to start recording',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textMedium,
          ),
        ),
        SizedBox(height: AppSpacing.xxxl),
      ],
    );
  }
}
