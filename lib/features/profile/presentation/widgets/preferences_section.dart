import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import 'profile_menu_item.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferences',
          style: AppTextStyles.labelLarge,
        ),
        SizedBox(height: AppSpacing.md),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
            boxShadow: AppShadows.light,
          ),
          child: Column(
            children: [
              ProfileMenuItem(
                icon: Icons.language,
                title: 'Language',
                subtitle: 'English / Indonesian',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Language tapped')),
                  );
                },
              ),
              Divider(color: AppColors.borderLight, height: 1),
              ProfileMenuItem(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle: 'Enabled',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notifications tapped')),
                  );
                },
              ),
              Divider(color: AppColors.borderLight, height: 1),
              ProfileMenuItem(
                icon: Icons.flag_circle_outlined,
                title: 'Daily Goal',
                subtitle: '15 minutes',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Daily Goal tapped')),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
