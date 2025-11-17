import 'package:flutter/foundation.dart';

/// Utility class for logging throughout the app
/// Only logs in debug mode
class Logger {
  static const String _prefix = '🎯 KataDia';

  /// Log info message
  static void info(String message, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag]' : '';
      debugPrint('$_prefix ℹ️ $tagStr $message');
    }
  }

  /// Log debug message
  static void debug(String message, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag]' : '';
      debugPrint('$_prefix 🐛 $tagStr $message');
    }
  }

  /// Log warning message
  static void warning(String message, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag]' : '';
      debugPrint('$_prefix ⚠️ $tagStr $message');
    }
  }

  /// Log error message
  static void error(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag]' : '';
      debugPrint('$_prefix ❌ $tagStr $message');
      if (error != null) {
        debugPrint('Error: $error');
      }
      if (stackTrace != null) {
        debugPrintStack(stackTrace: stackTrace);
      }
    }
  }

  /// Log success message
  static void success(String message, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag]' : '';
      debugPrint('$_prefix ✅ $tagStr $message');
    }
  }

  /// Log API call
  static void api(String method, String endpoint, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag]' : '';
      debugPrint('$_prefix 🌐 $tagStr API: $method $endpoint');
    }
  }

  /// Log API response
  static void apiResponse(String endpoint, int statusCode, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag]' : '';
      final emoji = statusCode >= 200 && statusCode < 300 ? '✅' : '❌';
      debugPrint('$_prefix $emoji $tagStr Response: $statusCode - $endpoint');
    }
  }

  /// Log performance metric
  static void performance(String operation, Duration duration, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag]' : '';
      debugPrint('$_prefix ⏱️ $tagStr $operation took ${duration.inMilliseconds}ms');
    }
  }

  /// Log event
  static void event(String eventName, {Map<String, dynamic>? data, String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag]' : '';
      final dataStr = data != null ? ' - $data' : '';
      debugPrint('$_prefix 📊 $tagStr Event: $eventName$dataStr');
    }
  }
}
