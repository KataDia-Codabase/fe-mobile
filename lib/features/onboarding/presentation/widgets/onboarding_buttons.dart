import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class OnboardingButtons extends StatelessWidget {
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final String nextLabel;

  const OnboardingButtons({
    super.key,
    required this.onSkip,
    required this.onNext,
    this.nextLabel = 'Lanjut',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: AppSpacing.buttonMedium,
          child: ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDark,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
              ),
              elevation: 0,
            ),
            child: Text(
              nextLabel,
              style: AppTextStyles.button,
            ),
          ),
        ),
        SizedBox(height: AppSpacing.lg),
        Center(
          child: TextButton(
            onPressed: onSkip,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.xxl,
                vertical: AppSpacing.md,
              ),
            ),
            child: Text(
              'Lewati',
              style: AppTextStyles.labelLarge.copyWith(color: AppColors.textMedium),
            ),
          ),
        ),
      ],
    );
  }
}
