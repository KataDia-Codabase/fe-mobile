import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class AnswerOption extends StatelessWidget {
  final String option;
  final bool isSelected;
  final VoidCallback onTap;
  final bool? isCorrect; // null = not answered yet, true = correct, false = incorrect

  const AnswerOption({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
    this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = AppColors.borderLight;
    Color backgroundColor = AppColors.surface;

    if (isCorrect != null) {
      if (isCorrect!) {
        borderColor = AppColors.accentGreen;
        backgroundColor = AppColors.accentGreen.withValues(alpha: 0.05);
      } else if (isSelected && !isCorrect!) {
        borderColor = AppColors.error;
        backgroundColor = AppColors.error.withValues(alpha: 0.05);
      }
    } else if (isSelected) {
      borderColor = AppColors.primary;
      backgroundColor = AppColors.primary.withValues(alpha: 0.05);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? borderColor : AppColors.borderLight,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Container(
                      margin: EdgeInsets.all(AppSpacing.xs),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: borderColor,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Text(
                option,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isSelected ? borderColor : AppColors.textDark,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            if (isCorrect != null) ...[
              SizedBox(width: AppSpacing.md),
              Icon(
                isCorrect! ? Icons.check_circle : Icons.cancel,
                color: isCorrect! ? AppColors.accentGreen : AppColors.error,
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
