import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class BadgeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isUnlocked;

  const BadgeCard({
    super.key,
    required this.title,
    required this.icon,
    this.isUnlocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: isUnlocked
            ? LinearGradient(
                colors: [
                  AppColors.accentYellow,
                  AppColors.accentYellow.withValues(alpha: 0.85),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : LinearGradient(
                colors: [
                  AppColors.bgDisabled,
                  AppColors.bgDisabled.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (isUnlocked)
            BoxShadow(
              color: AppColors.accentYellow.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isUnlocked ? Colors.white : AppColors.textLight,
            size: 40,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.labelSmall.copyWith(
              color: isUnlocked ? Colors.white : AppColors.textLight,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
