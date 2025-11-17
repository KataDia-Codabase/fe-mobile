import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralized text styles for consistent typography across the app
/// Use these instead of creating TextStyle inline
class AppTextStyles {
  // ==================== HEADINGS ====================
  
  /// Heading 1 - Large titles (28px, bold)
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    height: 1.25,
  );

  /// Heading 2 - Medium titles (24px, bold)
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    height: 1.3,
  );

  /// Heading 3 - Small titles (20px, bold)
  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    height: 1.35,
  );

  // ==================== BODY TEXT ====================
  
  /// Body Large (15px, semi-bold) - for important body text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
    height: 1.5,
  );

  /// Body Medium (14px, regular) - standard body text
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
    height: 1.5,
  );

  /// Body Small (12px, regular) - for smaller body text
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textMedium,
    height: 1.5,
  );

  // ==================== LABELS ====================
  
  /// Label Large (14px, semi-bold)
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  /// Label Medium (13px, semi-bold)
  static const TextStyle labelMedium = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textMedium,
  );

  /// Label Small (12px, medium)
  static const TextStyle labelSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textMedium,
  );

  // ==================== BUTTON TEXT ====================
  
  /// Button text (17px, semi-bold)
  static const TextStyle button = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  /// Small button text (14px, semi-bold)
  static const TextStyle buttonSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // ==================== CAPTION & HELPER TEXT ====================
  
  /// Caption text (11px, regular) - for hints and helpers
  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textLight,
  );

  // ==================== BADGE & SPECIAL ====================
  
  /// Badge text (24px, bold) - for CEFR level badge
  static const TextStyle badge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  /// Stat value text (16px, bold) - for XP, streak display
  static const TextStyle statValue = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  // ==================== VARIANTS ====================
  
  /// Disabled text color variant
  static const TextStyle disabledText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textLight,
  );

  /// Hint text for input fields
  static const TextStyle hintText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textLight,
  );

  /// Error text
  static const TextStyle errorText = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.error,
  );

  /// Success text
  static const TextStyle successText = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.success,
  );

  /// Primary colored text
  static const TextStyle primaryText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  // ==================== HELPER METHODS ====================
  
  /// Create text style with custom color
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Create text style with custom size
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }

  /// Create text style with custom weight
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  /// Create text style with custom height
  static TextStyle withHeight(TextStyle style, double height) {
    return style.copyWith(height: height);
  }
}
