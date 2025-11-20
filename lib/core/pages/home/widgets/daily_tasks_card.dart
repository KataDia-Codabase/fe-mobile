import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';

class DailyTasksCard extends StatelessWidget {
  final int completedTasks;
  final int totalTasks;
  final int xpEarned;
  final IconData leadingIcon;
  final VoidCallback? onTap;

  const DailyTasksCard({
    super.key,
    required this.completedTasks,
    required this.totalTasks,
    required this.xpEarned,
    this.leadingIcon = Icons.local_fire_department,
    this.onTap,
  });

  double get _progressValue {
    if (totalTasks <= 0) {
      return 0;
    }
    return (completedTasks / totalTasks).clamp(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            boxShadow: AppShadows.light,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.accentYellow.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                    ),
                    child: Icon(
                      leadingIcon,
                      color: AppColors.accentYellow,
                      size: AppSpacing.iconMedium,
                    ),
                  ),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daily Tasks',
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                        SizedBox(height: AppSpacing.xs),
                        Text(
                          '$completedTasks/$totalTasks completed',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.textMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.textLight,
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.lg),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                child: LinearProgressIndicator(
                  value: _progressValue,
                  minHeight: AppSpacing.sm,
                  backgroundColor: AppColors.borderLight,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.accentYellow,
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.lg),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentYellow.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                child: Text(
                  '+$xpEarned XP earned today! 🎉',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.accentYellow,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
