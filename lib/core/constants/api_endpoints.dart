class ApiEndpoints {
  // Base URL (change for different environments)
  static const String baseUrl = 'https://api.bahasaku.ai/v1';
  
  // Auth endpoints
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String changePassword = '/auth/change-password';
  static const String verifyEmail = '/auth/verify-email';
  static const String resendVerification = '/auth/resend-verification';
  
  // User profile endpoints
  static const String getProfile = '/user/profile';
  static const String updateProfile = '/user/profile';
  static const String uploadAvatar = '/user/avatar';
  static const String deleteAvatar = '/user/avatar';
  static const String getUserSettings = '/user/settings';
  static const String updateUserSettings = '/user/settings';
  
  // Lesson endpoints
  static const String lessons = '/lessons';
  static const String featuredSections = '/lessons/featured';
  static const String recommendedLessons = '/lessons/recommended';
  static const String bookmarkedLessons = '/lessons/bookmarked';
  static const String progress = '/lessons/progress';
  
  // Content endpoints
  static const String content = '/content';
  
  // Categories endpoints
  static const String categories = '/categories';
  
  // Pronunciation endpoints
  static const String pronunciation = '/pronunciation';
  static const String score = '/pronunciation/score';
  static const String history = '/pronunciation/history';
  
  // File upload/download endpoints
  static const String uploadAudio = '/upload/audio';
  static const String uploadImage = '/upload/image';
  static const String downloadContent = '/download/content';
  
  // Analytics endpoints
  static const String analytics = '/analytics';
  static const String statistics = '/analytics/statistics';
  static const String learningStats = '/analytics/learning';
  
  // Support endpoints
  static const String support = '/support';
  static const String feedback = '/support/feedback';
  static const String reportIssue = '/support/report';
  
  // Health check
  static const String health = '/health';
  
  // Version check
  static const String version = '/version';
  
  // Static file storage URLs (CDN)
  static const String audioBaseUrl = 'https://cdn.bahasaku.ai/audio';
  static const String imageBaseUrl = 'https://cdn.bahasaku.ai/images';
  static const String videoBaseUrl = 'https://cdn.bahasaku.ai/videos';
  
  // Helper method for full URLs
  static String fullUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }
  
  // Helper methods for CDN URLs
  static String audioUrl(String fileName) {
    return '$audioBaseUrl/$fileName';
  }
  
  static String imageUrl(String fileName) {
    return '$imageBaseUrl/$fileName';
  }
  
  static String videoUrl(String fileName) {
    return '$videoBaseUrl/$fileName';
  }
}
