import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:katadia_app/shared/theme/app_colors.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String? audioUrl;
  final String? title;
  final bool showControls;
  final double? height;
  final VoidCallback? onPlayComplete;

  const AudioPlayerWidget({
    Key? key,
    this.audioUrl,
    this.title,
    this.showControls = true,
    this.height,
    this.onPlayComplete,
  }) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  bool _isLoading = false;
  double _currentPosition = 0.0;
  double _totalDuration = 100.0; // Mock duration
  double _playbackSpeed = 1.0;
  bool _isLooping = false;
  bool _isMuted = false;

  late final AnimationController _waveformController;
  late final Animation<double> _waveformAnimation;

  @override
  void initState() {
    super.initState();
    _waveformController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _waveformAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _waveformController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _waveformController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final containerHeight = widget.height ?? 80.h;

    return Container(
      height: containerHeight,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: widget.showControls
            ? _buildPlayerWithControls()
            : _buildPlayerMinimal(),
      ),
    );
  }

  Widget _buildPlayerWithControls() {
    return Column(
      children: [
        // Title row
        if (widget.title != null)
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.title!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: _toggleLoop,
                icon: Icon(
                  _isLooping ? Icons.repeat_one : Icons.repeat,
                  size: 16.w,
                  color: _isLooping ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        
        // Progress bar and info
        Expanded(
          child: Row(
            children: [
              // Current time
              Text(
                _formatDuration(_currentPosition),
                style: TextStyle(
                  fontSize: 10.sp,
                  color: AppColors.textSecondary,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(width: 8.w),
              
              // Progress bar
              Expanded(
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    final box = context.findRenderObject() as RenderBox?;
                    if (box != null) {
                      final tapPosition = box.globalToLocal(
                        details.globalPosition,
                      );
                      final newPosition = (tapPosition.dx / box.size.width).clamp(0.0, 1.0);
                      _seekTo(newPosition * _totalDuration);
                    }
                  },
                  child: Container(
                    height: 4.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2.r),
                      child: LinearProgressIndicator(
                        value: _totalDuration > 0 ? _currentPosition / _totalDuration : 0.0,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              
              // Total time
              Text(
                _formatDuration(_totalDuration),
                style: TextStyle(
                  fontSize: 10.sp,
                  color: AppColors.textSecondary,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        
        // Controls row
        SizedBox(height: 8.h),
        Row(
          children: [
            // Rewind button
            IconButton(
              onPressed: _isLoading ? null : _rewind,
              icon: Icon(Icons.replay_10, size: 20.w),
              color: AppColors.textSecondary,
            ),
            
            const Spacer(),
            
            // Volume/mute button
            IconButton(
              onPressed: _toggleMute,
              icon: Icon(
                _isMuted ? Icons.volume_off : Icons.volume_up,
                size: 20.w,
              ),
              color: AppColors.textSecondary,
            ),
            
            SizedBox(width: 8.w),
            
            // Play/pause button
            Container(
              width: 48.w,
              height: 48.w,
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
                onPressed: _isLoading ? null : _togglePlayPause,
                icon: Icon(
                  _isLoading
                      ? Icons.hourglass_empty
                      : _isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                  color: Colors.white,
                  size: 24.w,
                ),
              ),
            ),
            
            SizedBox(width: 8.w),
            
            // Speed control
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: DropdownButton<double>(
                value: _playbackSpeed,
                items: [0.5, 0.75, 1.0, 1.25, 1.5, 2.0]
                    .map((speed) => DropdownMenuItem<double>(
                      value: speed,
                      child: Text(
                        '${speed}x',
                        style: TextStyle(fontSize: 10.sp),
                      ),
                    ))
                    .toList(),
                onChanged: (speed) {
                  setState(() {
                    _playbackSpeed = speed ?? 1.0;
                  });
                },
                underline: Container(),
                icon: Icon(Icons.speed, size: 12.w),
                isDense: true,
              ),
            ),
            
            const Spacer(),
            
            // Forward button
            IconButton(
              onPressed: _isLoading ? null : _forward,
              icon: Icon(Icons.forward_30, size: 20.w),
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlayerMinimal() {
    return Row(
      children: [
        // Animated waveform
        Expanded(
          child: _buildWaveform(),
        ),
        SizedBox(width: 16.w),
        
        // Play/pause button
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: _isLoading ? null : _togglePlayPause,
            icon: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 20.w,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWaveform() {
    return Container(
      height: 40.h,
      child: AnimatedBuilder(
        animation: _waveformAnimation,
        builder: (context, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(20, (index) {
              final height = 20.h * _waveformAnimation.value;
              return Container(
                width: 2.w,
                height: height,
                decoration: BoxDecoration(
                  color: _isPlaying
                      ? AppColors.primary
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(1.r),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _pause();
      } else {
        _play();
      }
    });
  }

  void _play() {
    setState(() {
      _isPlaying = true;
      _isLoading = true;
    });
    
    // Start waveform animation
    _waveformController.repeat();
    
    // Simulate audio loading and playing
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = false;
      });
      
      // Simulate playback progress
      _simulatePlayback();
    });
  }

  void _pause() {
    setState(() {
      _isPlaying = false;
      _isLoading = false;
    });
    
    // Stop waveform animation
    _waveformController.stop();
    _waveformController.reset();
  }

  void _rewind() {
    setState(() {
      _currentPosition = (_currentPosition - 10).clamp(0.0, _totalDuration);
    });
  }

  void _forward() {
    setState(() {
      _currentPosition = (_currentPosition + 30).clamp(0.0, _totalDuration);
    });
  }

  void _seekTo(double position) {
    setState(() {
      _currentPosition = position.clamp(0.0, _totalDuration);
    });
  }

  void _toggleLoop() {
    setState(() {
      _isLooping = !_isLooping;
    });
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  void _simulatePlayback() {
    if (!_isPlaying) return;
    
    const step = 0.1; // 100ms intervals
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!_isPlaying) return;
      
      setState(() {
        _currentPosition += step;
        
        if (_currentPosition >= _totalDuration) {
          if (_isLooping) {
            _currentPosition = 0.0;
            _simulatePlayback();
          } else {
            _pause();
            widget.onPlayComplete?.call();
          }
        } else {
          _simulatePlayback();
        }
      });
    });
  }

  String _formatDuration(double seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = (seconds % 60).round();
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

class AudioMiniPlayer extends StatelessWidget {
  final String? audioUrl;
  final String? title;
  final VoidCallback? onTap;

  const AudioMiniPlayer({
    Key? key,
    this.audioUrl,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.borderColor, width: 1),
        ),
        child: Row(
          children: [
            // Play button
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 16.w,
              ),
            ),
            SizedBox(width: 12.w),
            
            // Title/filename
            Expanded(
              child: Text(
                title ?? 'Audio Recording',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            // Duration
            Text(
              '0:30',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textSecondary,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
