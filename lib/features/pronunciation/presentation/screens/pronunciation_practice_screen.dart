import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/evaluation_provider.dart';
import '../providers/audio_recording_provider.dart';
import '../widgets/audio_recording_interface.dart';
import '../widgets/progress_indicator.dart' as pronunciation_widgets;
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/spacing.dart';
import '../../../../shared/widgets/app_button.dart' as btn;

enum PronunciationStep {
  preparation,
  recording,
  uploading,
  processing,
  completed,
  error,
}

class PronunciationPracticeScreen extends ConsumerStatefulWidget {
  final String targetText;
  final String? targetAudioUrl;
  final String lessonId;
  final String? sessionId;

  const PronunciationPracticeScreen({
    super.key,
    required this.targetText,
    this.targetAudioUrl,
    required this.lessonId,
    this.sessionId,
  });

  @override
  ConsumerState<PronunciationPracticeScreen> createState() => _PronunciationPracticeScreenState();
}

// Map between different PronunciationStep enums
pronunciation_widgets.PronunciationStep _mapToWidgetStep(PronunciationStep step) {
  switch (step) {
    case PronunciationStep.preparation:
      return pronunciation_widgets.PronunciationStep.preparation;
    case PronunciationStep.recording:
      return pronunciation_widgets.PronunciationStep.recording;
    case PronunciationStep.uploading:
      return pronunciation_widgets.PronunciationStep.uploading;
    case PronunciationStep.processing:
      return pronunciation_widgets.PronunciationStep.processing;
    case PronunciationStep.completed:
      return pronunciation_widgets.PronunciationStep.completed;
    case PronunciationStep.error:
      return pronunciation_widgets.PronunciationStep.error;
  }
}

