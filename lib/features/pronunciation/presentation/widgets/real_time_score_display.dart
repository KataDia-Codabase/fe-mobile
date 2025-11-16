import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/theme/app_colors.dart';

class RealTimeScoreDisplay extends StatelessWidget {
  final double score;
  final bool isRecording;
  final dynamic status; // RealTimeScoringStatus from provider

  const RealTimeScoreDisplay({
    super.key,
    required this.score,
    required this.isRecording,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Score display
        Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _getScoreColor(),
            border: Border.all(color: _getScoreColor().withOpacity(0.3), width: 4),
            boxShadow: [
              BoxShadow(
                color: _getScoreColor().withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                score.toStringAsFixed(0),
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'SCORE',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: 16.h),
        
        // Status indicator
        _buildStatusIndicator(),
        
        SizedBox(height: 8.h),
        
        // Recording indicator
        if (isRecording)
          _buildRecordingIndicator(),
      ],
    );
  }

  Widget _buildStatusIndicator() {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    // Handle dynamic status value  
    final statusStr = status.toString();
    
    if (statusStr.contains('connected')) {
      statusColor = AppColors.success;
      statusText = 'Connected';
      statusIcon = Icons.check_circle;
    } else if (statusStr.contains('receiving')) {
      statusColor = AppColors.primary;
      statusText = 'Analyzing...';
      statusIcon = Icons.analytics;
    } else if (statusStr.contains('completed')) {
      statusColor = AppColors.success;
      statusText = 'Analysis Complete';
      statusIcon = Icons.verified;
    } else {
      statusColor = AppColors.warning;
      statusText = 'Connecting...';
      statusIcon = Icons.sync;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          statusIcon,
          size: 20.w,
          color: statusColor,
        ),
        SizedBox(width: 8.w),
        Text(
          statusText,
          style: TextStyle(
            fontSize: 14.sp,
            color: statusColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildRecordingIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            color: AppColors.error,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          'Recording...',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.error,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 8.w),
        SizedBox(
          width: 20.w,
          height: 20.w,
          child: CircularProgressIndicator(
            strokeWidth: 2.w,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.error,
            ),
          ),
        ),
      ],
    );
  }

  Color _getScoreColor() {
    if (score >= 80) return AppColors.success;
    if (score >= 60) return AppColors.warning;
    if (score >= 40) return AppColors.primary;
    return AppColors.error;
  }
}
