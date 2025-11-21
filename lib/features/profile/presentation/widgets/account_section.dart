import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import 'profile_menu_item.dart';
import 'edit_profile_dialog.dart';
import 'edit_email_dialog.dart';
import 'change_password_dialog.dart';

class AccountSection extends StatefulWidget {
  final String userId;
  final String userName;
  final String email;
  final VoidCallback? onProfileUpdated;

  const AccountSection({
    super.key,
    required this.userId,
    required this.userName,
    required this.email,
    this.onProfileUpdated,
  });

  @override
  State<AccountSection> createState() => _AccountSectionState();
}

class _AccountSectionState extends State<AccountSection> {
  late String _displayName;
  late String _displayEmail;
  late String _userId;

  @override
  void initState() {
    super.initState();
    _displayName = widget.userName;
    _displayEmail = widget.email;
    _userId = widget.userId;
  }

  @override
  void didUpdateWidget(AccountSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync display values when parent updates
    _displayName = widget.userName;
    _displayEmail = widget.email;
    _userId = widget.userId;
  }

  void _handleProfileUpdated() {
    widget.onProfileUpdated?.call();
  }

  void _handleEmailUpdated() {
    widget.onProfileUpdated?.call();
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => EditProfileDialog(
        userId: _userId,
        userName: _displayName,
        onProfileUpdated: _handleProfileUpdated,
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => ChangePasswordDialog(
        userEmail: _displayEmail,
      ),
    );
  }

  void _showEditEmailDialog() {
    showDialog(
      context: context,
      builder: (context) => EditEmailDialog(
        userId: _userId,
        currentEmail: _displayEmail,
        onEmailUpdated: _handleEmailUpdated,
      ),
    );
  }

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
                subtitle: _displayName,
                onTap: _showEditProfileDialog,
              ),
              Divider(color: AppColors.borderLight, height: 1),
              ProfileMenuItem(
                icon: Icons.mail_outline,
                title: 'Email',
                subtitle: _displayEmail,
                onTap: _showEditEmailDialog,
              ),
              Divider(color: AppColors.borderLight, height: 1),
              ProfileMenuItem(
                icon: Icons.lock_outline,
                title: 'Change Password',
                subtitle: 'Update regularly',
                onTap: _showChangePasswordDialog,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
