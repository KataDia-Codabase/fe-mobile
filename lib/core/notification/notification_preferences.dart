import 'package:shared_preferences/shared_preferences.dart';
import 'notification_types.dart';

/// Notification preferences management for KataDia
class NotificationPreferences {
  static const String _keyNotificationsEnabled = 'notifications_enabled';
  static const String _keyStreakNotifications = 'streak_notifications';
  static const String _keyAchievementNotifications = 'achievement_notifications';
  static const String _keyLessonReminders = 'lesson_reminders';
  static const String _keySystemNotifications = 'system_notifications';
  static const String _keyDailyReminderTime = 'daily_reminder_time';
  static const String _keyWeekendReminders = 'weekend_reminders';
  static const String _keySoundEnabled = 'sound_enabled';
  static const String _keyVibrationEnabled = 'vibration_enabled';
  static const String _keyQuietHoursStart = 'quiet_hours_start';
  static const String _keyQuietHoursEnd = 'quiet_hours_end';
  static const String _keyLastNotificationTime = 'last_notification_time';

  static SharedPreferences? _prefs;

  /// Initialize notification preferences
  static Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Ensure preferences are initialized
  static Future<SharedPreferences> get _preferences async {
    if (_prefs == null) {
      await initialize();
    }
    return _prefs!;
  }

  /// Check if notifications are globally enabled
  static bool isNotificationsEnabled() {
    return _prefs?.getBool(_keyNotificationsEnabled) ?? true;
  }

