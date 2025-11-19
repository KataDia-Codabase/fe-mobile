import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class SkillProgressSection extends StatelessWidget {
  const SkillProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = [
      {'name': 'Speaking', 'progress': 0.85, 'color': AppColors.primary},
      {'name': 'Reading', 'progress': 0.60, 'color': AppColors.accentGreen},
      {'name': 'Listening', 'progress': 0.45, 'color': AppColors.accentPurple},
      {'name': 'Grammar', 'progress': 0.80, 'color': AppColors.accentYellow},
    ];

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
          Text(
            'Skill Progress',
            style: AppTextStyles.labelLarge,
          ),
          SizedBox(height: AppSpacing.lg),
          ...List.generate(
            skills.length,
            (index) {
              final skill = skills[index];
              final progress = (skill['progress'] as double) * 100;

              return Padding(
                padding: EdgeInsets.only(
                  bottom: index < skills.length - 1 ? AppSpacing.lg : 0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          skill['name'] as String,
                          style: AppTextStyles.bodyMedium,
                        ),
                        Text(
                          progress.toStringAsFixed(0),
                          style: AppTextStyles.labelSmall.copyWith(
                            color: skill['color'] as Color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.sm),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: skill['progress'] as double,
                        minHeight: 8,
                        backgroundColor: AppColors.bgDisabled,
                        valueColor: AlwaysStoppedAnimation(
                          skill['color'] as Color,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
