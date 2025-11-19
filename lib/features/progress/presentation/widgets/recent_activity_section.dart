import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        'xp': '+50',
        'title': 'Completed Speaking Lesson',
        'subtitle': 'Basic Greetings',
        'time': '2 hours ago',
        'icon': Icons.mic,
        'color': AppColors.accentGreen,
      },
      {
        'xp': '+100',
        'title': 'CEFR Assessment',
        'subtitle': 'Achieved B1 Level',
        'time': '1 day ago',
        'icon': Icons.school,
        'color': AppColors.primary,
      },
      {
        'xp': '+35',
        'title': 'AI Chat Session',
        'subtitle': '15 minutes practice',
        'time': '3 days ago',
        'icon': Icons.chat_bubble,
        'color': AppColors.accentPurple,
      },
      {
        'xp': '+75',
        'title': 'Reading Exercise',
        'subtitle': 'Short Story',
        'time': '5 days ago',
        'icon': Icons.book,
        'color': AppColors.accentYellow,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: AppTextStyles.labelLarge,
        ),
        SizedBox(height: AppSpacing.md),
        Container(
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
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            separatorBuilder: (context, index) => Divider(
              color: AppColors.borderLight,
              height: 1,
            ),
            itemBuilder: (context, index) {
              final activity = activities[index];
              return Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: (activity['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        activity['icon'] as IconData,
                        color: activity['color'] as Color,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity['title'] as String,
                            style: AppTextStyles.bodyMedium,
                          ),
                          Text(
                            activity['subtitle'] as String,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textMedium,
                            ),
                          ),
                          Text(
                            activity['time'] as String,
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: (activity['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        activity['xp'] as String,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: activity['color'] as Color,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
