import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class CEFRFeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;

  const CEFRFeatureItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
        ),
        SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
