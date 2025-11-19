import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class StreakGoalSection extends StatelessWidget {
  const StreakGoalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.local_fire_department,
                      color: AppColors.accentYellow,
                      size: 20,
                    ),
                    Text(
                      'Current Streak',
                      style: AppTextStyles.labelSmall,
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.md),
                Text(
                  '6',
                  style: AppTextStyles.heading1.copyWith(
                    color: AppColors.accentYellow,
                  ),
                ),
                Text(
                  'Days',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.flag,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    Text(
                      'Weekly Goal',
                      style: AppTextStyles.labelSmall,
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.md),
                Text(
                  '5/7',
                  style: AppTextStyles.heading2.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'Days',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
