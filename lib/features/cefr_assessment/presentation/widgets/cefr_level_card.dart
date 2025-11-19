import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class CEFRLevelCard extends StatelessWidget {
  final String level;
  final String title;

  const CEFRLevelCard({
    super.key,
    required this.level,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, Color> levelColors = {
      'A1': const Color(0xFF10B981),
      'A2': const Color(0xFF3B82F6),
      'B1': const Color(0xFF6366F1),
      'B2': const Color(0xFF2F6BFF),
      'C1': const Color(0xFF8B5CF6),
      'C2': const Color(0xFFF59E0B),
    };

    final color = levelColors[level] ?? AppColors.primary;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        boxShadow: AppShadows.light,
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
            ),
            child: Center(
              child: Text(
                level,
                style: AppTextStyles.labelLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: AppSpacing.lg),
          Text(
            title,
            style: AppTextStyles.labelLarge.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
