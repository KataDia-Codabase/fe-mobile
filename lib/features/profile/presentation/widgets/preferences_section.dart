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
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
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
              Divider(color: AppColors.borderLight, height: 24),
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
              Divider(color: AppColors.borderLight, height: 24),
              ProfileMenuItem(
                icon: Icons.brightness_6,
                title: 'Theme',
                subtitle: 'Light',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Theme tapped')),
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
