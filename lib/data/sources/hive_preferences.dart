import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// User preferences storage system
class UserPreferences {
  static late Box<dynamic> _prefsBox;

  // Theme preferences
  static const String _themeModeKey = 'app_theme_mode';
  static const String notificationsEnabled = 'notifications_enabled';
  static const String playbackSpeed = 'playback_speed';
  static const String autoPlayEnabled = 'auto_play_enabled';
  static const String syncEnabled = 'sync_enabled';
  static const String isFirstLaunch = 'is_first_launch';
  static const String dailyGoalKey = 'daily_goal';
  static const String weeklyTargetKey = 'weekly_target';
  static const String weeklyProgressKey = 'weekly_progress';

  // Defaults
  static const int defaultDailyGoal = 7; // minutes per day
  static const int defaultWeeklyTarget = 4;
  static const int defaultCacheSize = 50; // MB
  static const int maxCacheSize = 200; // MB

  /// Initialize Hive preferences
  static Future<void> initialize() async {
    await Hive.initFlutter();
    _prefsBox = await Hive.openBox<dynamic>('user_preferences');
  }

  /// Get theme mode
  static String getThemeMode() {
    return _prefsBox.get(_themeModeKey, defaultValue: 'light') as String;
  }

  /// Set theme mode
  static Future<void> setThemeMode(String mode) async {
    await _prefsBox.put(_themeModeKey, mode);
  }

  /// Toggle notifications
  static Future<void> toggleNotificationsEnabled() async {
    final current = _prefsBox.get(notificationsEnabled, defaultValue: true) as bool;
    await _prefsBox.put(notificationsEnabled, !current);
  }

  /// Get notifications enabled status
  static bool getNotificationsEnabled() {
    return _prefsBox.get(notificationsEnabled, defaultValue: true) as bool;
  }

  /// Set daily goal
  static Future<void> setDailyGoal(int goal) async {
    await _prefsBox.put(dailyGoalKey, goal);
  }

  /// Get daily goal
  static int getDailyGoal() {
    return _prefsBox.get(dailyGoalKey, defaultValue: defaultDailyGoal) as int;
  }

  /// Set playback speed
  static Future<void> setPlaySpeed(double speed) async {
    await _prefsBox.put(playbackSpeed, speed);
  }

  /// Get playback speed
  static double getPlaySpeed() {
    return _prefsBox.get(playbackSpeed, defaultValue: 1.0) as double;
  }

  /// Set auto play enabled
  static Future<void> setAutoPlayEnabled(bool enabled) async {
    await _prefsBox.put(autoPlayEnabled, enabled);
  }

  /// Get auto play enabled
  static bool getAutoPlayEnabled() {
    return _prefsBox.get(autoPlayEnabled, defaultValue: false) as bool;
  }

  /// Set sync enabled
  static Future<void> setSyncEnabled(bool enabled) async {
    await _prefsBox.put(syncEnabled, enabled);
  }

  /// Get sync enabled
  static bool getSyncEnabled() {
    return _prefsBox.get(syncEnabled, defaultValue: true) as bool;
  }

  /// Increment streak days
  static Future<void> incrementStreakDays() async {
    final currentStreak = getStreakDays();
    await _prefsBox.put('streak_days', currentStreak + 1);
  }

  /// Get streak days
  static int getStreakDays() {
    return _prefsBox.get('streak_days', defaultValue: 0) as int;
  }

  /// Reset streak days
  static Future<void> resetStreakDays() async {
    await _prefsBox.put('streak_days', 0);
  }

  /// Get total study time in minutes
  static int getTotalStudyTime() {
    return _prefsBox.get('total_study_time', defaultValue: 0) as int;
  }

  /// Set total study time
  static Future<void> setTotalStudyTime(int minutes) async {
    await _prefsBox.put('total_study_time', minutes);
  }

  /// Add study time
  static Future<void> addStudyTime(int minutes) async {
    final current = getTotalStudyTime();
    await _prefsBox.put('total_study_time', current + minutes);
  }

