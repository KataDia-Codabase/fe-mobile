import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';

/// Utility class for handling notification permissions
class NotificationPermissionHandler {
  static final NotificationPermissionHandler _instance = NotificationPermissionHandler._internal();
  factory NotificationPermissionHandler() => _instance;
  NotificationPermissionHandler._internal();

  final Logger _logger = Logger();

  /// Request notification permission
  Future<bool> requestNotificationPermission({BuildContext? context}) async {
    try {
      final status = await Permission.notification.request();

      if (status.isGranted) {
        _logger.i('Notification permission granted');
        return true;
      } else if (status.isPermanentlyDenied) {
        _logger.w('Notification permission permanently denied');
        if (context != null) {
          await _showPermissionDeniedDialog(context);
        }
        return false;
      } else {
        _logger.w('Notification permission denied');
        return false;
      }
    } catch (e) {
      _logger.e('Error requesting notification permission: $e');
      return false;
    }
  }

  /// Check if notification permission is granted
  Future<bool> isNotificationPermissionGranted() async {
    final status = await Permission.notification.status;
    return status.isGranted;
  }

  /// Check if permission should be shown (first-time check)
  Future<bool> shouldShowPermissionRequest() async {
    final status = await Permission.notification.status;
    return status.isDenied || status.isLimited;
  }

  /// Open app settings for notification permissions
  Future<void> openAppSettingsForNotifications() async {
    try {
      await openAppSettings();
    } catch (e) {
      _logger.e('Error opening app settings: $e');
    }
  }

  /// Show permission denied dialog
  Future<void> _showPermissionDeniedDialog(BuildContext context) async {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notification Permission Required'),
        content: const Text(
          'To receive learning reminders and achievement notifications, '
          'please enable notifications in your device settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}
