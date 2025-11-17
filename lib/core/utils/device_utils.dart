import 'package:flutter/material.dart';

/// Utility class for device and screen-related operations
class DeviceUtils {
  /// Get screen size
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Get screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get screen aspect ratio
  static double getScreenAspectRatio(BuildContext context) {
    return MediaQuery.of(context).size.aspectRatio;
  }

  /// Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Check if device is in portrait mode
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// Check if device is tablet
  static bool isTablet(BuildContext context) {
    return getScreenWidth(context) >= 600;
  }

  /// Check if device is phone
  static bool isPhone(BuildContext context) {
    return getScreenWidth(context) < 600;
  }

  /// Get device padding (status bar, notch, etc.)
  static EdgeInsets getDevicePadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Get device view insets (keyboard, etc.)
  static EdgeInsets getDeviceViewInsets(BuildContext context) {
    return MediaQuery.of(context).viewInsets;
  }

  /// Get device pixel ratio
  static double getDevicePixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  /// Get text scale factor
  static double getTextScaleFactor(BuildContext context) {
    // Returns 1.0 as default since textScaleFactor is deprecated
    // Use textScaler for more advanced text scaling in newer Flutter versions
    return 1.0;
  }

  /// Check if system is in dark mode
  static bool isDarkMode(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  /// Get status bar height
  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// Get bottom navigation bar height (including safe area)
  static double getBottomNavBarHeight(BuildContext context) {
    return kBottomNavigationBarHeight + MediaQuery.of(context).padding.bottom;
  }

  /// Get safe area padding
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Calculate responsive font size
  static double getResponsiveFontSize(
    BuildContext context,
    double baseFontSize, {
    double maxFontSize = double.infinity,
    double minFontSize = 0,
  }) {
    // Using 1.0 as default scale since textScaleFactor is deprecated
    final textScale = 1.0;
    final scaledSize = baseFontSize * textScale;

    return scaledSize.clamp(minFontSize, maxFontSize).toDouble();
  }

  /// Calculate responsive spacing
  static double getResponsiveSpacing(
    BuildContext context,
    double baseSpacing, {
    double maxSpacing = double.infinity,
  }) {
    final screenWidth = getScreenWidth(context);
    final ratio = screenWidth / 375; // Base iPhone width

    return (baseSpacing * ratio).clamp(0, maxSpacing).toDouble();
  }

  /// Get safe area insets
  static EdgeInsets getSafeAreaInsets(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Close keyboard
  static void closeKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Show snackbar
  static void showSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
      ),
    );
  }
}
