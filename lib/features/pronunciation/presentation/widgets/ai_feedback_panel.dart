import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/ai_feedback_provider.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart' as btn;

class AIFeedbackPanel extends StatelessWidget {
  final AIFeedbackState feedbackState;
  final String userId;
  final String sessionId;

  const AIFeedbackPanel({
    super.key,
    required this.feedbackState,
    required this.userId,
    required this.sessionId,
  });

  @override
  Widget build(BuildContext context) {
    if (feedbackState.status == AIFeedbackStatus.loading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Generating personalized feedback...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF757575),
              ),
            ),
          ],
        ),
      );
    }

    if (feedbackState.status == AIFeedbackStatus.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading AI feedback',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              feedbackState.errorMessage ?? 'Unknown error occurred',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            btn.PrimaryButton(
              text: 'Retry',
              onPressed: () {
                // Need to implement retry functionality
              },
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Insights Header
          Text(
            'AI Analysis Insights',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16.w),
          
          // Feedback Cards
          _buildFeedbackCards(),
          
          SizedBox(height: 20.h),
          
          // Recommendations Header
          Text(
            'Personalized Recommendations',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16.w),
          
          // Recommendations List
          _buildRecommendationsList(),
        ],
      ),
    );
  }

  Widget _buildFeedbackCards() {
    final insights = feedbackState.feedback;
    
    return Column(
      children: [
        // Overall Score Feedback
        if (insights.containsKey('overallScore'))
          _buildFeedbackCard(
            'Overall Performance',
            insights['overallScore'],
            Icons.grade,
            _getScoreColor(insights['overallScore']),
          ),
        
        // Strengths
        if (insights.containsKey('strengths'))
          _buildFeedbackCard(
            'Your Strengths',
            insights['strengths'],
            Icons.star,
            AppColors.success,
          ),
        
        // Areas for Improvement
        if (insights.containsKey('improvements'))
          _buildFeedbackCard(
            'Areas to Improve',
            insights['improvements'],
            Icons.trending_up,
            AppColors.warning,
          ),
        
        // Next Steps
        if (insights.containsKey('nextSteps'))
          _buildFeedbackCard(
            'Recommended Next Steps',
            insights['nextSteps'],
            Icons.next_plan,
            AppColors.primary,
          ),
      ],
    );
  }

  Widget _buildFeedbackCard(String title, dynamic content, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Icon(icon, color: color, size: 24.w),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.w),
          Text(
            _formatContent(content),
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsList() {
    final recommendations = feedbackState.recommendations;
    
    if (recommendations.isEmpty) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.grey[400],
              size: 24.w,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Complete more exercises to receive personalized recommendations',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: recommendations.map((recommendation) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.w),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.primary.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  Icons.lightbulb,
                  color: AppColors.primary,
                  size: 20.w,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  recommendation,
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
      }).toList(),
    );
  }

  String _formatContent(dynamic content) {
    if (content is String) return content;
    if (content is List) {
      return content.join('\n• ');
    }
    if (content is Map) {
      return content.entries.map((entry) => '${entry.key}: ${entry.value}').join('\n');
    }
    return content.toString();
  }

  Color _getScoreColor(dynamic score) {
    if (score is num) {
      if (score >= 80) return AppColors.success;
      if (score >= 60) return AppColors.warning;
      if (score >= 40) return AppColors.primary;
      return AppColors.error;
    }
    return AppColors.surface;
  }
}
