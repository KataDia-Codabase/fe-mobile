import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class LeaderboardHeader extends StatelessWidget {
  final VoidCallback onBack;
  final int selectedTab;
  final Function(int) onTabChange;

  const LeaderboardHeader({
    super.key,
    required this.onBack,
    required this.selectedTab,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withValues(alpha: 0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: onBack,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Leaderboard',
                        style: AppTextStyles.heading3.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Compete with learners worldwide',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.lg),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _TabButton(
                        label: 'Global',
                        icon: Icons.people,
                        isSelected: selectedTab == 0,
                        onTap: () => onTabChange(0),
                      ),
                    ),
                    Expanded(
                      child: _TabButton(
                        label: 'Friends',
                        icon: Icons.trending_up,
                        isSelected: selectedTab == 1,
                        onTap: () => onTabChange(1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(
                  color: Colors.white,
                  width: 0,
                )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : Colors.white.withValues(alpha: 0.7),
              size: 18,
            ),
            SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: isSelected ? AppColors.primary : Colors.white.withValues(alpha: 0.7),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
