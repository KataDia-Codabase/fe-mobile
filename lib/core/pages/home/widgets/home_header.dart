import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final int notificationCount;
  final VoidCallback? onNotificationTap;

  const HomeHeader({
    super.key,
    required this.userName,
    this.notificationCount = 0,
    this.onNotificationTap,
  });

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo, Selamat Datang! 👋',
                      style:
                          AppTextStyles.bodyMedium.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      userName,
                      style: AppTextStyles.heading3.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              _NotificationButton(
                notificationCount: notificationCount,
                onTap: onNotificationTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  final int notificationCount;
  final VoidCallback? onTap;

  const _NotificationButton({
    required this.notificationCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasNotifications = notificationCount > 0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        onTap: onTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: AppSpacing.containerSmall,
              height: AppSpacing.containerSmall,
              decoration: BoxDecoration(
                color: AppColors.whiteWithAlpha(0.15),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              ),
              child: Icon(
                Icons.notifications_rounded,
                color: Colors.white,
                size: AppSpacing.iconSmall,
              ),
            ),
            if (hasNotifications)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
