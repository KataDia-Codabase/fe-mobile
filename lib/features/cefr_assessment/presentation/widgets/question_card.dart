import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final String description;

  const QuestionCard({
    super.key,
    required this.question,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        boxShadow: AppShadows.light,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: AppTextStyles.labelLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: AppSpacing.lg),
          Text(
            description,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textDark,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
