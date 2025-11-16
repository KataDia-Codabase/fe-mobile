import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Notification channels configuration for Android
class NotificationChannels {
  // Channel IDs
  static const String general = 'general_channel';
  static const String streak = 'streak_channel';
  static const String achievements = 'achievements_channel';
  static const String lessons = 'lessons_channel';
  static const String system = 'system_channel';

  // Get all channel configurations
  static List<AndroidNotificationChannel> get allChannels => [
    createGeneralChannel(),
    createStreakChannel(),
    createAchievementsChannel(),
    createLessonsChannel(),
    createSystemChannel(),
  ];

  /// General notifications channel
  static AndroidNotificationChannel createGeneralChannel() {
    return const AndroidNotificationChannel(
      general,
      'General Notifications',
      description: 'General app notifications and updates',
      importance: Importance.defaultImportance,
      showBadge: true,
      enableVibration: true,
      playSound: true,
    );
  }

  /// Learning streak notifications channel
  static AndroidNotificationChannel createStreakChannel() {
    return AndroidNotificationChannel(
      streak,
      'Learning Streak',
      description: 'Notifications about your learning streak and daily goals',
      importance: Importance.high,
      showBadge: true,
      enableVibration: true,
      playSound: true,
      ledColor: const Color(0xFFFF9800), // Orange
      enableLights: true,
    );
  }

  /// Achievement notifications channel
  static AndroidNotificationChannel createAchievementsChannel() {
    return AndroidNotificationChannel(
      achievements,
      'Achievements',
      description: 'Notifications for unlocked achievements and milestones',
      importance: Importance.defaultImportance,
      showBadge: true,
      enableVibration: true,
      playSound: true,
      ledColor: const Color(0xFF9C27B0), // Purple
      enableLights: true,
    );
  }

  /// Lesson reminders channel
  static AndroidNotificationChannel createLessonsChannel() {
    return AndroidNotificationChannel(
      lessons,
      'Lesson Reminders',
      description: 'Reminders for scheduled lessons and practice sessions',
      importance: Importance.max,
      showBadge: true,
      enableVibration: true,
      playSound: true,
      ledColor: const Color(0xFF2196F3), // Blue
      enableLights: true,
    );
  }

  /// System notifications channel
  static AndroidNotificationChannel createSystemChannel() {
    return AndroidNotificationChannel(
      system,
      'System Notifications',
      description: 'Important system updates and maintenance notifications',
      importance: Importance.high,
      showBadge: true,
      enableVibration: true,
      playSound: true,
      ledColor: const Color(0xFFF44336), // Red
      enableLights: true,
    );
  }
}
