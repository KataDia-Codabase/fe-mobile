import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/evaluation_provider.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/spacing.dart';
import '../../domain/models/pronunciation_session.dart';

class PronunciationResultsScreenSimple extends ConsumerStatefulWidget {
  final String sessionId;
  final String? lessonId;
  final VoidCallback? onRetry;
  final VoidCallback? onNextLesson;
  final bool showHistoryTab;

  const PronunciationResultsScreenSimple({
    Key? key,
    required this.sessionId,
    this.lessonId,
    this.onRetry,
    this.onNextLesson,
    this.showHistoryTab = false,
  }) : super(key: key);

  @override
  ConsumerState<PronunciationResultsScreenSimple> createState() => _PronunciationResultsScreenSimpleState();
}

class _PronunciationResultsScreenSimpleState extends ConsumerState<PronunciationResultsScreenSimple>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final AnimationController _scoreAnimationController;
  late final Animation<double> _scoreAnimation;

  @override
  void initState() {
    super.initState();
    
    _tabController = TabController(
      length: widget.showHistoryTab ? 3 : 2,
      vsync: this,
    );
    
    _scoreAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _scoreAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scoreAnimationController,
      curve: Curves.easeOutBack,
    ));

    // Trigger evaluation result load if not already loaded
    final evaluationNotifier = ref.read(evaluationProvider.notifier);
    if (evaluationNotifier.result?.sessionId != widget.sessionId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        evaluationNotifier.startEvaluation(
          audioPath: '', // Will be populated from session
          sessionId: widget.sessionId,
        );
      });
    }

    // Start score animation when evaluation completes
    ref.listen(evaluationProvider, (previous, next) {
      final notifier = ref.read(evaluationProvider.notifier);
      if (notifier.currentState == EvaluationState.completed && 
          notifier.result != null) {
        _scoreAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scoreAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final evaluationNotifier = ref.read(evaluationProvider.notifier);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Pronunciation Results'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (widget.onRetry != null)
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _onRetry,
            ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: _buildBody(evaluationNotifier),
      bottomNavigationBar: _buildBottomActions(evaluationNotifier),
    );
  }

  Widget _buildBody(EvaluationStateNotifier evaluationNotifier) {
    if (evaluationNotifier.currentState == EvaluationState.processing) {
      return _buildProcessingState();
    }

    if (evaluationNotifier.currentState == EvaluationState.error) {
      return _buildErrorState(evaluationNotifier);
    }

    if (evaluationNotifier.currentState == EvaluationState.completed &&
        evaluationNotifier.result != null) {
      return _buildResultsContent(evaluationNotifier.result!);
    }

    return Center(child: Text('No evaluation results available'));
  }

  Widget _buildProcessingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          SizedBox(height: Spacing.spacingLg),
          Text(
            'Analyzing your pronunciation...',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(EvaluationStateNotifier evaluationNotifier) {
    return Padding(
      padding: Spacing.screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48.w,
                  color: AppColors.error,
                ),
                SizedBox(height: Spacing.spacingMd),
                Text(
                  'Evaluation Failed',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.error,
                  ),
                ),
                SizedBox(height: Spacing.spacingSm),
                Text(
                  'There was an error analyzing your pronunciation. Please try again.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: Spacing.spacingXl),
          ElevatedButton.icon(
            onPressed: _onRetry,
            icon: Icon(Icons.refresh),
            label: Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsContent(PronunciationEvaluationResult result) {
    return SingleChildScrollView(
      padding: Spacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overall Score Display
          _buildScoreDisplay(result),
          SizedBox(height: Spacing.spacingXl),

          // Simple feedback display
          Text(
            'Feedback',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: Spacing.spacingMd),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.feedbackMessage,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          if (result.improvementTips.isNotEmpty) ...[
            SizedBox(height: Spacing.spacingXl),
            Text(
              'Improvement Tips',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: Spacing.spacingMd),
            ...result.improvementTips.map((tip) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.amber, size: 20.w),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      tip,
                      style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ],
      ),
    );
  }

  Widget _buildScoreDisplay(PronunciationEvaluationResult result) {
    return AnimatedBuilder(
      animation: _scoreAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scoreAnimation.value,
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
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
                Text(
                  '${(result.overallScore * _scoreAnimation.value).round()}%',
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.bold,
                    color: _getScoreColor(result.overallScore),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  _getScoreMessage(result.overallScore),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomActions(EvaluationStateNotifier evaluationNotifier) {
    if (evaluationNotifier.currentState != EvaluationState.completed ||
        evaluationNotifier.result == null) {
      return SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: widget.onRetry,
                icon: Icon(Icons.refresh),
                label: Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.grey[800],
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: widget.onNextLesson,
                icon: Icon(Icons.arrow_forward),
                label: Text('Next Lesson'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onRetry() {
    final evaluationNotifier = ref.read(evaluationProvider.notifier);
    evaluationNotifier.reset();
    evaluationNotifier.startEvaluation(
      audioPath: '',
      sessionId: widget.sessionId,
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
