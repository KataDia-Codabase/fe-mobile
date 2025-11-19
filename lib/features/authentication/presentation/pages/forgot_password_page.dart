import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import '../widgets/login/index.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetEmail() {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mohon masukkan email Anda')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate sending reset email
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email reset password telah dikirim')),
        );

        // Return to login after delay
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.pop(context);
          }
        });
      }
    });
  }

  void _backToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSpacing.xxl),
                const AuthHeader(
                  title: 'Lupa Kata Sandi?',
                  subtitle: 'Masukkan email untuk reset kata sandi Anda',
                ),
                SizedBox(height: AppSpacing.xxxl + AppSpacing.xs),
                AuthTextField(
                  label: 'Email',
                  hintText: 'nama@email.com',
                  prefixIcon: Icons.mail_outline,
                  controller: _emailController,
                ),
                SizedBox(height: AppSpacing.xxxl + AppSpacing.xs),
                AuthButton(
                  label: _isLoading ? 'Mengirim...' : 'Kirim Email Reset',
                  onPressed: _isLoading ? () {} : _sendResetEmail,
                ),
                SizedBox(height: AppSpacing.xxl),
                AuthLink(
                  prefix: 'Kembali ke',
                  linkText: 'Masuk',
                  onTap: _backToLogin,
                ),
                SizedBox(height: AppSpacing.xxxl + AppSpacing.xs),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
