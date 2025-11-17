import 'package:flutter/material.dart';
import '../../../../../../core/theme/index.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: AppSpacing.containerSmall,
          height: AppSpacing.containerSmall,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          ),
          child: Icon(
            Icons.public,
            color: Colors.white,
            size: AppSpacing.iconXXL,
          ),
        ),
        SizedBox(height: AppSpacing.xs),
        Text(
          'KataDia',
          style: AppTextStyles.labelLarge,
        ),
        SizedBox(height: AppSpacing.xxxl + AppSpacing.xl),
        Text(
          title,
          style: AppTextStyles.heading1,
        ),
        SizedBox(height: AppSpacing.xs),
        Text(
          subtitle,
          style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textMedium),
        ),
      ],
    );
  }
}
