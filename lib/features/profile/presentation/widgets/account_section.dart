import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import 'profile_menu_item.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account',
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
                icon: Icons.person_outline,
                title: 'Edit Profile',
                subtitle: 'Sarah Anderson',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Edit Profile tapped')),
                  );
                },
              ),
              Divider(color: AppColors.borderLight, height: 24),
              ProfileMenuItem(
                icon: Icons.mail_outline,
                title: 'Email',
                subtitle: 'sarah.anderson@email.com',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Email tapped')),
                  );
                },
              ),
              Divider(color: AppColors.borderLight, height: 24),
              ProfileMenuItem(
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Change Password tapped')),
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
