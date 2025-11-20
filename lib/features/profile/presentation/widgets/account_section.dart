import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import 'profile_menu_item.dart';

class AccountSection extends StatelessWidget {
  final String userName;
  final String email;

  const AccountSection({
    super.key,
    required this.userName,
    required this.email,
  });

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
                icon: Icons.person_outline,
                title: 'Edit Profile',
                subtitle: userName,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Edit Profile tapped')),
                  );
                },
              ),
              Divider(color: AppColors.borderLight, height: 1),
              ProfileMenuItem(
                icon: Icons.mail_outline,
                title: 'Email',
                subtitle: email,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Email tapped')),
                  );
                },
              ),
              Divider(color: AppColors.borderLight, height: 1),
              ProfileMenuItem(
                icon: Icons.lock_outline,
                title: 'Change Password',
                subtitle: 'Update regularly',
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
