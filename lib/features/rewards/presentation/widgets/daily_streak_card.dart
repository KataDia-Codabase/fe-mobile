import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class DailyStreakCard extends StatelessWidget {
  const DailyStreakCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.accentYellow.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.local_fire_department,
                  color: AppColors.accentYellow,
                  size: 24,
                ),
              ),
              SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daily Streak',
                    style: AppTextStyles.labelLarge,
                  ),
                  Text(
                    'Keep learning every day!',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.accentYellow.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_fire_department,
                      color: AppColors.accentYellow,
                      size: 32,
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Text(
                      '6',
                      style: AppTextStyles.heading1.copyWith(
                        color: AppColors.accentYellow,
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Icon(
                      Icons.bolt,
                      color: AppColors.accentYellow,
                      size: 24,
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  'Days',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textMedium,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.accentYellow.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: AppColors.accentYellow,
                  size: 18,
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'You\'re on fire! Don\'t break the streak!',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Color(0xFFD97706),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
