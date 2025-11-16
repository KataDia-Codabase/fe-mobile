import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Simple notification settings screen
class NotificationSettingsScreen extends ConsumerStatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  ConsumerState<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends ConsumerState<NotificationSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Notifikasi'),
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
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        children: [
          // Enable notifications
          SwitchListTile(
            title: const Text('Aktifkan Notifikasi'),
            subtitle: const Text('Terima notifikasi aplikasi'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          Divider(height: 16.h),

          // Sound
          SwitchListTile(
            title: const Text('Suara'),
            subtitle: const Text('Putar suara saat notifikasi'),
            value: _soundEnabled,
            onChanged: (value) {
              setState(() {
                _soundEnabled = value;
              });
            },
          ),
          
          // Vibration
          SwitchListTile(
            title: const Text('Getaran'),
            subtitle: const Text('Getaran saat notifikasi'),
            value: _vibrationEnabled,
            onChanged: (value) {
              setState(() {
                _vibrationEnabled = value;
              });
            },
          ),
          Divider(height: 16.h),

          // Achievement notifications
          SwitchListTile(
            title: const Text('Notifikasi Achievement'),
            subtitle: const Text('Terima notifikasi saat unlock achievement'),
            value: true,
            onChanged: (value) {},
          ),

          // Streak notifications
          SwitchListTile(
            title: const Text('Notifikasi Streak'),
            subtitle: const Text('Notifikasi untuk streak Anda'),
            value: true,
            onChanged: (value) {},
          ),

          // Lesson reminders
          SwitchListTile(
            title: const Text('Pengingat Pelajaran'),
            subtitle: const Text('Pengingat untuk belajar'),
            value: true,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
