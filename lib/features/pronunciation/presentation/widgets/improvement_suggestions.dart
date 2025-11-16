import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widget for displaying improvement suggestions
class ImprovementSuggestionsWidget extends StatelessWidget {
  final PronunciationEvaluationResult result;

  const ImprovementSuggestionsWidget({
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
            'Improvement Suggestions',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12.h),
          if (result.improvementTips.isEmpty)
            Text(
              'Keep up the good work! No specific suggestions at this time.',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            )
          else
            ...result.improvementTips.map((tip) => _buildSuggestionTile(tip)),
        ],
      ),
    );
  }

  Widget _buildSuggestionTile(String suggestion) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb_outline,
            color: Colors.amber,
            size: 20.w,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              suggestion,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Mock class for PronunciationEvaluationResult
class PronunciationEvaluationResult {
  final double overallScore;
  final List<String> improvementTips;

  const PronunciationEvaluationResult({
    required this.overallScore,
    this.improvementTips = const [],
  });
}
