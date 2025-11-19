import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final achievements = [
      {'icon': Icons.flag, 'label': 'Milestone'},
      {'icon': Icons.emoji_events, 'label': 'Challenge'},
      {'icon': Icons.grade, 'label': 'Excellence'},
      {'icon': Icons.bolt, 'label': 'Streak'},
      {'icon': Icons.star, 'label': 'Star'},
      {'icon': Icons.trending_up, 'label': 'Progress'},
      {'icon': Icons.shield, 'label': 'Shield'},
      {'icon': Icons.diamond, 'label': 'Diamond'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Achievements',
              style: AppTextStyles.labelLarge,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.accentYellow.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: AppColors.accentYellow.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                '5/8 unlocked',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.accentYellow,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.md),
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.accentYellow.withValues(alpha: 0.15),
                AppColors.accentYellow.withValues(alpha: 0.08),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.accentYellow.withValues(alpha: 0.2),
            ),
          ),
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            children: List.generate(
              achievements.length,
              (index) {
                final achievement = achievements[index];
                final isUnlocked = index < 5;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: isUnlocked
                            ? AppColors.accentYellow
                            : AppColors.bgDisabled,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        achievement['icon'] as IconData,
                        color: isUnlocked ? Colors.white : AppColors.textLight,
                        size: 24,
                      ),
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      achievement['label'] as String,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption.copyWith(
                        color: isUnlocked
                            ? AppColors.textDark
                            : AppColors.textLight,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
