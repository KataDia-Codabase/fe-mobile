import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../notification_types.dart';
import '../../notification_preferences.dart' as prefs;

/// Frequency untuk reminder notifikasi
enum NotificationFrequency {
  immediate('Segera'),
  hourly('Per Jam'),
  daily('Harian'),
  weekly('Mingguan'),
  monthly('Bulanan'),
  never('Tidak Pernah');

  const NotificationFrequency(this.displayName);
  
  final String displayName;
}

/// State untuk pengaturan notifikasi
class NotificationSettingsState {
  const NotificationSettingsState({
    this.isNotificationsEnabled = true,
    this.allowDuringQuietHours = false,
    this.isStreakNotificationsEnabled = true,
    this.isAchievementNotificationsEnabled = true,
    this.isLessonRemindersEnabled = true,
    this.isSystemNotificationsEnabled = true,
    this.dailyReminderTime = '19:00',
    this.isWeekendRemindersEnabled = false,
    this.isSoundEnabled = true,
    this.isVibrationEnabled = true,
    this.quietHoursStart = 22,
    this.quietHoursEnd = 8,
    this.reminderFrequency = NotificationFrequency.daily,
  });

  final bool isNotificationsEnabled;
  final bool allowDuringQuietHours;
  final bool isStreakNotificationsEnabled;
  final bool isAchievementNotificationsEnabled;
  final bool isLessonRemindersEnabled;
  final bool isSystemNotificationsEnabled;
  final String dailyReminderTime;
  final bool isWeekendRemindersEnabled;
  final bool isSoundEnabled;
  final bool isVibrationEnabled;
  final int quietHoursStart;
  final int quietHoursEnd;
  final NotificationFrequency reminderFrequency;