class _PronunciationPracticeScreenState extends ConsumerState<PronunciationPracticeScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final AnimationController _countdownController;
  late final Animation<double> _countdownAnimation;

  PronunciationStep _currentStep = PronunciationStep.preparation;
  bool _showCountdown = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _countdownController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _countdownAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _countdownController,
      curve: Curves.easeInOut,
    ));

    _countdownController.addStatusListener(_onCountdownComplete);
  }

  void _onCountdownComplete(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _showCountdown = false;
        _currentStep = PronunciationStep.recording;
      });
      ref.read(audioRecordingProvider.notifier).startRecording();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _countdownController.dispose();
    
    // Properly clean up the audio recorder using provider
    if (_currentStep == PronunciationStep.recording) {
      ref.read(audioRecordingProvider.notifier).cancelRecording();
    }
    
    super.dispose();
  }

  void _startRecordingProcess() {
    setState(() {
      _showCountdown = true;
    });
    _countdownController.reset();
    _countdownController.forward();
  }

  void _stopRecording() async {
    setState(() {
      _currentStep = PronunciationStep.preparation;
    });

    final recordingPath = await ref.read(audioRecordingProvider.notifier).stopRecording();

    if (recordingPath != null) {
      _uploadAndProcessRecording(recordingPath);
    }
  }

  void _uploadAndProcessRecording(String recordingPath) async {
    setState(() {
      _currentStep = PronunciationStep.uploading;
    });

    try {
      // Simulate upload and evaluation - TODO: Replace with actual implementation
      await ref.read(evaluationProvider.notifier).startEvaluation(
        audioPath: recordingPath,
        sessionId: widget.sessionId ?? 'session_${DateTime.now().millisecondsSinceEpoch}',
      );
      
      setState(() {
        _currentStep = PronunciationStep.completed;
      });
    } catch (e) {
      setState(() {
        _currentStep = PronunciationStep.error;
      });
    }
  }

  void _retryRecording() {
    setState(() {
      _currentStep = PronunciationStep.preparation;
    });
    ref.read(evaluationProvider.notifier).reset();
  }

  void _goToNextLesson() {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final recordingState = ref.watch(audioRecordingProvider);
    final evaluationState = ref.watch(evaluationProvider);

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        
        // Clean up any ongoing recording
        if (_currentStep == PronunciationStep.recording || 
            _currentStep == PronunciationStep.preparation) {
          try {
            await ref.read(audioRecordingProvider.notifier).cancelRecording();
          } catch (e) {
            // Handle disposal errors gracefully
            print('Error canceling recording: $e');
          }
        }
        
        // Reset evaluation state if needed
        try {
          ref.read(evaluationProvider.notifier).reset();
        } catch (e) {
          // Handle state reset errors gracefully
          print('Error resetting evaluation state: $e');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pronunciation Practice'),
          backgroundColor: AppColors.surface,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              // Clean up any ongoing recording
              if (_currentStep == PronunciationStep.recording || 
                  _currentStep == PronunciationStep.preparation) {
                try {
                  await ref.read(audioRecordingProvider.notifier).cancelRecording();
                } catch (e) {
                  // Handle disposal errors gracefully
                  print('Error canceling recording: $e');
                }
              }
              
              // Reset evaluation state if needed
              try {
                ref.read(evaluationProvider.notifier).reset();
              } catch (e) {
                // Handle state reset errors gracefully
                print('Error resetting evaluation state: $e');
              }
              
              // Navigate back
              if (mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              // Progress indicator
              pronunciation_widgets.PronunciationProgressIndicator(
                currentStep: _mapToWidgetStep(_currentStep),
                totalSteps: 5,
              ),
              SizedBox(height: Spacing.spacingLg),

              // Main content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildPracticeTab(recordingState, evaluationState),
                    _buildReferenceTab(),
                  ],
                ),
              ),

              // Action buttons
              if (_currentStep != PronunciationStep.completed)
                _buildBottomActionButtons(recordingState),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildPracticeTab(
    AudioRecordingState recordingState,
    EvaluationState evaluationState,
  ) {
    switch (_currentStep) {
      case PronunciationStep.preparation:
        return _buildPreparationStep();
      case PronunciationStep.recording:
        return _buildRecordingStep(recordingState);
      case PronunciationStep.uploading:
        return _buildUploadingStep();
      case PronunciationStep.processing:
        return _buildProcessingStep();
      case PronunciationStep.completed:
        return _buildCompletedStep(evaluationState);
      case PronunciationStep.error:
        return _buildErrorStep(evaluationState);
    }
  }

  Widget _buildPreparationStep() {
    return Padding(
      padding: Spacing.screenPadding,
      child: Column(
        children: [
          // Target text display
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Practice saying:',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: Spacing.spacingSm),
                Text(
                  widget.targetText,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Spacing.spacingXl),

          // Recording tips
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: AppColors.primary,
                      size: 20.w,
                    ),
                    SizedBox(width: Spacing.spacingSm),
                    Text(
                      'Tips for best results:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Spacing.spacingSm),
                ..._buildRecordingTips(),
              ],
            ),
          ),

          const Spacer(),

          // Start recording button
          btn.PrimaryButton(
            text: 'Start Recording',
            onPressed: _startRecordingProcess,
            icon: Icons.mic,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRecordingTips() {
    return [
      _buildTipItem('Speak clearly and at a normal pace'),
      _buildTipItem('Find a quiet environment'),
      _buildTipItem('Hold your device about 6-8 inches away'),
      _buildTipItem('Take a deep breath before speaking'),
    ];
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6.h, right: 12.w),
            width: 4.w,
            height: 4.w,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingStep(AudioRecordingState recordingState) {
    return Column(
      children: [
        if (_showCountdown) _buildCountdownOverlay(),
        Expanded(
          child: AudioRecordingInterface(
            onRecordingComplete: _stopRecording,
            targetText: widget.targetText,
          ),
        ),
      ],
    );
  }

  Widget _buildCountdownOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.8),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _countdownAnimation,
                builder: (context, child) {
                  return Container(
                    width: 150.w,
                    height: 150.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary,
                        width: 4.w,
                      ),
                    ),
                    child: CircularProgressIndicator(
                      value: _countdownAnimation.value,
                      strokeWidth: 4.w,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  );
                },
              ),
              TweenAnimationBuilder<int>(
                duration: const Duration(seconds: 3),
                tween: IntTween(begin: 3, end: 1),
                onEnd: () {
                  if (mounted) {
                    // Countdown complete
                  }
                },
                builder: (context, value, child) {
                  return Text(
                    value > 0 ? value.toString() : 'GO!',
                    style: TextStyle(
                      fontSize: 48.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadingStep() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Uploading your recording...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingStep() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Analyzing your pronunciation...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'This usually takes a few seconds',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedStep(EvaluationState evaluationState) {
    return Container(
      padding: Spacing.screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            size: 48.w,
            color: AppColors.success,
          ),
          SizedBox(height: Spacing.spacingMd),
          Text(
            'Pronunciation completed!',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: Spacing.spacingMd),
          ElevatedButton(
            onPressed: _goToNextLesson,
            child: const Text('Next Lesson'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorStep(EvaluationState evaluationState) {
    return Padding(
      padding: Spacing.screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48.w,
                  color: AppColors.error,
                ),
                SizedBox(height: Spacing.spacingMd),
                Text(
                  'Something went wrong',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.error,
                  ),
                ),
                SizedBox(height: Spacing.spacingSm),
                Text(
                  'Please check your internet connection and try again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Spacing.spacingXl),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _retryRecording,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Try Again'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReferenceTab() {
    return Padding(
      padding: Spacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reference Material',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: Spacing.spacingLg),
          
          // Target text explanation
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Target phrase:',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: Spacing.spacingSm),
                Text(
                  widget.targetText,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: Spacing.spacingMd),
                // Need to add phonetic transcription
                Text(
                  '[Phonetic transcription]',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionButtons(AudioRecordingState recordingState) {
    if (_currentStep == PronunciationStep.recording) {
      return Container(
        padding: Spacing.screenPadding,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ref.read(audioRecordingProvider.notifier).cancelRecording();
                  setState(() {
                    _currentStep = PronunciationStep.preparation;
                  });
                },
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: recordingState == AudioRecordingState.recording ? _stopRecording : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Stop Recording'),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildBottomNavigationBar() {
    return TabBar(
      controller: _tabController,
      labelColor: AppColors.primary,
      unselectedLabelColor: Colors.grey,
      indicatorColor: AppColors.primary,
      tabs: const [
        Tab(
          icon: Icon(Icons.mic),
          text: 'Practice',
        ),
        Tab(
          icon: Icon(Icons.menu_book),
          text: 'Reference',
        ),
      ],
    );
  }
}
