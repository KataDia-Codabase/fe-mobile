import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:katadia_app/features/authentication/presentation/providers/auth_provider.dart';
import 'package:katadia_app/core/routing/app_router.dart';
import 'package:katadia_app/shared/theme/app_colors.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return WillPopScope(
      onWillPop: () async {
        if (context.canPop()) {
          context.pop();
        } else {
          Navigator.of(context).pop();
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profil Saya'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: authState.maybeWhen(
          authenticated: (user) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary,
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 50.w,
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: Text(
                        user.name.isNotEmpty
                            ? user.name.substring(0, 1).toUpperCase()
                            : '?',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // User Info
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),

                  // Stats Section
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem('Level', '5', Icons.trending_up),
                            Container(
                              height: 40.h,
                              width: 1,
                              color: AppColors.primary.withOpacity(0.3),
                          ),
                          _buildStatItem('XP', '250', Icons.flash_on),
                          Container(
                            height: 40.h,
                            width: 1,
                            color: AppColors.primary.withOpacity(0.3),
                          ),
                          _buildStatItem('Streak', '5 hari', Icons.local_fire_department),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),

                // Profile Menu Items
                _buildMenuSection(
                  title: 'Akun',
                  items: [
                    _MenuItem(
                      title: 'Edit Profil',
                      icon: Icons.edit,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Fitur edit profil segera hadir'),
                          ),
                        );
                      },
                    ),
                    _MenuItem(
                      title: 'Ubah Password',
                      icon: Icons.lock,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Fitur ubah password segera hadir'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                _buildMenuSection(
                  title: 'Pengaturan',
                  items: [
                    _MenuItem(
                      title: 'Notifikasi',
                      icon: Icons.notifications,
                      onTap: () {
                        context.goToSettings();
                      },
                    ),
                    _MenuItem(
                      title: 'Bahasa',
                      icon: Icons.language,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Fitur pengaturan bahasa segera hadir'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 32.h),

                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showLogoutDialog(context, ref);
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        orElse: () => const Center(
          child: Text('User tidak terautentikasi'),
        ),
      ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection({
    required String title,
    required List<_MenuItem> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8.h),
        ...items.map((item) {
          return Card(
            margin: EdgeInsets.only(bottom: 8.h),
            child: ListTile(
              leading: Icon(item.icon, color: AppColors.primary),
              title: Text(item.title),
              trailing: const Icon(Icons.chevron_right),
              onTap: item.onTap,
            ),
          );
        }),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              // Pop the dialog first
              Navigator.pop(context);
              // Then navigate using deferred callback
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  context.goToLogin();
                }
              });
            },
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  _MenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}
