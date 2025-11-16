import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:katadia_app/features/pronunciation/presentation/providers/audio_provider.dart';
import 'package:katadia_app/features/pronunciation/presentation/widgets/audio_waveform.dart';
import 'package:katadia_app/shared/theme/app_colors.dart';
import 'package:katadia_app/shared/theme/app_spacing.dart';

// Extension for playback state helper methods
extension AudioPlaybackStateExtension on AudioPlaybackState {
  bool get isPlaying => this == AudioPlaybackState.playing;
  bool get isPaused => this == AudioPlaybackState.paused;
  bool get isStopped => this == AudioPlaybackState.stopped;
  bool get isLoading => this == AudioPlaybackState.loading;
  bool get isCompleted => this == AudioPlaybackState.completed;
}

// Adapter class to bridge AudioPlayerController and AudioWaveformController
class AudioWaveformAdapter implements AudioWaveformController {
  final AudioPlayerController _controller;

  AudioWaveformAdapter(this._controller);

  @override
  Stream<Duration> get positionStream => _controller.positionStream;

  @override
  Duration? get duration => _controller.duration;

  @override
  Stream<double?> get amplitudeStream => _controller.amplitudeStream;
}

class AudioPlayer extends ConsumerStatefulWidget {
  final String audioUrl;
  final String? title;
  final VoidCallback? onPlaybackComplete;
  final bool showWaveform;
  final bool allowSpeedControl;

  const AudioPlayer({
    super.key,
    required this.audioUrl,
    this.title,
    this.onPlaybackComplete,
    this.showWaveform = true,
    this.allowSpeedControl = true,
  });

  @override
  ConsumerState<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends ConsumerState<AudioPlayer> {
  late final AudioPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = AudioPlayerController();
    _initializeAudio();
  }

  Future<void> _initializeAudio() async {
    try {
      await _controller.initialize();
      await _controller.setUrl(widget.audioUrl);
      
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Failed to initialize audio: $e');
      _handleAudioError(e);
    }
  }

  void _handleAudioError(dynamic error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Audio playback failed: ${error.toString()}'),
        backgroundColor: AppColors.error,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Container(
        padding: AppSpacing.cardPaddingAll,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            if (widget.title != null) ...[
              Text(
                widget.title!,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: AppSpacing.md),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                    strokeWidth: 2.w,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
                SizedBox(width: AppSpacing.md),
                Text(
                  'Loading audio...',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return StreamBuilder<AudioPlaybackState>(
      stream: _controller.playbackStateStream,
      builder: (context, snapshot) {
        final playbackState = snapshot.data ?? AudioPlaybackState.stopped;
        final duration = _controller.duration;
        
        return Container(
          padding: AppSpacing.cardPaddingAll,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and playback status
              if (widget.title != null) ...[
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title!,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: playbackState.isPlaying
                            ? AppColors.primary.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        _getPlaybackStatusText(playbackState),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: playbackState.isPlaying
                              ? AppColors.primary
                              : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.lg),
              ],
              
              // Waveform visualization
              if (widget.showWaveform) ...[
                AudioWaveform(
                  controller: AudioWaveformAdapter(_controller),
                  height: 60.h,
                ),
                SizedBox(height: AppSpacing.lg),
              ],
              
              // Progress indicator
              StreamBuilder<Duration>(
                stream: _controller.positionStream,
                builder: (context, snapshot) {
                  final currentPosition = snapshot.data ?? Duration.zero;
                  final totalDuration = duration ?? Duration.zero;
                  
                  return Column(
                    children: [
                      // Progress bar
                      Container(
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: AppSpacing.sm),
                      
                      // Time indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(currentPosition),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            _formatDuration(totalDuration),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              
              SizedBox(height: AppSpacing.lg),
              
              // Playback controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Rewind button
                  IconButton(
                    onPressed: _controller.canRewind
                        ? () => _controller.seek(
                            Duration(seconds: -10))
                        : null,
                    icon: Icon(
                      Icons.replay_10,
                      size: 24.w,
                    ),
                  ),
                  SizedBox(width: AppSpacing.md),
                  
                  // Play/Pause button
                  Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (playbackState.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      },
                      icon: Icon(
                        playbackState.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 28.w,
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.md),
                  
                  // Fast forward button
                  IconButton(
                    onPressed: _controller.canFastForward
                        ? () => _controller.seek(
                            Duration(seconds: 10))
                        : null,
                    icon: Icon(
                      Icons.forward_10,
                      size: 24.w,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: AppSpacing.md),
              
              // Speed control
              if (widget.allowSpeedControl) ...[
                _buildSpeedControl(),
                SizedBox(height: AppSpacing.sm),
              ],
              
              // Additional controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () => _controller.setLoopMode(
                        _controller.loopMode == LoopMode.one
                            ? LoopMode.off
                            : LoopMode.one),
                    icon: Icon(
                      _controller.loopMode == LoopMode.one
                          ? Icons.repeat_one
                          : Icons.repeat,
                      size: 20.w,
                    ),
                  ),
                  IconButton(
                    onPressed: _controller.toggleShuffleMode,
                    icon: Icon(
                      Icons.shuffle,
                      size: 20.w,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Show volume control or share functionality
                    },
                    icon: Icon(
                      Icons.share,
                      size: 20.w,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSpeedControl() {
    return StreamBuilder<double>(
      stream: _controller.speedStream,
      builder: (context, snapshot) {
        final currentSpeed = snapshot.data ?? 1.0;
        
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.speed,
                size: 16.w,
                color: Colors.grey[600],
              ),
              SizedBox(width: AppSpacing.sm),
              PopupMenuButton<double>(
                initialValue: currentSpeed,
                child: Text(
                  '${currentSpeed}x',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onSelected: (speed) {
                  _controller.setSpeed(speed);
                },
                itemBuilder: (context) => [0.5, 0.75, 1.0, 1.25, 1.5, 2.0]
                    .map((speed) => PopupMenuItem(
                      value: speed,
                      child: Text('${speed}x'),
                    ))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getPlaybackStatusText(AudioPlaybackState state) {
    switch (state) {
      case AudioPlaybackState.playing:
        return 'Playing';
      case AudioPlaybackState.paused:
        return 'Paused';
      case AudioPlaybackState.loading:
        return 'Loading';
      case AudioPlaybackState.stopped:
        return 'Stopped';
      case AudioPlaybackState.completed:
        return 'Completed';
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    
    if (duration.inHours > 0) {
      final twoDigitHours = twoDigits(duration.inHours);
      return '$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds';
    } else {
      return '$twoDigitMinutes:$twoDigitSeconds';
    }
  }
}


