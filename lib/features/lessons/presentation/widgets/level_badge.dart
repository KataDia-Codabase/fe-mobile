import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';

class LevelBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const LevelBadge({
    super.key,
    required this.label,
    this.backgroundColor = AppColors.primary,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(color: textColor),
      ),
    );
  }
}
