import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import '../../../../../core/utils/index.dart';
import '../../../../../data/datasources/local/database_service.dart';

class ChangePasswordDialog extends StatefulWidget {
  final String userEmail;

  const ChangePasswordDialog({
    super.key,
    required this.userEmail,
  });

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;
  bool _isLoading = false;
  bool _showOldPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    final oldPassword = _oldPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Validation
    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      _showErrorSnackBar('Semua field harus diisi');
      return;
    }

    final passwordError = Validators.validatePassword(newPassword);
    if (passwordError != null) {
      _showErrorSnackBar(passwordError);
      return;
    }

    if (newPassword != confirmPassword) {
      _showErrorSnackBar('Password baru tidak cocok');
      return;
    }

    if (oldPassword == newPassword) {
      _showErrorSnackBar('Password baru harus berbeda dengan password lama');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Get user and verify old password
      final user = await _databaseService.getUser(widget.userEmail);
      if (user == null) {
        _showErrorSnackBar('User tidak ditemukan');
        return;
      }

      // Verify old password
      if (user.password != oldPassword) {
        _showErrorSnackBar('Password lama tidak sesuai');
        return;
      }

      // Update password
      final updatedUser = user.copyWith(password: newPassword);
      await _databaseService.updateUser(updatedUser);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password berhasil diubah')),
        );
      }
    } catch (e) {
      _showErrorSnackBar('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      ),
      title: Text(
        'Ubah Password',
        style: AppTextStyles.heading3,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPasswordField(
              label: 'Password Lama',
              controller: _oldPasswordController,
              showPassword: _showOldPassword,
              onToggle: () => setState(() => _showOldPassword = !_showOldPassword),
            ),
            SizedBox(height: AppSpacing.lg),
            _buildPasswordField(
              label: 'Password Baru',
              controller: _newPasswordController,
              showPassword: _showNewPassword,
              onToggle: () => setState(() => _showNewPassword = !_showNewPassword),
            ),
            SizedBox(height: AppSpacing.lg),
            _buildPasswordField(
              label: 'Konfirmasi Password',
              controller: _confirmPasswordController,
              showPassword: _showConfirmPassword,
              onToggle: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _changePassword,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Ubah Password'),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool showPassword,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelLarge,
        ),
        SizedBox(height: AppSpacing.sm),
        TextField(
          controller: controller,
          obscureText: !showPassword,
          decoration: InputDecoration(
            hintText: 'Masukkan $label',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            ),
            suffixIcon: IconButton(
              icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
              onPressed: onToggle,
            ),
          ),
          enabled: !_isLoading,
        ),
      ],
    );
  }
}
