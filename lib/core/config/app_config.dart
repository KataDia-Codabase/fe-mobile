/// Environment Configuration for KataDia
class AppConfig {
  // Gemini API Configuration
  static const String geminiApiKey = 'AIzaSyCt-eYE6K9N0ye18UjVQgj1q8IHvqPP8P0';
  static const String geminiEndpoint = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';
  
  // API timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;
  
  // Chat configuration
  static const double chatTemperature = 0.7;
  static const int chatMaxTokens = 1024;
  static const int chatTopK = 40;
  static const double chatTopP = 0.95;
  
  // Environment
  static const String appName = 'KataDia';
  static const String appVersion = '0.1.0';
}
