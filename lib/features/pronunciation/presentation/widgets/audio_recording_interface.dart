import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/audio_recording_provider.dart';
import 'audio_waveform.dart';

class AudioRecordingInterface extends ConsumerStatefulWidget {
  final VoidCallback? onRecordingComplete;
  final String targetText;
  final bool showTips;

  const AudioRecordingInterface({
    super.key,
    this.onRecordingComplete,
    required this.targetText,
    this.showTips = true,
  });

  @override
  ConsumerState<AudioRecordingInterface> createState() => _AudioRecordingInterfaceState();
}

class _AudioRecordingInterfaceState extends ConsumerState<AudioRecordingInterface>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _pulseController.repeat(reverse: true);

    // Initialize audio recording provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(audioRecordingProvider.notifier).initialize();
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recordingState = ref.watch(audioRecordingProvider);
    final recordingDuration = ref.watch(audioRecordingProvider.notifier).recordingDuration;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Column(
        children: [
          // Target text reminder
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
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
                SizedBox(height: 8.h),
                Text(
                  widget.targetText,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 40.h),

          // Recording waveform visualization
          if (recordingState == AudioRecordingState.recording)
            Container(
              height: 100.h,
              child: AudioWaveform(
                height: 100.h,
                activeColor: Theme.of(context).primaryColor,
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
            ),

          if (recordingState == AudioRecordingState.recording)
            SizedBox(height: 24.h),

          // Recording duration timer
          if (recordingState == AudioRecordingState.recording)
            Text(
              _formatDuration(recordingDuration),
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).primaryColor,
              ),
            ),

          SizedBox(height: 40.h),

          // Recording control button
          _buildRecordingButton(recordingState),

          SizedBox(height: 32.h),

          // Instructions
          _buildInstructions(recordingState),
        ],
      ),
    );
  }

  Widget _buildRecordingButton(AudioRecordingState state) {
    switch (state) {
      case AudioRecordingState.idle:
        return _buildStartButton();
      case AudioRecordingState.askingPermission:
        return _buildPermissionButton();
      case AudioRecordingState.preparing:
        return _buildPreparingButton();
      case AudioRecordingState.recording:
        return _buildRecordingAnimation();
      case AudioRecordingState.paused:
        return _buildPausedButton();
      case AudioRecordingState.processing:
        return _buildProcessingButton();
      case AudioRecordingState.completed:
        return _buildCompletedButton();
      case AudioRecordingState.error:
        return _buildErrorButton();
      case AudioRecordingState.stopped:
        return _buildStoppedButton();
    }
  }

  Widget _buildStartButton() {
    return InkWell(
      onTap: () {
        ref.read(audioRecordingProvider.notifier).startRecording();
      },
      borderRadius: BorderRadius.circular(60.r),
      child: Container(
        width: 120.w,
        height: 120.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(
          Icons.mic,
          size: 48,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPermissionButton() {
    return Container(
      width: 120.w,
      height: 120.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.orange.shade100,
        border: Border.all(
          color: Colors.orange.shade300,
          width: 3.w,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.mic_off,
            size: 32.w,
            color: Colors.orange.shade700,
          ),
          SizedBox(height: 8.h),
          Text(
            'Permission',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.orange.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreparingButton() {
    return Container(
      width: 120.w,
      height: 120.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade100,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 3.w,
        ),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildRecordingAnimation() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: InkWell(
            onTap: () {
              ref.read(audioRecordingProvider.notifier).stopRecording().then((_) {
                widget.onRecordingComplete?.call();
              });
            },
            borderRadius: BorderRadius.circular(60.r),
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.stop,
                size: 48,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPausedButton() {
    return InkWell(
      onTap: () {
        ref.read(audioRecordingProvider.notifier).resumeRecording();
      },
      borderRadius: BorderRadius.circular(60.r),
      child: Container(
        width: 120.w,
        height: 120.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Colors.orange,
              Colors.orange.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(
          Icons.play_arrow,
          size: 48,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildProcessingButton() {
    return Container(
      width: 120.w,
      height: 120.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue.shade100,
        border: Border.all(
          color: Colors.blue.shade300,
          width: 3.w,
        ),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }

  Widget _buildCompletedButton() {
    return InkWell(
      onTap: widget.onRecordingComplete,
      borderRadius: BorderRadius.circular(60.r),
      child: Container(
        width: 120.w,
        height: 120.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Colors.green,
              Colors.green.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(
          Icons.check,
          size: 48,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildErrorButton() {
    return InkWell(
      onTap: () {
        ref.read(audioRecordingProvider.notifier).reset();
      },
      borderRadius: BorderRadius.circular(60.r),
      child: Container(
        width: 120.w,
        height: 120.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.shade100,
          border: Border.all(
            color: Colors.red.shade300,
            width: 3.w,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.refresh,
              size: 32.w,
              color: Colors.red.shade700,
            ),
            SizedBox(height: 4.h),
            Text(
              'Retry',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.red.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoppedButton() {
    return Container(
      width: 120.w,
      height: 120.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade200,
        border: Border.all(
          color: Colors.grey.shade400,
          width: 2.w,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.mic_off,
            size: 32.w,
            color: Colors.grey.shade600,
          ),
          SizedBox(height: 4.h),
          Text(
            'Stopped',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructions(AudioRecordingState state) {
    String instruction;
    Color color;

    switch (state) {
      case AudioRecordingState.idle:
        instruction = 'Tap the microphone button to start recording';
        color = Colors.grey[600]!;
        break;
      case AudioRecordingState.askingPermission:
        instruction = 'Please allow microphone access to continue';
        color = Colors.orange[600]!;
        break;
      case AudioRecordingState.preparing:
        instruction = 'Preparing recorder...';
        color = Colors.grey[600]!;
        break;
      case AudioRecordingState.recording:
        instruction = 'Recording in progress... Tap to stop';
        color = Colors.red[600]!;
        break;
      case AudioRecordingState.paused:
        instruction = 'Recording paused. Tap to resume';
        color = Colors.orange[600]!;
        break;
      case AudioRecordingState.processing:
        instruction = 'Processing your recording...';
        color = Colors.blue[600]!;
        break;
      case AudioRecordingState.completed:
        instruction = 'Recording completed! Continue to see your results';
        color = Colors.green[600]!;
        break;
      case AudioRecordingState.error:
        instruction = 'Recording failed. Tap retry to try again';
        color = Colors.red[600]!;
        break;
      case AudioRecordingState.stopped:
        instruction = 'Recording stopped';
        color = Colors.grey[600]!;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        instruction,
        style: TextStyle(
          fontSize: 14.sp,
          color: color,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    
    return '$minutes:$seconds';
  }
}
