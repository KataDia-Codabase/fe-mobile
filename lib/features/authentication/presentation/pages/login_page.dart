import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import '../widgets/login/index.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    // TODO: Implement login functionality
  }

  void _signUpNavigation() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SignupPage()),
    );
  }

  void _forgotPasswordNavigation() {
    // TODO: Navigate to forgot password page
  }

  void _googleSignIn() {
    // TODO: Implement Google sign in
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
                AuthHeader(
                  title: 'Selamat Datang Kembali',
                  subtitle: 'Masuk untuk melanjutkan pembelajaran',
                ),
                SizedBox(height: AppSpacing.xxxl + AppSpacing.xs),
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
                SizedBox(height: AppSpacing.md),
                ForgotPasswordButton(
                  onPressed: _forgotPasswordNavigation,
                ),
                SizedBox(height: AppSpacing.xxl),
                AuthButton(
                  label: 'Masuk',
                  onPressed: _signIn,
                ),
                SizedBox(height: AppSpacing.xxl),
                const DividerOr(),
                SizedBox(height: AppSpacing.xxl),
                GoogleSigninButton(
                  onPressed: _googleSignIn,
                ),
                SizedBox(height: AppSpacing.xxl),
                AuthLink(
                  prefix: 'Belum punya akun?',
                  linkText: 'Daftar',
                  onTap: _signUpNavigation,
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
