import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../data/datasources/local/database_service.dart';
import '../../../../../core/services/auth_bloc_provider.dart';
import '../../../../../features/authentication/domain/entities/user_entity.dart';

class EditEmailDialog extends StatefulWidget {
  final String userId;
  final String currentEmail;
  final VoidCallback onEmailUpdated;

  const EditEmailDialog({
    super.key,
    required this.userId,
    required this.currentEmail,
    required this.onEmailUpdated,
  });

  @override
  State<EditEmailDialog> createState() => _EditEmailDialogState();
}

class _EditEmailDialogState extends State<EditEmailDialog> {
  late TextEditingController _emailController;
  bool _isLoading = false;
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.currentEmail);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _saveEmail() async {
    final newEmail = _emailController.text.trim();

    // Validate email format
    final emailError = Validators.validateEmail(newEmail);
    if (emailError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(emailError)),
      );
      return;
    }

    // Check if email actually changed
    if (newEmail == widget.currentEmail) {
      Navigator.pop(context);
      return;
    }

    // Check if email already exists (and it's not the same as current)
    final existingUser = await _databaseService.getUser(newEmail);
    if (existingUser != null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email sudah terdaftar')),
        );
      }
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Get user by current email and update
      final user = await _databaseService.getUserById(widget.userId);
      if (user != null) {
        debugPrint('🔍 Current user found: ${user.email}');
        final updatedUser = user.copyWith(email: newEmail);
        debugPrint('📝 Updating email from ${user.email} to ${updatedUser.email}');
        await _databaseService.updateUser(updatedUser);
        debugPrint('✅ User updated in database successfully');

        // Update AuthBLoC with new user state
        final userEntity = updatedUser.toEntity();
        AuthBLocProvider.instance.updateUser(userEntity);
        debugPrint('✅ AuthBLoC updated with new email: ${userEntity.email}');

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email berhasil diperbarui')),
          );
          Navigator.pop(context);
          
          // Add small delay to allow AuthBLoC listeners to process state change
          await Future.delayed(const Duration(milliseconds: 100));
          
          // Now call onEmailUpdated which will trigger ProfilePage refresh
          widget.onEmailUpdated();
        }
      } else {
        debugPrint('❌ User not found with email: ${widget.currentEmail}');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User tidak ditemukan')),
          );
        }
      }
    } catch (e) {
      debugPrint('❌ Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
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
        'Edit Email',
        style: AppTextStyles.heading3,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Address',
              style: AppTextStyles.labelLarge,
            ),
            SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Masukkan email baru',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
              ),
              enabled: !_isLoading,
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
          onPressed: _isLoading ? null : _saveEmail,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Simpan'),
        ),
      ],
    );
  }
}
