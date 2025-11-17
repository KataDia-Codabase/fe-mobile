import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import 'feature_card.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fitur Pembelajaran',
          style: AppTextStyles.statValue,
        ),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          children: [
            FeatureCard(
              icon: Icons.menu_book,
              title: 'Lessons',
              subtitle: 'Browse all lessons',
              iconColor: AppColors.primary,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            ),
            FeatureCard(
              icon: Icons.chat_bubble,
              title: 'AI Chat',
              subtitle: 'Practice conversation',
              iconColor: AppColors.accentPurple,
              backgroundColor: AppColors.accentPurple.withValues(alpha: 0.1),
            ),
            FeatureCard(
              icon: Icons.trending_up,
              title: 'Progress',
              subtitle: 'Track learning',
              iconColor: AppColors.accentGreen,
              backgroundColor: AppColors.accentGreen.withValues(alpha: 0.1),
            ),
            FeatureCard(
              icon: Icons.emoji_events,
              title: 'Rewards',
              subtitle: 'XP & badges',
              iconColor: AppColors.accentYellow,
              backgroundColor: AppColors.accentYellow.withValues(alpha: 0.1),
            ),
          ],
        ),
      ],
    );
  }
}
