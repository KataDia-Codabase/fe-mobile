import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import '../../../../../core/pages/home_page.dart';
import '../../../../../data/datasources/local/auth_local_datasource.dart';
import '../../../../../data/datasources/local/database_service.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../widgets/login/index.dart';
import 'signup_page.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late AuthBLoC _authBLoC;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _initializeAuthBLoC();
    _authBLoC.addListener(_handleAuthStateChange);
  }

  void _initializeAuthBLoC() {
    final databaseService = DatabaseService();
    final localDataSource = AuthLocalDataSourceImpl(databaseService: databaseService);
    final authRepository = AuthRepositoryImpl(localDataSource: localDataSource);

    _authBLoC = AuthBLoC(
      loginUseCase: LoginUseCase(authRepository: authRepository),
      signupUseCase: SignupUseCase(authRepository: authRepository),
    );
  }

  void _handleAuthStateChange(AuthState state) {
    if (state is AuthLoading) {
      setState(() => _isLoading = true);
    } else if (state is AuthSuccess) {
      setState(() => _isLoading = false);
      Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
      (route) => false,
    );
    } else if (state is AuthError) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authBLoC.removeListener(_handleAuthStateChange);
    super.dispose();
  }

  void _signIn() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    _authBLoC.login(email, password);
  }

  void _signUpNavigation() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SignupPage()),
    );
  }

  void _googleSignIn() {
    // TODO: Implement Google sign in - using SQLite for now
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Google Sign In akan diimplementasikan nanti')),
    );
  }

  void _forgotPasswordNavigation() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
    );
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
                  label: _isLoading ? 'Memproses...' : 'Masuk',
                  onPressed: _isLoading ? () {} : _signIn,
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
