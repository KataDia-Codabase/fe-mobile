import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widget for audio playback controls
class AudioPlaybackWidget extends StatelessWidget {
  final String? audioPath;
  final VoidCallback? onReplay;

  const AudioPlaybackWidget({
    Key? key,
    this.audioPath,
    this.onReplay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Text(
            'Recording Playback',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.play_circle_outline,
                size: 32.w,
                color: Colors.blue,
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.stop_circle_outlined,
                size: 32.w,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          if (onReplay != null)
            TextButton.icon(
              onPressed: onReplay,
              icon: Icon(Icons.replay, size: 16.w),
              label: Text(
                'Replay Recording',
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
        ],
      ),
    );
  }
}
