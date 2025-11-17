import 'package:flutter/material.dart';
import '../../../../../../core/theme/index.dart';

class AuthLink extends StatelessWidget {
  final String prefix;
  final String linkText;
  final VoidCallback onTap;

  const AuthLink({
    super.key,
    required this.prefix,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          prefix,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMedium),
        ),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          ),
          child: Text(
            linkText,
            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
