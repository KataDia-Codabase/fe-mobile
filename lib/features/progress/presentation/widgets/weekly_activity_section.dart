import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class WeeklyActivitySection extends StatelessWidget {
  const WeeklyActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final xpValues = [150.0, 200.0, 180.0, 0.0, 220.0, 200.0, 0.0];
    final maxXP = 220.0;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Weekly Activity',
                style: AppTextStyles.labelLarge,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColors.accentGreen.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  'XP',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.accentGreen,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.xl),
          SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                7,
                (index) {
                  final value = xpValues[index];
                  final height = (value / maxXP) * 160;
                  final isActive = value > 0;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 32,
                        height: height,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.accentGreen
                              : AppColors.bgDisabled,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                        ),
                        child: isActive
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    value.toStringAsFixed(0),
                                    style: AppTextStyles.caption.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              )
                            : null,
                      ),
                      SizedBox(height: AppSpacing.md),
                      Text(
                        days[index],
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textMedium,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.accentGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.accentGreen.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.accentGreen,
                  size: 18,
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Total: 950 XP this week',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.accentGreen,
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
