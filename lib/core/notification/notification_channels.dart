import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Simplified notification channels for KataDia
class NotificationChannels {
  // Channel IDs (constants for compatibility)
  static const String general = 'bahasaku_general';
  static const String streak = 'bahasaku_streak';
  static const String achievements = 'bahasaku_achievements';
  static const String lessons = 'bahasaku_lessons';
  static const String system = 'bahasaku_system';

  // Legacy channel names for compatibility
  static const String generalChannelId = 'bahasaku_general';
  static const String generalChannelName = 'KataDia General';
  static const String generalChannelDescription = 'General notifications from KataDia';

  static const String streakChannelId = 'bahasaku_streak';
  static const String streakChannelName = 'Learning Streak';
  static const String streakChannelDescription = 'Notifications about your learning streak';

  static const String achievementChannelId = 'bahasaku_achievements';
  static const String achievementChannelName = 'Achievements';
  static const String achievementChannelDescription = 'Notifications about your achievements';

  static const String lessonsChannelId = 'bahasaku_lessons';
  static const String lessonsChannelName = 'Lesson Reminders';
  static const String lessonsChannelDescription = 'Reminders for scheduled lessons';

  static const String systemChannelId = 'bahasaku_system';
  static const String systemChannelName = 'System';
  static const String systemChannelDescription = 'System notifications and updates';

  /// Get all channel IDs as a list
  static List<String> get values => [
    general,
    streak,
    achievements,
    lessons,
    system,
  ];

  /// Get all notification channels
  static List<AndroidNotificationChannel> getChannels() {
    return [
      createGeneralChannel(),
      createStreakChannel(),
      createAchievementsChannel(),
      createLessonsChannel(),
      createSystemChannel(),
    ];
  }

  static AndroidNotificationChannel createGeneralChannel() {
    return const AndroidNotificationChannel(
      generalChannelId,
      generalChannelName,
      description: generalChannelDescription,
      importance: Importance.high,
      enableLights: true,
      enableVibration: true,
    );
  }

  static AndroidNotificationChannel createStreakChannel() {
    return const AndroidNotificationChannel(
      streakChannelId,
      streakChannelName,
      description: streakChannelDescription,
      importance: Importance.defaultImportance,
      enableLights: true,
      enableVibration: true,
    );
  }

  static AndroidNotificationChannel createAchievementsChannel() {
    return const AndroidNotificationChannel(
      achievementChannelId,
      achievementChannelName,
      description: achievementChannelDescription,
      importance: Importance.high,
      enableLights: true,
      enableVibration: true,
    );
  }

  static AndroidNotificationChannel createLessonsChannel() {
    return const AndroidNotificationChannel(
      lessonsChannelId,
      lessonsChannelName,
      description: lessonsChannelDescription,
      importance: Importance.defaultImportance,
      enableLights: true,
      enableVibration: true,
    );
  }

  static AndroidNotificationChannel createSystemChannel() {
    return const AndroidNotificationChannel(
      systemChannelId,
      systemChannelName,
      description: systemChannelDescription,
      importance: Importance.low,
      enableLights: false,
      enableVibration: false,
    );
  }
}
