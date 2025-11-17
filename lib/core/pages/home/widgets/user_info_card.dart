import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import 'stat_container.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        boxShadow: AppShadows.medium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: AppSpacing.containerSmall,
                height: AppSpacing.containerSmall,
                decoration: BoxDecoration(
                  color: AppColors.accentYellow,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                child: Center(
                  child: Text(
                    'B1',
                    style: AppTextStyles.badge,
                  ),
                ),
              ),
              SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CEFR Level B1',
                      style: AppTextStyles.bodyLarge,
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      'Intermediate - Independent User',
                      style: AppTextStyles.labelMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              const StatContainer(value: '1,250', label: 'XP'),
              SizedBox(width: AppSpacing.md),
              const StatContainer(value: '7', label: 'Days Streak'),
              SizedBox(width: AppSpacing.md),
              const StatContainer(value: '12', label: 'Lessons'),
            ],
          ),
        ],
      ),
    );
  }
}
