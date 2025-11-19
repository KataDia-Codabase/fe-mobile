import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class LeaderboardItem extends StatelessWidget {
  final int rank;
  final String name;
  final String level;
  final String streak;
  final int xp;
  final String emoji;
  final bool isCurrentUser;

  const LeaderboardItem({
    super.key,
    required this.rank,
    required this.name,
    required this.level,
    required this.streak,
    required this.xp,
    required this.emoji,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? AppColors.primary.withValues(alpha: 0.08)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: isCurrentUser
            ? Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
                width: 1,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.bgDisabled,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                rank.toString(),
                style: AppTextStyles.labelSmall.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: AppSpacing.md),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCurrentUser ? AppColors.primary : AppColors.bgDisabled,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: isCurrentUser
                  ? Text(
                      emoji,
                      style: const TextStyle(fontSize: 20),
                    )
                  : Text(
                      emoji,
                      style: const TextStyle(fontSize: 18),
                    ),
            ),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCurrentUser ? 'You ($name)' : name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: isCurrentUser ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.bgDisabled,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        level,
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 9,
                        ),
                      ),
                    ),
                    SizedBox(width: AppSpacing.xs),
                    Text(
                      streak,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.local_fire_department,
                color: AppColors.accentYellow,
                size: 16,
              ),
              SizedBox(width: AppSpacing.xs),
              Text(
                xp.toString(),
                style: AppTextStyles.statValue.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