  NotificationSettingsState copyWith({
    bool? isNotificationsEnabled,
    bool? allowDuringQuietHours,
    bool? isStreakNotificationsEnabled,
    bool? isAchievementNotificationsEnabled,
    bool? isLessonRemindersEnabled,
    bool? isSystemNotificationsEnabled,
    String? dailyReminderTime,
    bool? isWeekendRemindersEnabled,
    bool? isSoundEnabled,
    bool? isVibrationEnabled,
    int? quietHoursStart,
    int? quietHoursEnd,
    NotificationFrequency? reminderFrequency,
  }) {
    return NotificationSettingsState(
      isNotificationsEnabled: isNotificationsEnabled ?? this.isNotificationsEnabled,
      allowDuringQuietHours: allowDuringQuietHours ?? this.allowDuringQuietHours,
      isStreakNotificationsEnabled: isStreakNotificationsEnabled ?? this.isStreakNotificationsEnabled,
      isAchievementNotificationsEnabled: isAchievementNotificationsEnabled ?? this.isAchievementNotificationsEnabled,
      isLessonRemindersEnabled: isLessonRemindersEnabled ?? this.isLessonRemindersEnabled,
      isSystemNotificationsEnabled: isSystemNotificationsEnabled ?? this.isSystemNotificationsEnabled,
      dailyReminderTime: dailyReminderTime ?? this.dailyReminderTime,
      isWeekendRemindersEnabled: isWeekendRemindersEnabled ?? this.isWeekendRemindersEnabled,
      isSoundEnabled: isSoundEnabled ?? this.isSoundEnabled,
      isVibrationEnabled: isVibrationEnabled ?? this.isVibrationEnabled,
      quietHoursStart: quietHoursStart ?? this.quietHoursStart,
      quietHoursEnd: quietHoursEnd ?? this.quietHoursEnd,
      reminderFrequency: reminderFrequency ?? this.reminderFrequency,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationSettingsState &&
      runtimeType == other.runtimeType &&
      isNotificationsEnabled == other.isNotificationsEnabled &&
      allowDuringQuietHours == other.allowDuringQuietHours &&
      isStreakNotificationsEnabled == other.isStreakNotificationsEnabled &&
      isAchievementNotificationsEnabled == other.isAchievementNotificationsEnabled &&
      isLessonRemindersEnabled == other.isLessonRemindersEnabled &&
      isSystemNotificationsEnabled == other.isSystemNotificationsEnabled &&
      dailyReminderTime == other.dailyReminderTime &&
      isWeekendRemindersEnabled == other.isWeekendRemindersEnabled &&
      isSoundEnabled == other.isSoundEnabled &&
      isVibrationEnabled == other.isVibrationEnabled &&
      quietHoursStart == other.quietHoursStart &&
      quietHoursEnd == other.quietHoursEnd &&
      reminderFrequency == other.reminderFrequency;

  @override
  int get hashCode => Object.hash(
        isNotificationsEnabled,
        allowDuringQuietHours,
        isStreakNotificationsEnabled,
        isAchievementNotificationsEnabled,
        isLessonRemindersEnabled,
        isSystemNotificationsEnabled,
        dailyReminderTime,
        isWeekendRemindersEnabled,
        isSoundEnabled,
        isVibrationEnabled,
        quietHoursStart,
        quietHoursEnd,
        reminderFrequency,
      );

  @override
  String toString() {
    return 'NotificationSettingsState('
        'isNotificationsEnabled: $isNotificationsEnabled, '
        'isStreakNotificationsEnabled: $isStreakNotificationsEnabled, '
        'dailyReminderTime: $dailyReminderTime, '
        'reminderFrequency: $reminderFrequency';
  }
}

/// Notifier untuk manajemen state pengaturan notifikasi
class NotificationSettingsNotifier extends StateNotifier<NotificationSettingsState> {
  final Logger _logger = Logger();

  NotificationSettingsNotifier() : super(const NotificationSettingsState());

  Future<void> loadSettings() async {
    try {
      state = NotificationSettingsState(
        isNotificationsEnabled: prefs.NotificationPreferences.isNotificationsEnabled(),
        allowDuringQuietHours: false,
        isStreakNotificationsEnabled: prefs.NotificationPreferences.isStreakNotificationsEnabled(),
        isAchievementNotificationsEnabled: prefs.NotificationPreferences.isAchievementNotificationsEnabled(),
        isLessonRemindersEnabled: prefs.NotificationPreferences.isLessonRemindersEnabled(),
        isSystemNotificationsEnabled: prefs.NotificationPreferences.isSystemNotificationsEnabled(),
        dailyReminderTime: prefs.NotificationPreferences.getDailyReminderTime().toString(),
        isWeekendRemindersEnabled: prefs.NotificationPreferences.isWeekendRemindersEnabled(),
        isSoundEnabled: prefs.NotificationPreferences.isSoundEnabled(),
        isVibrationEnabled: prefs.NotificationPreferences.isVibrationEnabled(),
        quietHoursStart: prefs.NotificationPreferences.getQuietHoursStart(),
        quietHoursEnd: prefs.NotificationPreferences.getQuietHoursEnd(),
        reminderFrequency: NotificationFrequency.daily,
      );
    } catch (e) {
      _logger.e('Error loading notification settings: $e');
      state = const NotificationSettingsState();
      rethrow;
    }
  }

  Future<void> updateNotificationsEnabled(bool value) async {
    await prefs.NotificationPreferences.setNotificationsEnabled(value);
    if (mounted) {
      state = state.copyWith(isNotificationsEnabled: value);
    }
  }

  Future<void> updateAllowDuringQuietHours(bool value) async {
    // Tidak ada method di prefs, simpan di state saja
    if (mounted) {
      state = state.copyWith(allowDuringQuietHours: value);
    }
  }

  Future<void> updateStreakNotificationsEnabled(bool value) async {
    await prefs.NotificationPreferences.setStreakNotificationsEnabled(value);
    if (mounted) {
      state = state.copyWith(isStreakNotificationsEnabled: value);
    }
  }

  Future<void> updateAchievementNotificationsEnabled(bool value) async {
    await prefs.NotificationPreferences.setAchievementNotificationsEnabled(value);
    if (mounted) {
      state = state.copyWith(isAchievementNotificationsEnabled: value);
    }
  }

  Future<void> updateLessonRemindersEnabled(bool value) async {
    await prefs.NotificationPreferences.setLessonRemindersEnabled(value);
    if (mounted) {
      state = state.copyWith(isLessonRemindersEnabled: value);
    }
  }

  Future<void> updateSystemNotificationsEnabled(bool value) async {
    await prefs.NotificationPreferences.setSystemNotificationsEnabled(value);
    if (mounted) {
      state = state.copyWith(isSystemNotificationsEnabled: value);
    }
  }

  Future<void> updateDailyReminderTime(Time time) async {
    await prefs.NotificationPreferences.setDailyReminderTime(time);
    if (mounted) {
      state = state.copyWith(dailyReminderTime: time.toString());
    }
  }

  Future<void> updateWeekendRemindersEnabled(bool value) async {
    await prefs.NotificationPreferences.setWeekendRemindersEnabled(value);
    if (mounted) {
      state = state.copyWith(isWeekendRemindersEnabled: value);
    }
  }

  Future<void> updateSoundEnabled(bool value) async {
    await prefs.NotificationPreferences.setSoundEnabled(value);
    if (mounted) {
      state = state.copyWith(isSoundEnabled: value);
    }
  }

  Future<void> updateVibrationEnabled(bool value) async {
    await prefs.NotificationPreferences.setVibrationEnabled(value);
    if (mounted) {
      state = state.copyWith(isVibrationEnabled: value);
    }
  }

  Future<void> updateQuietHours(int startHour, int endHour) async {
    await prefs.NotificationPreferences.setQuietHoursStart(startHour);
    await prefs.NotificationPreferences.setQuietHoursEnd(endHour);
    if (mounted) {
      state = state.copyWith(
        quietHoursStart: startHour,
        quietHoursEnd: endHour,
      );
    }
  }

  Future<void> updateReminderFrequency(NotificationFrequency frequency) async {
    // Simpan ke SharedPreferences dengan key kustom (gunakan method yang ada)
    // Karena setString tidak ada, kita simpan state saja
    if (mounted) {
      state = state.copyWith(reminderFrequency: frequency);
    }
  }

  Future<void> resetToDefaults() async {
    try {
      await prefs.NotificationPreferences.resetToDefaults();
      state = const NotificationSettingsState();
      _logger.i('Notification settings reset to defaults');
    } catch (e) {
      _logger.e('Error resetting notification settings: $e');
    }
  }
}

/// Provider untuk pengaturan notifikasi
final notificationSettingsProvider =
    StateNotifierProvider<NotificationSettingsNotifier, NotificationSettingsState>(
  (ref) => NotificationSettingsNotifier(),
);
