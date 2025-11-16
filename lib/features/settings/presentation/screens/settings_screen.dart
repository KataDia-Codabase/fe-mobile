import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:katadia_app/features/settings/providers/theme_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;

  @override
  Widget build(BuildContext context) {
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
          title: const Text('Pengaturan'),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Notifications Section
                _buildSectionTitle('Notifikasi'),
                _buildSwitchTile(
                  title: 'Aktifkan Notifikasi',
                  subtitle: 'Terima notifikasi tentang pelajaran dan achievement',
                  value: _notificationsEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          value
                              ? 'Notifikasi diaktifkan'
                              : 'Notifikasi dinonaktifkan',
                        ),
                      ),
                    );
                  },
                ),
                Divider(height: 16.h),

                // Sound & Vibration
                _buildSectionTitle('Suara & Getaran'),
                _buildSwitchTile(
                  title: 'Suara',
                  subtitle: 'Putar suara untuk interaksi',
                  value: _soundEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _soundEnabled = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'Getaran',
                  subtitle: 'Berikan umpan balik haptic',
                  value: true,
                  onChanged: (value) {},
                ),
                Divider(height: 16.h),

                // Display Settings
                _buildSectionTitle('Tampilan'),
                _buildSwitchTile(
                  title: 'Mode Gelap',
                  subtitle: 'Gunakan tema gelap',
                  value: ref.watch(themeProvider) == ThemeMode.dark,
                  onChanged: (bool value) async {
                    final newThemeMode = value ? ThemeMode.dark : ThemeMode.light;
                    await ref.read(themeProvider.notifier).setThemeMode(newThemeMode);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            value
                                ? 'Mode gelap diaktifkan'
                                : 'Mode terang diaktifkan',
                          ),
                        ),
                      );
                    }
                  },
                ),
                _buildSelectableTile(
                  title: 'Ukuran Font',
                  value: 'Normal',
                  onTap: () {
                    _showFontSizeDialog();
                  },
                ),
                Divider(height: 16.h),

                // Learning Settings
                _buildSectionTitle('Pembelajaran'),
                _buildSelectableTile(
                  title: 'Tingkat Kesulitan',
                  value: 'Menengah',
                  onTap: () {
                    _showDifficultyDialog();
                  },
                ),
                _buildSelectableTile(
                  title: 'Jumlah Soal Per Sesi',
                  value: '10',
                  onTap: () {
                    _showQuestionCountDialog();
                  },
                ),
                Divider(height: 16.h),

                // About Section
                _buildSectionTitle('Tentang'),
                _buildSelectableTile(
                  title: 'Versi Aplikasi',
                  value: '1.0.0',
                  onTap: () {},
                ),
                _buildSelectableTile(
                  title: 'Kebijakan Privasi',
                  value: '',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Kebijakan privasi dapat dilihat online'),
                      ),
                    );
                  },
                ),
                _buildSelectableTile(
                  title: 'Persyaratan Layanan',
                  value: '',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Persyaratan layanan dapat dilihat online'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12.sp),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.blue,
    );
  }

  Widget _buildSelectableTile({
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value.isNotEmpty)
            Text(
              value,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12.sp,
              ),
            ),
          SizedBox(width: 8.w),
          Icon(Icons.chevron_right, color: Colors.grey[400]),
        ],
      ),
      onTap: onTap,
    );
  }

  void _showFontSizeDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ukuran Font'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['Kecil', 'Normal', 'Besar', 'Sangat Besar']
              .map(
                (size) => RadioListTile<String>(
                  title: Text(size),
                  value: size,
                  groupValue: 'Normal',
                  onChanged: (value) {
                    Navigator.pop(dialogContext);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Ukuran font diubah ke $value')),
                        );
                      }
                    });
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _showDifficultyDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Tingkat Kesulitan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['Mudah', 'Menengah', 'Sulit']
              .map(
                (difficulty) => RadioListTile<String>(
                  title: Text(difficulty),
                  value: difficulty,
                  groupValue: 'Menengah',
                  onChanged: (value) {
                    Navigator.pop(dialogContext);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Kesulitan diubah ke $value')),
                        );
                      }
                    });
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _showQuestionCountDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Jumlah Soal Per Sesi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['5', '10', '15', '20']
              .map(
                (count) => RadioListTile<String>(
                  title: Text(count),
                  value: count,
                  groupValue: '10',
                  onChanged: (value) {
                    Navigator.pop(dialogContext);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Jumlah soal diubah ke $value')),
                        );
                      }
                    });
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
