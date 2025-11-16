import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/theme/app_colors.dart';

/// Widget for displaying pronunciation evaluation score
class ScoreDisplayWidget extends StatelessWidget {
  final PronunciationEvaluationResult result;
  final Animation<double> animation;

  const ScoreDisplayWidget({
    Key? key,
    required this.result,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: animation.value,
          child: child,
        );
      },
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'Overall Score',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Text(
                  '${(result.overallScore * animation.value).round()}%',
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.bold,
                    color: _getScoreColor(result.overallScore),
                  ),
                );
              },
            ),
            SizedBox(height: 8.h),
            Text(
              _getScoreMessage(result.overallScore),
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 90) return Colors.green;
    if (score >= 70) return AppColors.primary;
    if (score >= 50) return Colors.orange;
    return Colors.red;
  }

  String _getScoreMessage(double score) {
    if (score >= 90) return 'Excellent pronunciation!';
    if (score >= 70) return 'Good pronunciation!';
    if (score >= 50) return 'Keep practicing!';
    return 'Needs improvement';
  }
}

// Mock class for PronunciationEvaluationResult
class PronunciationEvaluationResult {
  final double overallScore;
  final Map<String, double> categoryScores;
  final List<String> improvementTips;

  const PronunciationEvaluationResult({
    required this.overallScore,
    required this.categoryScores,
    this.improvementTips = const [],
  });
}
