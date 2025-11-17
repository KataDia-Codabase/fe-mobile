import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import '../widgets/index.dart';

class OnboardingContentOne extends StatelessWidget {
  const OnboardingContentOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.xxxl + AppSpacing.xs,
            vertical: AppSpacing.xxxl + AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSpacing.xxxl),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.xxl,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  boxShadow: AppShadows.medium,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LineDot(),
                    SizedBox(height: AppSpacing.md),
                    const LineDot(widthFactor: 0.75, isPrimary: false),
                    SizedBox(height: AppSpacing.md),
                    const LineDot(widthFactor: 0.55, isPrimary: false),
                  ],
                ),
              ),
              Positioned(
                right: -AppSpacing.md,
                top: -AppSpacing.md,
                child: IconBubble(
                  color: AppColors.accentYellow,
                  icon: Icons.volume_up_rounded,
                  iconColor: AppColors.textDark,
                ),
              ),
              Positioned(
                left: -AppSpacing.md,
                bottom: -AppSpacing.md,
                child: IconBubble(
                  color: AppColors.primary,
                  icon: Icons.mic,
                  iconColor: Colors.white,
                  size: AppSpacing.containerLarge - AppSpacing.md,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.xxxl + AppSpacing.xl),
        Text(
          'Master Pronunciation\nwith AI',
          textAlign: TextAlign.center,
          style: AppTextStyles.heading1,
        ),
        SizedBox(height: AppSpacing.lg),
        Text(
          'Get instant feedback on your pronunciation\nusing advanced AI technology. Sound like a\nnative speaker in no time.',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textMedium),
        ),
      ],
    );
  }
}
