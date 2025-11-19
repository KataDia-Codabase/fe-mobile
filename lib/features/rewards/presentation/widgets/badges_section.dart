import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import 'badge_card.dart';

class BadgesSection extends StatelessWidget {
  const BadgesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Badges',
              style: AppTextStyles.labelLarge,
            ),
            Text(
              '4/8 unlocked',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.md),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: 0.85,
          children: [
            BadgeCard(
              title: 'First Steps',
              icon: Icons.flag,
              isUnlocked: true,
            ),
            BadgeCard(
              title: 'Week Warrior',
              icon: Icons.calendar_month,
              isUnlocked: true,
            ),
            BadgeCard(
              title: 'Chat Master',
              icon: Icons.chat_bubble,
              isUnlocked: true,
            ),
            BadgeCard(
              title: 'Quiz Expert',
              icon: Icons.quiz,
              isUnlocked: true,
            ),
            BadgeCard(
              title: 'Hundred Days',
              icon: Icons.trending_up,
              isUnlocked: false,
            ),
            BadgeCard(
              title: 'Polyglot',
              icon: Icons.language,
              isUnlocked: false,
            ),
            BadgeCard(
              title: 'Test Champion',
              icon: Icons.school,
              isUnlocked: false,
            ),
            BadgeCard(
              title: 'Streak Legend',
              icon: Icons.star,
              isUnlocked: false,
            ),
          ],
        ),
      ],
    );
  }
}
