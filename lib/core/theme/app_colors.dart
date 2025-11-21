import 'package:flutter/material.dart';

/// Centralized color palette for the entire KataDia application
/// All colors should be referenced from here to maintain consistency
class AppColors {
  // ==================== PRIMARY COLORS ====================
  
  /// Primary blue color - used for main actions and highlights
  static const Color primary = Color(0xFF2F6BFF);
  
  /// Primary blue light - used in gradients and overlays
  static const Color primaryLight = Color(0xFF155DFC);
  
  /// Primary blue dark - used in gradients and hover states
  static const Color primaryDark = Color(0xFF1447E6);

  // ==================== SECONDARY COLORS ====================
  
  /// Accent yellow - used for XP, badges, and highlights
  static const Color accentYellow = Color(0xFFFFC94A);
  
    /// Accent yellow dark - used when stronger contrast is needed on warm surfaces
    static const Color accentYellowDark = Color(0xFFE39B05);
  
  /// Accent purple - used for AI Chat and premium features
  static const Color accentPurple = Color(0xFF9333EA);
  
  /// Accent green - used for success states and progress
  static const Color accentGreen = Color(0xFF10B981);

  // ==================== TEXT COLORS ====================
  
  /// Dark text color - used for headings and primary text
  static const Color textDark = Color(0xFF0F172A);
  
  /// Medium text color - used for secondary text
  static const Color textMedium = Color(0xFF7C89A2);
  
  /// Light text color - used for tertiary text and hints
  static const Color textLight = Color(0xFFB1B7C8);

  // ==================== BACKGROUND COLORS ====================
  
  /// Light background - main app background
  static const Color bgLight = Color(0xFFF4F7FD);
  
  /// Surface color - for cards and containers
  static const Color surface = Colors.white;
  
  /// Light gray background - for disabled states
  static const Color bgDisabled = Color(0xFFF3F4F6);

  // ==================== BORDER & DIVIDER COLORS ====================
  
  /// Light border color - for input fields and dividers
  static const Color borderLight = Color(0xFFE5E7EB);
  
  /// Medium border color - for emphasis
  static const Color borderMedium = Color(0xFFD6DBE8);

  // ==================== SEMANTIC COLORS ====================
  
  /// Error/negative actions
  static const Color error = Color(0xFFEA4335);
  
  /// Success states
  static const Color success = Color(0xFF10B981);
  
  /// Warning states
  static const Color warning = Color(0xFFFFC94A);
  
  /// Info states
  static const Color info = Color(0xFF2F6BFF);

  // ==================== SPECIAL COLORS ====================
  
  /// Google branding color
  static const Color google = Color(0xFF4285F4);
  
  /// Facebook branding color
  static const Color facebook = Color(0xFF1877F2);

  // ==================== TRANSPARENCY HELPERS ====================
  
  /// Create primary color with custom alpha
  static Color primaryWithAlpha(double alpha) =>
      primary.withValues(alpha: alpha);

  /// Create white with custom alpha
  static Color whiteWithAlpha(double alpha) =>
      Colors.white.withValues(alpha: alpha);

  /// Create dark color with custom alpha (for shadows)
  static Color darkWithAlpha(double alpha) =>
      textDark.withValues(alpha: alpha);

  /// Gradient from primary light to dark
  static LinearGradient get primaryGradient => const LinearGradient(
        colors: [primaryLight, primaryDark],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  // ==================== SHADOW COLORS ====================
  
  /// Light shadow color (for cards)
  static Color get shadowLight => darkWithAlpha(0.08);

  /// Medium shadow color (for elevated containers)
  static Color get shadowMedium => darkWithAlpha(0.12);

  /// Dark shadow color (for high elevation)
  static Color get shadowDark => darkWithAlpha(0.15);
}
