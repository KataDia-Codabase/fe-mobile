import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// Enhanced error handling system for production-ready applications
class EnhancedErrorHandler {
  static final Logger _logger = Logger();

  /// Show error snackbar with message
  static Future<void> showErrorSnackBar(
    BuildContext context, {
    required String message,
  }) async {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  /// Show error dialog with retry option
  static Future<void> showErrorDialog(
    BuildContext context, {
    required String title,
    required String message,
    String? retryButtonLabel,
    VoidCallback? onRetry,
  }) async {
    if (!context.mounted) return;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Close'),
            ),
            if (onRetry != null && retryButtonLabel != null)
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  onRetry();
                },
                child: Text(retryButtonLabel),
              ),
          ],
        );
      },
    );
  }

  /// Handle error with graceful degradation
  static Future<T?> handleErrorWithGracefulDegradation<T>({
    required BuildContext context,
    required String errorMessage,
    required Future<T> Function() function,
    T? fallbackResult,
  }) async {
    try {
      if (!context.mounted) return fallbackResult;

      return await function();
    } catch (e) {
      _logError('Error: $errorMessage', error: e.toString());
      
      if (context.mounted) {
        await showErrorSnackBar(
          context,
          message: 'An error occurred: $errorMessage',
        );
      }
      
      return fallbackResult;
    }
  }

  /// Log error with appropriate level
  static void _logError(
    String message, {
    String? error,
    bool force = false,
  }) {
    if (force) {
      _logger.e('$message${error != null ? ' - $error' : ''}');
    } else {
      _logger.d('$message${error != null ? ' - $error' : ''}');
    }
  }
}
