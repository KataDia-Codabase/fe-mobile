import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import 'profile_menu_item.dart';

class GeneralSection extends StatelessWidget {
  const GeneralSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'General',
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
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Help & Support tapped')),
                  );
                },
              ),
              Divider(color: AppColors.borderLight, height: 24),
              ProfileMenuItem(
                icon: Icons.info_outline,
                title: 'About Us',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('About Us tapped')),
                  );
                },
              ),
              Divider(color: AppColors.borderLight, height: 24),
              ProfileMenuItem(
                icon: Icons.logout,
                title: 'Logout',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Logged out')),
                            );
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
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
