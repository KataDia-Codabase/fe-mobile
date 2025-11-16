import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors
  static const Color primary = Color(0xFF2E7D32); // Material Green 800
  static const Color primaryVariant = Color(0xFF1B5E20); // Material Green 900
  static const Color secondary = Color(0xFF1976D2); // Material Blue 700
  static const Color secondaryVariant = Color(0xFF1565C0); // Material Blue 800

  // Neutral Colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF5F5F5);
  static const Color card = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFD32F2F);
  static const Color onError = Color(0xFFFFFFFF);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFFBDBDBD);
  
  // Border Colors
  static const Color borderColor = Color(0xFFE0E0E0);
  
  // Success/Warning/Info Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // CEFR Level Colors
  static const Color cefrA1 = Color(0xFF4CAF50);
  static const Color cefrA2 = Color(0xFF8BC34A);
  static const Color cefrB1 = Color(0xFFFFC107);
  static const Color cefrB2 = Color(0xFFFF9800);
  static const Color cefrC1 = Color(0xFFF44336);
  static const Color cefrC2 = Color(0xFFD32F2F);
  
  // Content Type Colors
  static const Color pronunciationColor = Color(0xFF2196F3);
  
  // Category Colors
  static const Color vocabularyColor = Color(0xFF9C27B0);
  static const Color grammarColor = Color(0xFF1976D2);
  static const Color phrasesColor = Color(0xFFFF9800);
  static const Color conversationColor = Color(0xFFE91E63);
  static const Color listeningColor = Color(0xFF00BCD4);
  
  // Difficulty Colors
  static const Color difficultyEasy = Color(0xFF4CAF50);
  static const Color difficultyMedium = Color(0xFFFF9800);
  static const Color difficultyHard = Color(0xFFF44336);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryVariant],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryVariant],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Semi-transparent Colors
  static Color primaryWithOpacity(double opacity) => primary.withOpacity(opacity);
  static Color blackWithOpacity(double opacity) => Colors.black.withOpacity(opacity);
  static Color whiteWithOpacity(double opacity) => Colors.white.withOpacity(opacity);
  
  // Language-specific Colors (for Indonesian/English differentiation)
  static const Color indonesianAccent = Color(0xFFE53935); // Red for Indonesian
  static const Color englishAccent = Color(0xFF1E88E5); // Blue for English
}

extension ColorExtensions on Color {
  /// Lighten a color by [percent] amount (0.0 to 1.0)
  Color lighten(double percent) {
    assert(percent >= 0 && percent <= 1, 'Percent must be between 0 and 1');
    
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness((hsl.lightness + percent).clamp(0.0, 1.0)).toColor();
  }
  
  /// Darken a color by [percent] amount (0.0 to 1.0)
  Color darken(double percent) {
    assert(percent >= 0 && percent <= 1, 'Percent must be between 0 and 1');
    
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness((hsl.lightness - percent).clamp(0.0, 1.0)).toColor();
  }
}
