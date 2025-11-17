import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import '../widgets/login/index.dart';
import 'profile_photo_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mohon isi semua field')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfilePhotoPage(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        ),
      ),
    );
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
                  title: 'Buat Akun Baru',
                  subtitle: 'Daftar untuk memulai pembelajaran',
                ),
                SizedBox(height: AppSpacing.xxxl + AppSpacing.xs),
                AuthTextField(
                  label: 'Nama Lengkap',
                  hintText: 'Masukkan nama lengkap',
                  prefixIcon: Icons.person_outline,
                  controller: _nameController,
                ),
                SizedBox(height: AppSpacing.xxl),
                AuthTextField(
                  label: 'Email',
                  hintText: 'nama@email.com',
                  prefixIcon: Icons.mail_outline,
                  controller: _emailController,
                ),
                SizedBox(height: AppSpacing.xxl),
                AuthTextField(
                  label: 'Kata Sandi',
                  hintText: '••••••••',
                  prefixIcon: Icons.lock_outline,
                  controller: _passwordController,
                  isPassword: true,
                ),
                SizedBox(height: AppSpacing.xxxl + AppSpacing.xs),
                AuthButton(
                  label: 'Daftar',
                  onPressed: _signUp,
                ),
                SizedBox(height: AppSpacing.xxl),
                AuthLink(
                  prefix: 'Sudah punya akun?',
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
