import 'package:flutter/material.dart';
import '../../../../../../core/theme/index.dart';

class AuthButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isOutlined;

  const AuthButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
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
          child: Text(
            label,
            style: AppTextStyles.bodyLarge.copyWith(
              color: textColor ?? AppColors.textDark,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: AppSpacing.containerSmall,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusXL - AppSpacing.sm),
          ),
          elevation: 0,
          textStyle: AppTextStyles.button,
        ),
        child: Text(label),
      ),
    );
  }
}
