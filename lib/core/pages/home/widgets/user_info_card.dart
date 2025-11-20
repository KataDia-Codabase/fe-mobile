import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';
import 'package:katadia_fe/core/utils/index.dart';

import 'stat_container.dart';

class UserInfoCard extends StatelessWidget {
  final String cefrBadge;
  final String cefrTitle;
  final String cefrDescription;
  final int totalXp;
  final int lessonsCompleted;
  final int streakDays;

  const UserInfoCard({
    super.key,
    required this.cefrBadge,
    required this.cefrTitle,
    required this.cefrDescription,
    required this.totalXp,
    required this.lessonsCompleted,
    required this.streakDays,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        boxShadow: AppShadows.medium,
        border: Border.all(
          color: AppColors.borderLight,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: AppSpacing.containerMedium,
                height: AppSpacing.containerMedium,
                decoration: BoxDecoration(
                  color: AppColors.accentYellow,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                child: Center(
                  child: Text(
                    cefrBadge,
                    style: AppTextStyles.badge.copyWith(color: AppColors.textDark),
                  ),
                ),
              ),
              SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cefrTitle,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      cefrDescription,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              StatContainer(
                value: StringFormatter.formatNumber(totalXp),
                label: 'XP',
              ),
              SizedBox(width: AppSpacing.md),
              StatContainer(
                value: streakDays.toString(),
                label: 'Days Streak',
              ),
              SizedBox(width: AppSpacing.md),
              StatContainer(
                value: lessonsCompleted.toString(),
                label: 'Lessons',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
