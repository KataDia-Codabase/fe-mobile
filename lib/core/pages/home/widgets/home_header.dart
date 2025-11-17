import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
        MediaQuery.of(context).padding.top + AppSpacing.md,
        AppSpacing.xxl,
        AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Halo, Selamat Datang! 👋',
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
              ),
              Container(
                width: AppSpacing.containerSmall,
                height: AppSpacing.containerSmall,
                decoration: BoxDecoration(
                  color: AppColors.whiteWithAlpha(0.2),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                child: Icon(
                  Icons.notifications_rounded,
                  color: Colors.white,
                  size: AppSpacing.iconSmall,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.xs),
          const Text(
            'Sarah Anderson',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
