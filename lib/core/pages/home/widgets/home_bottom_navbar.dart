import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';

class HomeBottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const HomeBottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSpacing.radiusXL),
          topRight: Radius.circular(AppSpacing.radiusXL),
        ),
        boxShadow: AppShadows.navbar,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(top: AppSpacing.sm),
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textLight,
            selectedIconTheme: const IconThemeData(size: 30),
            unselectedIconTheme: IconThemeData(size: AppSpacing.iconLarge),
            selectedLabelStyle: AppTextStyles.labelSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textLight,
            ),
            showUnselectedLabels: true,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Friends',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.trending_up),
                label: 'Progress',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.emoji_events),
                label: 'Ranks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
