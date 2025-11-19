import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class QuestionHeader extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;
  final String category;
  final VoidCallback onClose;

  const QuestionHeader({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.category,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentQuestion / totalQuestions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top bar with close and info
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: onClose,
              icon: const Icon(Icons.close),
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(AppSpacing.inputHeight, AppSpacing.inputHeight),
              ),
            ),
            Text(
              'Question $currentQuestion/$totalQuestions',
              style: AppTextStyles.labelMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.menu_book,
                    size: 14,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Text(
                    category,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.lg),
        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 4,
            backgroundColor: AppColors.bgLight,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ],
    );
  }
}
