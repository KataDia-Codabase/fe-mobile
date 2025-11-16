/// Cache keys for local storage and SharedPreferences
class CacheKeys {
  // User authentication
  /// JWT access token for API authentication
  static const String userToken = 'user_token';
  /// JWT refresh token for token renewal
  static const String userRefreshToken = 'user_refresh_token';
  /// Cached user profile information
  static const String userProfile = 'user_profile';
  /// Onboarding completion status
  static const String onboardingCompleted = 'onboarding_completed';
  
  // App settings
  /// General app settings and preferences
  static const String appSettings = 'app_settings';
  /// User selected language preference (id-ID/en-US)
  static const String languagePreference = 'language_preference';
  /// Theme preference (light/dark/system)
  static const String themePreference = 'theme_preference';
  /// User notification preferences and settings
  static const String notificationSettings = 'notification_settings';
  
  // Learning content
  /// Cached lesson content for offline access
  static const String lessons = 'lessons';
  /// Featured lessons for homepage
  static const String featuredLessons = 'featured_lessons';
  /// Recommended lessons based on user progress
  static const String recommendedLessons = 'recommended_lessons';
  /// User lesson progress and completion status
  static const String lessonProgress = 'lesson_progress';
  /// User vocabulary collection and progress
  static const String vocabulary = 'vocabulary';
  
  // Pronunciation
  /// History of pronunciation practice attempts
  static const String pronunciationHistory = 'pronunciation_history';
  /// Recent pronunciation scores and feedback
  static const String recentScores = 'recent_scores';
  /// Cached audio files for playback
  static const String audioCache = 'audio_cache';
  
  // Gamification
  /// User experience points and progression
  static const String userXp = 'user_xp';
  /// Current user level and progression
  static const String userLevel = 'user_level';
  /// User learning streaks and daily activity
  static const String userStreaks = 'user_streaks';
  /// Unlocked achievements and progress
  static const String achievements = 'achievements';
  /// User earned badges and rewards
  static const String badges = 'badges';
  
  // Social features
  /// User friends list and social connections
  static const String friends = 'friends';
  /// Leaderboard data and rankings
  static const String leaderboard = 'leaderboard';
  /// Social feed and activity updates
  static const String socialFeed = 'social_feed';
  
  // Performance metrics
  /// App performance analytics and data
  static const String performanceAnalytics = 'performance_analytics';
  /// User learning progress analytics
  static const String learningAnalytics = 'learning_analytics';
  /// App usage statistics and metrics
  static const String usageStats = 'usage_stats';
  
  // System
  /// Last synchronization timestamp
  static const String lastSync = 'last_sync';
  /// Current app version for update checks
  static const String appVersion = 'app_version';
  /// Device information for optimization
  static const String deviceInfo = 'device_info';
  /// Crash report logs for debugging
  static const String crashReports = 'crash_reports';
  
  // Temporary
  /// Temporary recording file paths
  static const String tempRecording = 'temp_recording';
  /// Pending upload queue for offline mode
  static const String pendingUpload = 'pending_upload';
  /// Offline operation queue
  static const String offlineQueue = 'offline_queue';
}
