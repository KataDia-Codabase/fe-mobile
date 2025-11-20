import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';

class ChatHeader extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback? onInfo;

  const ChatHeader({
    super.key,
    required this.onBack,
    this.onInfo,
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
          _HeaderIconButton(
            icon: Icons.arrow_back,
            onTap: onBack,
          ),
          SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chat AI',
                  style: AppTextStyles.heading3.copyWith(color: Colors.white),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  'Practice conversations anytime',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
          _HeaderIconButton(
            icon: Icons.info_outline,
            onTap: onInfo,
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _HeaderIconButton({
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.15),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.sm),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
