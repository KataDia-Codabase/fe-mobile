import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class DailyTasksCard extends StatelessWidget {
  const DailyTasksCard({super.key});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daily Tasks',
                style: AppTextStyles.statValue,
              ),
              Text(
                '1/4 completed',
                style: AppTextStyles.labelSmall,
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
            child: LinearProgressIndicator(
              value: 0.25,
              minHeight: AppSpacing.md,
              backgroundColor: AppColors.borderLight,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.accentYellow,
              ),
            ),
          ),
          SizedBox(height: AppSpacing.md),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.accentYellow.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '+30 XP earned today!',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(width: AppSpacing.xs),
                const Text('🎉'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
