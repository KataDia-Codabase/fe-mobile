import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class CEFRIconBadge extends StatelessWidget {
  const CEFRIconBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background circle
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
        ),
        // Book icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.book_rounded,
            size: 40,
            color: AppColors.primary,
          ),
        ),
        // A-C badge
        Positioned(
          top: -8,
          right: -8,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.accentYellow,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              boxShadow: AppShadows.light,
            ),
            child: Text(
              'A-C',
              style: AppTextStyles.badge.copyWith(
                color: AppColors.textDark,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
