import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class LineDot extends StatelessWidget {
  final double widthFactor;
  final bool isPrimary;

  const LineDot({
    super.key,
    this.widthFactor = 1,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppSpacing.md,
          height: AppSpacing.md,
          decoration: BoxDecoration(
            color: isPrimary ? AppColors.primary : AppColors.primary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: widthFactor.clamp(0.0, 1.0),
              child: Container(
                height: AppSpacing.sm + AppSpacing.xs,
                decoration: BoxDecoration(
                  color: AppColors.bgLight,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
