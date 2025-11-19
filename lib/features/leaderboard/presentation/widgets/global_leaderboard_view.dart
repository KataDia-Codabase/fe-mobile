import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import 'leaderboard_podium.dart';
import 'leaderboard_item.dart';

class GlobalLeaderboardView extends StatelessWidget {
  const GlobalLeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final leaderboardData = [
      {
        'rank': 4,
        'name': 'Emma Smith',
        'level': 'Leve l 24',
        'streak': '28',
        'xp': 4650,
        'emoji': '🧑',
        'isCurrentUser': false,
      },
      {
        'rank': 5,
        'name': 'Raj Patel',
        'level': 'Leve l 23',
        'streak': '25',
        'xp': 4380,
        'emoji': '👨',
        'isCurrentUser': false,
      },
      {
        'rank': 47,
        'name': 'Sarah',
        'level': 'Leve l 12',
        'streak': '6',
        'xp': 1250,
        'emoji': '👩',
        'isCurrentUser': true,
      },
    ];

    return Column(
      children: [
        const LeaderboardPodium(),
        SizedBox(height: AppSpacing.xl),
        ...List.generate(
          leaderboardData.length,
          (index) {
            final user = leaderboardData[index];
            return LeaderboardItem(
              rank: user['rank'] as int,
              name: user['name'] as String,
              level: user['level'] as String,
              streak: user['streak'] as String,
              xp: user['xp'] as int,
              emoji: user['emoji'] as String,
              isCurrentUser: user['isCurrentUser'] as bool,
            );
          },
        ),
      ],
    );
  }
}
