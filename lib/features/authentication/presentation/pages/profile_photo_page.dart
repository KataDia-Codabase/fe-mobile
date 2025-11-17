import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import '../../../../core/pages/home_page.dart';
import '../widgets/login/auth_button.dart';
import '../widgets/profile_photo/index.dart';

class ProfilePhotoPage extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const ProfilePhotoPage({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  State<ProfilePhotoPage> createState() => _ProfilePhotoPageState();
}

class _ProfilePhotoPageState extends State<ProfilePhotoPage> {
  void _goToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
      (route) => false,
    );
  }

  void _skipProfilePhoto() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppSpacing.xxxl + AppSpacing.xl),
              Text(
                'Lengkapi Profil Anda',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading1,
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                'Tambahkan foto profil untuk melengkapi akun Anda',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textMedium),
              ),
              SizedBox(height: AppSpacing.xxxl + AppSpacing.xl + AppSpacing.lg),
              const ProfilePhotoPlaceholder(),
              const Spacer(),
              AuthButton(
                label: 'Pilih Foto',
                onPressed: () {
                  // TODO: Implement image picker
                  _goToHome();
                },
              ),
              SizedBox(height: AppSpacing.lg),
              AuthButton(
                label: 'Lewati untuk Sekarang',
                onPressed: _skipProfilePhoto,
                isOutlined: true,
                textColor: AppColors.textMedium,
              ),
              SizedBox(height: AppSpacing.xxxl + AppSpacing.xs),
            ],
          ),
        ),
      ),
    );
  }
}
