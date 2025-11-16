import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/realtime_scoring_provider.dart';
import '../providers/ai_feedback_provider.dart';
import '../providers/audio_recording_provider.dart';
import '../providers/evaluation_provider.dart';
import '../widgets/real_time_score_display.dart';
import '../widgets/ai_feedback_panel.dart';
import '../../../../shared/theme/app_colors.dart';

class EnhancedPronunciationPracticeScreen extends ConsumerStatefulWidget {
  final String targetText;
  final String? targetAudioUrl;
  final String lessonId;
  final String userId;
  final String? sessionId;

  const EnhancedPronunciationPracticeScreen({
    super.key,
    required this.targetText,
    this.targetAudioUrl,
    required this.lessonId,
    required this.userId,
    this.sessionId,
  });

  @override
  ConsumerState<EnhancedPronunciationPracticeScreen> createState() => _EnhancedPronunciationPracticeScreenState();
}

class _EnhancedPronunciationPracticeScreenState 
    extends ConsumerState<EnhancedPronunciationPracticeScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  
  bool _isRecording = false;
  bool _hasConnected = false;
  String? _currentSessionId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _currentSessionId = widget.sessionId ?? 'session_${DateTime.now().millisecondsSinceEpoch}';
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeRealTimeScoring();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _initializeRealTimeScoring() async {
    try {
      await ref.read(realtimeScoringProvider.notifier).connectRealTimeScoring(_currentSessionId!);
      setState(() {
        _hasConnected = true;
      });
      
      // Get AI feedback
      await ref.read(aiFeedbackProvider.notifier).getPersonalizedFeedback(widget.userId, _currentSessionId!);
    } catch (e) {
      debugPrint('Error initializing real-time scoring: $e');
    }
  }

  Future<void> _startRecordingProcess() async {
    try {
      // Start recording
      await ref.read(audioRecordingProvider.notifier).startRecording();
      
      // Start real-time scoring
      ref.read(realtimeScoringProvider.notifier).startReceiving();
      
      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      _showErrorSnackBar('Failed to start recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      // Stop recording
      final recordingPath = await ref.read(audioRecordingProvider.notifier).stopRecording();
      
      // Stop real-time scoring
      ref.read(realtimeScoringProvider.notifier).stopReceiving();
      
      setState(() {
        _isRecording = false;
      });

      if (recordingPath != null) {
        // Process and upload recording
        await ref.read(evaluationProvider.notifier).startEvaluation(
          audioPath: recordingPath,
          sessionId: _currentSessionId!,
        );
        
        // Get AI feedback after evaluation
        await ref.read(aiFeedbackProvider.notifier).getPersonalizedFeedback(widget.userId, _currentSessionId!);
      }
    } catch (e) {
      _showErrorSnackBar('Failed to stop recording: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        action: SnackBarAction(
          label: 'Retry',
          textColor: Colors.white,
          onPressed: _initializeRealTimeScoring,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final realtimeState = ref.watch(realtimeScoringProvider);
    final aiFeedbackState = ref.watch(aiFeedbackProvider);
    final recordingState = ref.watch(audioRecordingProvider);
    final evaluationState = ref.watch(evaluationProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('AI-Powered Pronunciation Practice'),
        backgroundColor: AppColors.surface,
        elevation: 0,
 leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _onBackPressed,
        ),
        actions: [
          if (widget.targetAudioUrl != null)
            IconButton(
              icon: const Icon(Icons.play_circle_outline),
              onPressed: _playReferenceAudio,
            ),
          if (_hasConnected)
            Icon(
              Icons.wifi,
              color: _hasConnected 
                  ? AppColors.success 
                  : AppColors.warning,
            ),
        ],
      ),
      body: Column(
        children: [
          // Connection status indicator
          if (!_hasConnected)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              margin: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.warning.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: AppColors.warning),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      'Connection to AI scoring service...',
                      style: TextStyle(color: AppColors.warning),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.w,
                      color: AppColors.warning,
                    ),
                  ),
                ],
              ),
            ),
          
          // Real-time score display
          if (_hasConnected)
            Container(
              margin: EdgeInsets.all(12.h),
              padding: EdgeInsets.all(16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: RealTimeScoreDisplay(
                score: realtimeState.score,
                isRecording: realtimeState.isRecording,
                status: realtimeState.status,
              ),
            ),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildPracticeTab(realtimeState, recordingState),
                _buildFeedbackTab(aiFeedbackState),
                _buildHistoryTab(evaluationState),
              ],
            ),
          ),
          
          // Recording controls
          if (!_isRecording)
            _buildRecordingControls()
          else
            _buildRecordingInProgress(),
        ],
      ),
    );
  }

  Widget _buildPracticeTab(dynamic realtimeState, dynamic recordingState) {
    return Column(
      children: [
        // Target text display
        Container(
          margin: EdgeInsets.all(12.h),
          padding: EdgeInsets.all(16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
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
              SizedBox(height: 12.h),
              Text(
                widget.targetText,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  height: 1.5,
                ),
              ),
              if ((realtimeState.feedback as String).isNotEmpty) ...[
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.all(12.h),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star_outline, color: AppColors.success),
                      SizedBox(width: 8.h),
                      Expanded(
                        child: Text(
                          realtimeState.feedback as String,
                          style: TextStyle(color: AppColors.success),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        
        // Target audio reference
        if (widget.targetAudioUrl != null)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.h),
            padding: EdgeInsets.all(16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reference Audio:',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    IconButton(
                      onPressed: _playReferenceAudio,
                      icon: Icon(Icons.play_arrow, color: AppColors.primary),
                    ),
                    SizedBox(width: 8.h),
                    Expanded(
                      child: Text(
                        'Tap to play reference pronunciation',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        
        Spacer(),
        
        // Tips for better pronunciation
        Container(
          margin: EdgeInsets.all(12.h),
          padding: EdgeInsets.all(16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.lightbulb, color: AppColors.primary),
                  SizedBox(width: 8.h),
                  Text(
                    'Tips for Better Pronunciation:',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              ..._buildPronunciationTips(),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPronunciationTips() {
    final tips = [
      'Speak clearly at a normal pace',
      'Find a quiet environment without background noise',
      'Hold your device about 6-8 inches from your mouth',
      'Take a deep breath before speaking',
      'Listen to the reference audio first',
    ];
    
    return tips.map((tip) => Padding(
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
    )).toList();
  }

  Widget _buildFeedbackTab(dynamic aiFeedbackState) {
    return AIFeedbackPanel(
      feedbackState: aiFeedbackState as AIFeedbackState,
      userId: widget.userId,
      sessionId: _currentSessionId!,
    );
  }

  Widget _buildHistoryTab(evaluationState) {
    return Container(
      margin: EdgeInsets.all(12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pronunciation History',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 20.h),
          
          // Need to implement history display
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.history,
                  size: 48.w,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 16.h),
                Text(
                  'Your pronunciation history will appear here',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Complete some pronunciation exercises to see your progress',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingControls() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _startRecordingProcess,
              icon: const Icon(Icons.mic),
              label: const Text('Start Recording'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingInProgress() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Recording indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 16.w,
                height: 16.w,
                decoration: BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 12.h),
              Text(
                'Recording in progress...',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.error,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 20.h),
          
          // Stop recording button
          ElevatedButton.icon(
            onPressed: _stopRecording,
            icon: const Icon(Icons.stop),
            label: const Text('Stop Recording'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              minimumSize: Size(200.w, 50.h),
            ),
          ),
        ],
      ),
    );
  }

  void _playReferenceAudio() {
    // Need to implement audio playback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text('Playing reference audio...')),
    );
  }

  void _onBackPressed() async {
    if (_isRecording) {
      await ref.read(audioRecordingProvider.notifier).cancelRecording();
      ref.read(realtimeScoringProvider.notifier).stopReceiving();
    }
    
    ref.read(realtimeScoringProvider.notifier).reset();
    ref.read(aiFeedbackProvider.notifier).reset();
    
    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
