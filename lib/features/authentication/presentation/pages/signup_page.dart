import 'package:flutter/material.dart';
import 'package:katadia_fe/core/pages/home_page.dart';
import '../../../../../core/theme/index.dart';
import '../../../../../core/services/index.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
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
    final apiService = ApiService();
    final remoteDataSource =
        AuthRemoteDataSourceImpl(apiService: apiService);
    final authRepository =
        AuthRepositoryImpl(remoteDataSource: remoteDataSource);

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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfilePhotoPage(
            name: state.user.name,
            email: state.user.email,
            password: _passwordController.text,
          ),
        ),
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _authBLoC.removeListener(_handleAuthStateChange);
    super.dispose();
  }

  void _signUp() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mohon isi semua field')),
      );
      return;
    }

    _authBLoC.signup(name, email, password);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => HomePage(),
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
                  label: _isLoading ? 'Memproses...' : 'Daftar',
                  onPressed: _isLoading ? () {} : _signUp,
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
