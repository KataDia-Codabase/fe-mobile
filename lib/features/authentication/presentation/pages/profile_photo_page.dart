import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/theme/index.dart';
import '../../../../../core/utils/index.dart';
import '../../../../../core/pages/home_page.dart';
import '../../../../../data/datasources/local/database_service.dart';
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
  late ImagePicker _imagePicker;
  final DatabaseService _databaseService = DatabaseService();
  File? _selectedImage;
  bool _isLoading = false;
  bool _isSkipping = false;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  void _goToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
      (route) => false,
    );
  }

  Future<void> _skipProfilePhoto() async {
    setState(() => _isSkipping = true);
    
    Logger.info('Skipping profile photo setup', tag: 'ProfilePhoto');
    
    // Simulate process
    await Future.delayed(const Duration(seconds: 1));
    await _saveProfilePhoto(null);
    
    if (mounted) {
      _goToHome();
    }
  }

  Future<void> _handlePickImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        setState(() => _selectedImage = File(pickedFile.path));
        Logger.success('Image selected: ${pickedFile.name}', tag: 'ProfilePhoto');

        // Simulate upload
        setState(() => _isLoading = true);
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Foto profil berhasil di-upload')),
            );
            _saveProfilePhoto(_selectedImage?.path).then((_) => _goToHome());
          }
        });
      }
    } catch (e) {
      Logger.error('Failed to pick image', tag: 'ProfilePhoto', error: e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memilih foto')),
        );
      }
    }
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
              _selectedImage != null
                  ? ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusLarge),
                      child: Image.file(
                        _selectedImage!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const ProfilePhotoPlaceholder(),
              const Spacer(),
              AuthButton(
                label: _isLoading ? 'Mengunggah...' : 'Pilih Foto',
                onPressed: _isLoading ? () {} : _handlePickImage,
              ),
              SizedBox(height: AppSpacing.lg),
              AuthButton(
                label: _isSkipping ? 'Memproses...' : 'Lewati untuk Sekarang',
                onPressed: _isSkipping ? () {} : _skipProfilePhoto,
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

  Future<void> _saveProfilePhoto(String? path) async {
    try {
      final user = await _databaseService.getUser(widget.email);
      if (user == null) {
        Logger.warning('User not found for profile photo update', tag: 'ProfilePhoto');
        return;
      }

      final updatedUser = user.copyWith(avatar: path);
      await _databaseService.updateUser(updatedUser);
      Logger.success('Profile photo saved to database', tag: 'ProfilePhoto');
    } catch (e) {
      Logger.error('Failed to save profile photo', tag: 'ProfilePhoto', error: e);
    }
  }
}
