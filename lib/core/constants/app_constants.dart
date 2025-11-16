class AppConstants {
  // App Configuration
  static const String appName = 'KataDia';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://api.bahasaku.ai';
  static const String apiVersion = 'v1';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration connectionTimeout = Duration(seconds: 10);
  
  // API Endpoints
  static const String authPath = '/auth';
  static const String usersPath = '/users';
  static const String lessonsPath = '/lessons';
  static const String pronunciationPath = '/pronunciation';
  static const String uploadPath = '/upload';
  
  // Authentication
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user';
  
  // File Storage
  static const String maxFileSize = '10MB';
  static const List<String> supportedAudioFormats = ['mp3', 'wav', 'm4a'];
  
  // Cache Configuration
  static const Duration cacheTimeout = Duration(hours: 24);
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Localization
  static const List<String> supportedLocales = ['en', 'id'];
  static const String defaultLocale = 'en';
  
  // Social Login
  static const String googleClientId = 'your-google-client-id';
  static const String appleClientId = 'your-apple-client-id';
  
  // Audio Recording
  static const Duration maxRecordingDuration = Duration(minutes: 5);
  static const Duration minRecordingDuration = Duration(seconds: 1);
  static const int sampleRate = 44100;
  static const int bitRate = 128000;
  
  // Gamification
  static const double xpMultiplier = 1.0;
  static const int streakResetHours = 24;
  static const int maxStreakDays = 365;
  
  // Analytics
  static const bool analyticsEnabled = true;
  static const String analyticsApiKey = 'your-analytics-key';
  
  // Rate Limiting
  static const int maxApiRequestsPerMinute = 60;
  static const int maxRecordingAttemptsPerHour = 50;
}

class ApiEndpoints {
  // Base URL with version
  static String get baseUrl => '${AppConstants.baseUrl}/${AppConstants.apiVersion}';
  
  // Authentication endpoints
  static String get login => '$baseUrl${AppConstants.authPath}/login';
  static String get register => '$baseUrl${AppConstants.authPath}/register';
  static String get logout => '$baseUrl${AppConstants.authPath}/logout';
  static String get refresh => '$baseUrl${AppConstants.authPath}/refresh';
  static String get forgotPassword => '$baseUrl${AppConstants.authPath}/forgot-password';
  static String get resetPassword => '$baseUrl${AppConstants.authPath}/reset-password';
  
  // User endpoints
  static String get profile => '$baseUrl${AppConstants.usersPath}/profile';
  static String updateProfile(String userId) => '$baseUrl${AppConstants.usersPath}/$userId';
  static String get me => '$baseUrl${AppConstants.usersPath}/me';
  
  // Lesson endpoints
  static String get lessons => '$baseUrl${AppConstants.lessonsPath}';
  static String lessonById(String id) => '$baseUrl${AppConstants.lessonsPath}/$id';
  static String get featuredLessons => '$baseUrl${AppConstants.lessonsPath}/featured';
  static String get recommendedLessons => '$baseUrl${AppConstants.lessonsPath}/recommended';
  
  // Pronunciation endpoints
  static String get score => '$baseUrl${AppConstants.pronunciationPath}/score';
  static String get history => '$baseUrl${AppConstants.pronunciationPath}/history';
  static String practiceDetails(String id) => '$baseUrl${AppConstants.pronunciationPath}/$id';
  
  // Upload endpoints
  static String get uploadAudio => '$baseUrl${AppConstants.uploadPath}/audio';
  static String get uploadProfile => '$baseUrl${AppConstants.uploadPath}/profile';
}

class CacheKeys {
  static const String userToken = 'user_token';
  static const String userProfile = 'user_profile';
  static const String lessons = 'lessons';
  static const String pronunciationHistory = 'pronunciation_history';
  static const String appSettings = 'app_settings';
  static const String lastSync = 'last_sync';
}

class AssetPaths {
  // Images
  static const String logo = 'assets/images/logo.png';
  static const String placeholder = 'assets/images/placeholder.png';
  static const String onboarding1 = 'assets/images/onboarding1.png';
  static const String onboarding2 = 'assets/images/onboarding2.png';
  static const String onboarding3 = 'assets/images/onboarding3.png';
  static const String achievements = 'assets/images/achievements/';
  static const String badges = 'assets/images/badges/';
  
  // Animations
  static const String loading = 'assets/animations/loading.json';
  static const String success = 'assets/animations/success.json';
  static const String error = 'assets/animations/error.json';
  static const String recording = 'assets/animations/recording.json';
  static const String celebration = 'assets/animations/celebration.json';
  
  // Icons
  static const String appIcon = 'assets/icons/app_icon.png';
  static const String googleIcon = 'assets/icons/google.png';
  static const String appleIcon = 'assets/icons/apple.png';
}

class ThemeConstants {
  // Colors
  static const String primaryColor = '#1976D2';
  static const String secondaryColor = '#FF5722';
  static const String accentColor = '#4CAF50';
  static const String backgroundColor = '#FAFAFA';
  static const String surfaceColor = '#FFFFFF';
  static const String errorColor = '#F44336';
  static const String warningColor = '#FF9800';
  static const String successColor = '#4CAF50';
  static const String infoColor = '#2196F3';
  
  // Typography
  static const String fontFamily = 'Inter';
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 14.0;
  static const double fontSizeLarge = 16.0;
  static const double fontSizeXLarge = 18.0;
  static const double fontSizeXXLarge = 24.0;
  static const double fontSizeXXXLarge = 32.0;
  
  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  
  // Border Radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  
  // Animation
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);
}
