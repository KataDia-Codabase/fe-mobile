import 'package:flutter/material.dart';
import '../../../../../../core/theme/index.dart';
import 'google_logo.dart';

class GoogleSigninButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSigninButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.containerSmall,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: AppColors.borderLight,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusXL - AppSpacing.sm),
          ),
          backgroundColor: AppColors.surface,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const GoogleLogo(),
            SizedBox(width: AppSpacing.md),
            Text(
              'Lanjutkan dengan Google',
              style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textDark),
            ),
          ],
        ),
      ),
    );
  }
}