  /// Get total XP points
  static double getTotalXp() {
    return _prefsBox.get('total_xp', defaultValue: 0.0) as double;
  }

  /// Set total XP
  static Future<void> setTotalXp(double xp) async {
    await _prefsBox.put('total_xp', xp);
  }

  /// Add XP points
  static Future<void> addXp(double xp) async {
    final current = getTotalXp();
    await _prefsBox.put('total_xp', current + xp);
  }

  /// Get completed lessons count
  static int getCompletedLessons() {
    return _prefsBox.get('lessons_completed', defaultValue: 0) as int;
  }

  /// Set completed lessons count
  static Future<void> setCompletedLessons(int count) async {
    await _prefsBox.put('lessons_completed', count);
  }

  /// Increment completed lessons
  static Future<void> incrementCompletedLessons() async {
    final current = getCompletedLessons();
    await _prefsBox.put('lessons_completed', current + 1);
  }

  /// Get user name
  static String? getUserName() {
    return _prefsBox.get('user_name') as String?;
  }

  /// Set user name
  static Future<void> setUserName(String name) async {
    await _prefsBox.put('user_name', name);
  }

  /// Get user email
  static String? getUserEmail() {
    return _prefsBox.get('user_email') as String?;
  }

  /// Set user email
  static Future<void> setUserEmail(String email) async {
    await _prefsBox.put('user_email', email);
  }

  /// Get user level
  static String getUserLevel() {
    return _prefsBox.get('user_level', defaultValue: 'A1') as String;
  }

  /// Set user level
  static Future<void> setUserLevel(String level) async {
    await _prefsBox.put('user_level', level);
  }

  /// Get first launch status
  static bool isFirstLaunchApp() {
    return _prefsBox.get(isFirstLaunch, defaultValue: true) as bool;
  }

  /// Mark first launch as complete
  static Future<void> markFirstLaunchComplete() async {
    await _prefsBox.put(isFirstLaunch, false);
  }

  /// Get notifications enabled status
  static bool hasNotificationsEnabled() {
    return _prefsBox.get(notificationsEnabled, defaultValue: true) as bool;
  }

  /// Get audio recording enabled
  static bool isAudioRecordingEnabled() {
    return _prefsBox.get('audio_recording_enabled', defaultValue: true) as bool;
  }

  /// Set audio recording enabled
  static Future<void> setAudioRecordingEnabled(bool enabled) async {
    await _prefsBox.put('audio_recording_enabled', enabled);
  }

  /// Get speech recognition enabled
  static bool isSpeechRecognitionEnabled() {
    return _prefsBox.get('speech_recognition_enabled', defaultValue: true) as bool;
  }

  /// Set speech recognition enabled
  static Future<void> setSpeechRecognitionEnabled(bool enabled) async {
    await _prefsBox.put('speech_recognition_enabled', enabled);
  }

  /// Get user profile stats
  static Future<Map<String, dynamic>> getProfileStats() async {
    return {
      'user_name': getUserName() ?? 'Guest',
      'user_email': getUserEmail() ?? '',
      'user_level': getUserLevel(),
      'total_study_time': getTotalStudyTime(),
      'xp_points': getTotalXp(),
      'streak_days': getStreakDays(),
      'completed_lessons': getCompletedLessons(),
    };
  }

  /// Get statistics
  static Future<Map<String, dynamic>> getStats() async {
    return {
      'daily_goal': getDailyGoal(),
      'weekly_target': _prefsBox.get(weeklyTargetKey, defaultValue: defaultWeeklyTarget),
      'weekly_progress': _prefsBox.get(weeklyProgressKey, defaultValue: 0),
      'total_study_time': getTotalStudyTime(),
      'total_lessons': getCompletedLessons(),
      'xp_points': getTotalXp(),
      'streak_days': getStreakDays(),
    };
  }

  /// Clear all preferences
  static Future<void> clearAll() async {
    await _prefsBox.clear();
  }

  /// Clear specific key
  static Future<void> clearKey(String key) async {
    await _prefsBox.delete(key);
  }

  /// Dispose Hive
  static Future<void> dispose() async {
    await Hive.close();
  }
}
