import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widget for analyzing phoneme errors
class PhonemeErrorAnalysisWidget extends StatelessWidget {
  final PronunciationEvaluationResult result;

  const PhonemeErrorAnalysisWidget({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phoneme Analysis',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12.h),
          if (result.phonemeErrors.isEmpty)
            Text(
              'No significant pronunciation errors detected!',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            )
          else
            ...result.phonemeErrors.map((error) => _buildErrorTile(error)),
        ],
      ),
    );
  }

  Widget _buildErrorTile(PhonemeError error) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: _getErrorColor(error.severity).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: _getErrorColor(error.severity).withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              _getErrorIcon(error.severity),
              color: _getErrorColor(error.severity),
              size: 20.w,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    error.targetPhoneme,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '${error.actualPhoneme} → ${error.targetPhoneme}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              error.word,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getErrorColor(double severity) {
    if (severity >= 0.7) return Colors.red;
    if (severity >= 0.3) return Colors.orange;
    return Colors.green;
  }

  IconData _getErrorIcon(double severity) {
    if (severity >= 0.7) return Icons.error;
    if (severity >= 0.3) return Icons.warning;
    return Icons.check_circle;
  }
}

// Mock classes for demonstration
class PronunciationEvaluationResult {
  final double overallScore;
  final List<PhonemeError> phonemeErrors;

  const PronunciationEvaluationResult({
    required this.overallScore,
    required this.phonemeErrors,
  });
}

class PhonemeError {
  final String targetPhoneme;
  final String actualPhoneme;
  final String word;
  final double severity;

  const PhonemeError({
    required this.targetPhoneme,
    required this.actualPhoneme,
    required this.word,
    required this.severity,
  });
}
