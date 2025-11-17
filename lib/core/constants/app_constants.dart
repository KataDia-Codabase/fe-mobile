class AppConstants {
  // App Info
  static const String appName = 'Katadia';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String apiBaseUrl = 'https://api.katadia.com';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'theme_mode';
  
  // Route Names
  static const String splashRoute = '/splash';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String profileRoute = '/profile';
}
