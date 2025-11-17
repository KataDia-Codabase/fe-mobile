import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class OnboardingContentTwo extends StatefulWidget {
  const OnboardingContentTwo({super.key});

  @override
  State<OnboardingContentTwo> createState() => _OnboardingContentTwoState();
}

class _OnboardingContentTwoState extends State<OnboardingContentTwo>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: AppSpacing.animationSlow + const Duration(milliseconds: 700),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 0.45).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );
    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.xxxl + AppSpacing.xs,
              vertical: AppSpacing.xxl,
            ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusXL + AppSpacing.sm),
            boxShadow: AppShadows.medium,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: AppSpacing.containerLarge + AppSpacing.lg,
                    height: AppSpacing.containerLarge + AppSpacing.lg,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusXL - AppSpacing.sm),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.emoji_events,
                        size: AppSpacing.iconXXL,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -AppSpacing.xs,
                    right: -AppSpacing.xs,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.xl - AppSpacing.sm,
                        vertical: AppSpacing.sm - AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accentYellow,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                        boxShadow: AppShadows.bubble,
                      ),
                      child: Text(
                        'B1',
                        style: AppTextStyles.labelLarge,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.xxxl + AppSpacing.xs),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _AchievementIcon(color: Color(0xFFFFE8B1), icon: Icons.star),
                  SizedBox(width: 16),
                  _AchievementIcon(color: Color(0xFFE4F1FF), icon: Icons.local_fire_department),
                  SizedBox(width: 16),
                  _AchievementIcon(color: Color(0xFFDDF5E2), icon: Icons.emoji_events_outlined),
                ],
              ),
              SizedBox(height: AppSpacing.xxl + AppSpacing.xs),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.xl + AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.bgLight,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Progress',
                      style: AppTextStyles.labelMedium,
                    ),
                    SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('A1', style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary)),
                        Text('C2', style: AppTextStyles.labelMedium),
                      ],
                    ),
                    SizedBox(height: AppSpacing.sm + AppSpacing.xs),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth;
                        return AnimatedBuilder(
                          animation: _progressAnimation,
                          builder: (context, child) {
                            return Stack(
                              children: [
                                Container(
                                  width: width,
                                  height: AppSpacing.sm + AppSpacing.xs,
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                                  ),
                                ),
                                Container(
                                  width: width * _progressAnimation.value,
                                  height: AppSpacing.sm + AppSpacing.xs,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: AppSpacing.md),
                    Text(
                      '+1,240 XP',
                      style: AppTextStyles.statValue.copyWith(
                        color: AppColors.primary,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.xxxl + AppSpacing.xl),
          Text(
            'Your Personalized\nLearning Journey',
            textAlign: TextAlign.center,
            style: AppTextStyles.heading1,
          ),
          SizedBox(height: AppSpacing.lg),
          Text(
            "We'll assess your CEFR level and track your\nprogress with XP, badges, and achievements.\nLevel up as you learn!",
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textMedium),
          ),
          SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _AchievementIcon extends StatelessWidget {
  const _AchievementIcon({required this.color, required this.icon});

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: const Color(0xFF0F172A),
      ),
    );
  }
}
