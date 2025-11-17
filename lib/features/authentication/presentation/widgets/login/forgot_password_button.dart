import 'package:flutter/material.dart';
import '../../../../../../core/theme/index.dart';

class ForgotPasswordButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ForgotPasswordButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Text(
          'Lupa kata sandi?',
          style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}
