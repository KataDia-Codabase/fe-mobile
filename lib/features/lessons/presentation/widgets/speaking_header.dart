import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';

class SpeakingHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBack;

  const SpeakingHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppSpacing.radiusFull),
          bottomRight: Radius.circular(AppSpacing.radiusFull),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xxl,
        paddingTop + AppSpacing.md,
        AppSpacing.xxl,
        AppSpacing.xl,
      ),
      child: Row(
        children: [
          _HeaderButton(icon: Icons.arrow_back, onTap: onBack),
          SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.heading3.copyWith(color: Colors.white),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.15),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.sm),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
