import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class LeaderboardTabbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const LeaderboardTabbar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              label: 'Global',
              icon: Icons.people,
              isSelected: selectedIndex == 0,
              onTap: () => onTabChange(0),
            ),
          ),
          SizedBox(width: AppSpacing.xs),
          Expanded(
            child: _TabButton(
              label: 'Friends',
              icon: Icons.person_add,
              isSelected: selectedIndex == 1,
              onTap: () => onTabChange(1),
            ),
          ),
        ],
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
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textLight,
              size: 18,
            ),
            SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textLight,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
