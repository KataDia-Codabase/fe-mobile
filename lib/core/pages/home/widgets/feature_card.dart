import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final Color backgroundColor;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        boxShadow: AppShadows.light,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppSpacing.containerMedium,
            height: AppSpacing.containerMedium,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLarge - 2),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: AppSpacing.iconXXL,
            ),
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            title,
            style: AppTextStyles.statValue,
          ),
          SizedBox(height: AppSpacing.xs),
          Expanded(
            child: Text(
              subtitle,
              style: AppTextStyles.labelSmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
