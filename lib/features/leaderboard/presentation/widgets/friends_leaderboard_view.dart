import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import 'leaderboard_item.dart';

class FriendsLeaderboardView extends StatelessWidget {
  const FriendsLeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final friendsData = [
      {
        'rank': 1,
        'name': 'Emma Smith',
        'level': 'Leve l 24',
        'streak': '28',
        'xp': 4650,
        'emoji': '👩',
        'isCurrentUser': false,
      },
      {
        'rank': 2,
        'name': 'Michael Brown',
        'level': 'Leve l 16',
        'streak': '15',
        'xp': 2340,
        'emoji': '👨',
        'isCurrentUser': false,
      },
      {
        'rank': 3,
        'name': 'Sarah',
        'level': 'Leve l 12',
        'streak': '6',
        'xp': 1250,
        'emoji': '👩',
        'isCurrentUser': true,
      },
      {
        'rank': 4,
        'name': 'Lisa Anderson',
        'level': 'Leve l 9',
        'streak': '4',
        'xp': 890,
        'emoji': '👱‍♀️',
        'isCurrentUser': false,
      },
      {
        'rank': 5,
        'name': 'Tom Wilson',
        'level': 'Leve l 7',
        'streak': '3',
        'xp': 650,
        'emoji': '🧔',
        'isCurrentUser': false,
      },
    ];

    return Column(
      children: [
        ...List.generate(
          friendsData.length,
          (index) {
            final friend = friendsData[index];
            return LeaderboardItem(
              rank: friend['rank'] as int,
              name: friend['name'] as String,
              level: friend['level'] as String,
              streak: friend['streak'] as String,
              xp: friend['xp'] as int,
              emoji: friend['emoji'] as String,
              isCurrentUser: friend['isCurrentUser'] as bool,
            );
          },
        ),
        SizedBox(height: AppSpacing.lg),
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.tips_and_updates,
                color: AppColors.primary,
                size: 20,
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  'How to Climb',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primary,
                size: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
