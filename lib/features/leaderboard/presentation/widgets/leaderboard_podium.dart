import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class LeaderboardPodium extends StatelessWidget {
  const LeaderboardPodium({super.key});

  @override
  Widget build(BuildContext context) {
    final users = [
      {
        'rank': 1,
        'name': 'Alex',
        'level': 'B2',
        'xp': 5420,
        'emoji': '🏆',
        'color': AppColors.accentYellow,
      },
      {
        'rank': 2,
        'name': 'Maria',
        'level': '#2',
        'xp': 5180,
        'emoji': '🥈',
        'color': Color(0xFFCCCCCC),
      },
      {
        'rank': 3,
        'name': 'Chen',
        'level': '#3',
        'xp': 4920,
        'emoji': '🥉',
        'color': Color(0xFFCD7F32),
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _PodiumItem(
          user: users[1],
          height: 120,
        ),
        SizedBox(width: AppSpacing.lg),
        _PodiumItem(
          user: users[0],
          height: 160,
        ),
        SizedBox(width: AppSpacing.lg),
        _PodiumItem(
          user: users[2],
          height: 100,
        ),
      ],
    );
  }
}

class _PodiumItem extends StatelessWidget {
  final Map<String, dynamic> user;
  final double height;

  const _PodiumItem({
    required this.user,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: user['color'] as Color,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: (user['color'] as Color).withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              user['emoji'] as String,
              style: const TextStyle(fontSize: 28),
            ),
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        Text(
          user['name'] as String,
          style: AppTextStyles.bodyMedium,
          textAlign: TextAlign.center,
        ),
        Container(
          margin: const EdgeInsets.only(top: AppSpacing.xs),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.bgDisabled,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            user['level'] as String,
            style: AppTextStyles.caption,
          ),
        ),
        SizedBox(height: AppSpacing.md),
        Container(
          width: 60,
          height: height,
          decoration: BoxDecoration(
            color: (user['color'] as Color).withValues(alpha: 0.2),
            border: Border.all(
              color: user['color'] as Color,
              width: 2,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Center(
            child: Text(
              user['xp'].toString(),
              style: AppTextStyles.statValue.copyWith(
                color: user['color'] as Color,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