  /// Enable/disable all notifications
  static Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await _preferences;
    await prefs.setBool(_keyNotificationsEnabled, enabled);
  }

  /// Check if streak notifications are enabled
  static bool isStreakNotificationsEnabled() {
    if (!isNotificationsEnabled()) return false;
    return _prefs?.getBool(_keyStreakNotifications) ?? true;
  }

  /// Enable/disable streak notifications
  static Future<void> setStreakNotificationsEnabled(bool enabled) async {
    final prefs = await _preferences;
    await prefs.setBool(_keyStreakNotifications, enabled);
  }

  /// Check if achievement notifications are enabled
  static bool isAchievementNotificationsEnabled() {
    if (!isNotificationsEnabled()) return false;
    return _prefs?.getBool(_keyAchievementNotifications) ?? true;
  }

  /// Enable/disable achievement notifications
  static Future<void> setAchievementNotificationsEnabled(bool enabled) async {
    final prefs = await _preferences;
    await prefs.setBool(_keyAchievementNotifications, enabled);
  }

  /// Check if lesson reminders are enabled
  static bool isLessonRemindersEnabled() {
    if (!isNotificationsEnabled()) return false;
    return _prefs?.getBool(_keyLessonReminders) ?? true;
  }

  /// Enable/disable lesson reminders
  static Future<void> setLessonRemindersEnabled(bool enabled) async {
    final prefs = await _preferences;
    await prefs.setBool(_keyLessonReminders, enabled);
  }

  /// Check if system notifications are enabled
  static bool isSystemNotificationsEnabled() {
    if (!isNotificationsEnabled()) return false;
    return _prefs?.getBool(_keySystemNotifications) ?? true;
  }

  /// Enable/disable system notifications
  static Future<void> setSystemNotificationsEnabled(bool enabled) async {
    final prefs = await _preferences;
    await prefs.setBool(_keySystemNotifications, enabled);
  }

  /// Get daily reminder time
  static Time getDailyReminderTime() {
    final timeString = _prefs?.getString(_keyDailyReminderTime) ?? '19:00';
    final parts = timeString.split(':');
    return Time(int.parse(parts[0]), int.parse(parts[1]));
  }

  /// Set daily reminder time
  static Future<void> setDailyReminderTime(Time time) async {
    final prefs = await _preferences;
    await prefs.setString(_keyDailyReminderTime, time.toString());
  }

  /// Check if weekend reminders are enabled
  static bool isWeekendRemindersEnabled() {
    return _prefs?.getBool(_keyWeekendReminders) ?? false;
  }

  /// Enable/disable weekend reminders
  static Future<void> setWeekendRemindersEnabled(bool enabled) async {
    final prefs = await _preferences;
    await prefs.setBool(_keyWeekendReminders, enabled);
  }

  /// Check if sound is enabled
  static bool isSoundEnabled() {
    return _prefs?.getBool(_keySoundEnabled) ?? true;
  }

  /// Enable/disable sound
  static Future<void> setSoundEnabled(bool enabled) async {
    final prefs = await _preferences;
    await prefs.setBool(_keySoundEnabled, enabled);
  }

  /// Check if vibration is enabled
  static bool isVibrationEnabled() {
    return _prefs?.getBool(_keyVibrationEnabled) ?? true;
  }

  /// Enable/disable vibration
  static Future<void> setVibrationEnabled(bool enabled) async {
    final prefs = await _preferences;
    await prefs.setBool(_keyVibrationEnabled, enabled);
  }

  /// Get quiet hours start
  static int getQuietHoursStart() {
    return _prefs?.getInt(_keyQuietHoursStart) ?? 22;
  }

  /// Set quiet hours start
  static Future<void> setQuietHoursStart(int hour) async {
    final prefs = await _preferences;
    await prefs.setInt(_keyQuietHoursStart, hour);
  }

  /// Get quiet hours end
  static int getQuietHoursEnd() {
    return _prefs?.getInt(_keyQuietHoursEnd) ?? 8;
  }

  /// Set quiet hours end
  static Future<void> setQuietHoursEnd(int hour) async {
    final prefs = await _preferences;
    await prefs.setInt(_keyQuietHoursEnd, hour);
  }

  /// Check if current time is in quiet hours
  static bool isInQuietHours() {
    final now = DateTime.now();
    final currentHour = now.hour;
    final startHour = getQuietHoursStart();
    final endHour = getQuietHoursEnd();

    if (startHour > endHour) {
      // Quiet hours span midnight (e.g., 22:00 to 08:00)
      return currentHour >= startHour || currentHour < endHour;
    } else {
      // Normal quiet hours (e.g., 01:00 to 07:00)
      return currentHour >= startHour && currentHour < endHour;
    }
  }

  /// Get last notification time for a specific type
  static DateTime? getLastNotificationTime(String notificationType) {
    final timestamp = _prefs?.getInt('${_keyLastNotificationTime}_$notificationType');
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  /// Set last notification time for a specific type
  static Future<void> setLastNotificationTime(String notificationType) async {
    final prefs = await _preferences;
    await prefs.setInt('${_keyLastNotificationTime}_$notificationType', 
        DateTime.now().millisecondsSinceEpoch);
  }

  /// Check if notification type can be shown (rate limiting)
  static bool canShowNotification(String notificationType, {Duration minInterval = const Duration(minutes: 30)}) {
    final lastTime = getLastNotificationTime(notificationType);
    if (lastTime == null) return true;
    
    final now = DateTime.now();
    final timeSinceLast = now.difference(lastTime);
    
    return timeSinceLast >= minInterval;
  }

  /* Model methods are handled by individual setters/getters above */

  /// Reset all notification preferences to defaults
  static Future<void> resetToDefaults() async {
    final prefs = await _preferences;
    await prefs.remove(_keyNotificationsEnabled);
    await prefs.remove(_keyStreakNotifications);
    await prefs.remove(_keyAchievementNotifications);
    await prefs.remove(_keyLessonReminders);
    await prefs.remove(_keySystemNotifications);
    await prefs.remove(_keyDailyReminderTime);
    await prefs.remove(_keyWeekendReminders);
    await prefs.remove(_keySoundEnabled);
    await prefs.remove(_keyVibrationEnabled);
    await prefs.remove(_keyQuietHoursStart);
    await prefs.remove(_keyQuietHoursEnd);
  }

  /// Clear all notification-related data
  static Future<void> clearAll() async {
    final prefs = await _preferences;
    for (final key in [
      _keyNotificationsEnabled,
      _keyStreakNotifications,
      _keyAchievementNotifications,
      _keyLessonReminders,
      _keySystemNotifications,
      _keyDailyReminderTime,
      _keyWeekendReminders,
      _keySoundEnabled,
      _keyVibrationEnabled,
      _keyQuietHoursStart,
      _keyQuietHoursEnd,
    ]) {
      await prefs.remove(key);
    }
  }

  /// Get notification frequency settings
  static NotificationFrequency getNotificationFrequency(String notificationType) {
    // Default frequency based on notification type
    switch (notificationType) {
      case NotificationType.streakReminder:
        return NotificationFrequency.daily;
      case NotificationType.achievement:
        return NotificationFrequency.immediate;
      case NotificationType.lessonReminder:
        return NotificationFrequency.weekly;
      case NotificationType.streakWarning:
        return NotificationFrequency.daily;
      default:
        return NotificationFrequency.daily;
    }
  }

  /// Set notification frequency
  static Future<void> setNotificationFrequency(String notificationType, NotificationFrequency frequency) async {
    final prefs = await _preferences;
    await prefs.setString('notification_frequency_$notificationType', frequency.name);
  }

  /// Get notification frequency
  static NotificationFrequency getNotificationFrequencySettings(String notificationType) {
    final frequencyString = _prefs?.getString('notification_frequency_$notificationType');
    if (frequencyString == null) return getNotificationFrequency(notificationType);
    
    return NotificationFrequency.values.firstWhere(
      (freq) => freq.name == frequencyString,
      orElse: () => NotificationFrequency.daily,
    );
  }
}

/// Extension for SharedPreferences to handle Time objects
extension TimeSharedPreferences on SharedPreferences {
  /// Set time value
  Future<bool> setTime(String key, Time time) {
    return setString(key, time.toString());
  }

  /// Get time value
  Time? getTime(String key) {
    final timeString = getString(key);
    if (timeString == null) return null;
    
    final parts = timeString.split(':');
    if (parts.length != 2) return null;
    
    try {
      return Time(int.parse(parts[0]), int.parse(parts[1]));
    } catch (e) {
      return null;
    }
  }
}

/// Notification frequency enum
enum NotificationFrequency {
  immediate,
  hourly,
  daily,
  weekly,
  monthly,
  never,
}
