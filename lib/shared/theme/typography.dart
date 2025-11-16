import 'package:flutter/material.dart';
import 'package:katadia_app/core/constants/design_tokens.dart';

class AppTypography {
  AppTypography._(); // Private constructor
  
  // Text Styles for different use cases
  
  /// Display text styles
  static TextStyle get displayLarge => TextStyle(
    fontSize: DesignTokens.fontSize5xl,
    fontWeight: DesignTokens.fontWeightBold,
    letterSpacing: DesignTokens.letterSpacingNormal,
    height: DesignTokens.lineHeightTight,
  );
  
  static TextStyle get displayMedium => TextStyle(
    fontSize: DesignTokens.fontSize4xl,
    fontWeight: DesignTokens.fontWeightBold,
    letterSpacing: DesignTokens.letterSpacingNormal,
    height: DesignTokens.lineHeightTight,
  );
  
  static TextStyle get displaySmall => TextStyle(
    fontSize: DesignTokens.fontSize3xl,
    fontWeight: DesignTokens.fontWeightSemiBold,
    letterSpacing: DesignTokens.letterSpacingNormal,
    height: DesignTokens.lineHeightTight,
  );
  
  /// Headline text styles
  static TextStyle get headlineLarge => TextStyle(
    fontSize: DesignTokens.fontSize2xl,
    fontWeight: DesignTokens.fontWeightSemiBold,
    letterSpacing: DesignTokens.letterSpacingNormal,
    height: DesignTokens.lineHeightSnug,
  );
  
  static TextStyle get headlineMedium => TextStyle(
    fontSize: DesignTokens.fontSizeXl,
    fontWeight: DesignTokens.fontWeightSemiBold,
    letterSpacing: DesignTokens.letterSpacingNormal,
    height: DesignTokens.lineHeightSnug,
  );
  
  static TextStyle get headlineSmall => TextStyle(
    fontSize: DesignTokens.fontSizeLg,
    fontWeight: DesignTokens.fontWeightSemiBold,
    letterSpacing: DesignTokens.letterSpacingNormal,
    height: DesignTokens.lineHeightSnug,
  );
  
  /// Title text styles
  static TextStyle get titleLarge => TextStyle(
    fontSize: DesignTokens.fontSizeXl,
    fontWeight: DesignTokens.fontWeightMedium,
    letterSpacing: DesignTokens.letterSpacingNormal,
    height: DesignTokens.lineHeightSnug,
  );
  
  static TextStyle get titleMedium => TextStyle(
    fontSize: DesignTokens.fontSizeLg,
    fontWeight: DesignTokens.fontWeightMedium,
    letterSpacing: DesignTokens.letterSpacingNormal,
    height: DesignTokens.lineHeightSnug,
  );
  
  static TextStyle get titleSmall => TextStyle(
    fontSize: DesignTokens.fontSizeBase,
    fontWeight: DesignTokens.fontWeightMedium,
    letterSpacing: DesignTokens.letterSpacingNormal,
    height: DesignTokens.lineHeightSnug,
  );
  
  /// Body text styles
  static TextStyle get bodyLarge => TextStyle(
    fontSize: DesignTokens.fontSizeLg,
    fontWeight: DesignTokens.fontWeightNormal,
    letterSpacing: DesignTokens.letterSpacingNormal,
    height: DesignTokens.lineHeightNormal,
  );
  
  static TextStyle get bodyMedium => TextStyle(
    fontSize: DesignTokens.fontSizeBase,
    fontWeight: DesignTokens.fontWeightNormal,
    letterSpacing: DesignTokens.letterSpacingNormal,
    height: DesignTokens.lineHeightNormal,
  );
  
  static TextStyle get bodySmall => TextStyle(
    fontSize: DesignTokens.fontSizeSm,
    fontWeight: DesignTokens.fontWeightNormal,
    letterSpacing: DesignTokens.letterSpacingNormal,
    height: DesignTokens.lineHeightNormal,
  );
  
  /// Label text styles
  static TextStyle get labelLarge => TextStyle(
    fontSize: DesignTokens.fontSizeBase,
    fontWeight: DesignTokens.fontWeightMedium,
    letterSpacing: DesignTokens.letterSpacingWide,
    height: DesignTokens.lineHeightTight,
  );
  
  static TextStyle get labelMedium => TextStyle(
    fontSize: DesignTokens.fontSizeSm,
    fontWeight: DesignTokens.fontWeightMedium,
    letterSpacing: DesignTokens.letterSpacingWide,
    height: DesignTokens.lineHeightTight,
  );
  
  static TextStyle get labelSmall => TextStyle(
    fontSize: DesignTokens.fontSizeXs,
    fontWeight: DesignTokens.fontWeightMedium,
    letterSpacing: DesignTokens.letterSpacingWide,
    height: DesignTokens.lineHeightTight,
  );
}

/// TextTheme for the app
class AppTextTheme {
  static TextTheme get lightTheme => TextTheme(
    // Display styles
    displayLarge: AppTypography.displayLarge.copyWith(
      color: Colors.black87,
    ),
    displayMedium: AppTypography.displayMedium.copyWith(
      color: Colors.black87,
    ),
    displaySmall: AppTypography.displaySmall.copyWith(
      color: Colors.black87,
    ),
    
    // Headline styles
    headlineLarge: AppTypography.headlineLarge.copyWith(
      color: Colors.black87,
    ),
    headlineMedium: AppTypography.headlineMedium.copyWith(
      color: Colors.black87,
    ),
    headlineSmall: AppTypography.headlineSmall.copyWith(
      color: Colors.black87,
    ),
    
    // Title styles
    titleLarge: AppTypography.titleLarge.copyWith(
      color: Colors.black87,
    ),
    titleMedium: AppTypography.titleMedium.copyWith(
      color: Colors.black87,
    ),
    titleSmall: AppTypography.titleSmall.copyWith(
      color: Colors.black87,
    ),
    
    // Body styles
    bodyLarge: AppTypography.bodyLarge.copyWith(
      color: Colors.black87,
    ),
    bodyMedium: AppTypography.bodyMedium.copyWith(
      color: Colors.black87,
    ),
    bodySmall: AppTypography.bodySmall.copyWith(
      color: Colors.black54,
    ),
    
    // Label styles
    labelLarge: AppTypography.labelLarge.copyWith(
      color: Colors.black54,
    ),
    labelMedium: AppTypography.labelMedium.copyWith(
      color: Colors.black54,
    ),
    labelSmall: AppTypography.labelSmall.copyWith(
      color: Colors.black54,
    ),
  );
  
  static TextTheme get darkTheme => TextTheme(
    // Display styles
    displayLarge: AppTypography.displayLarge.copyWith(
      color: Colors.white,
    ),
    displayMedium: AppTypography.displayMedium.copyWith(
      color: Colors.white,
    ),
    displaySmall: AppTypography.displaySmall.copyWith(
      color: Colors.white,
    ),
    
    // Headline styles
    headlineLarge: AppTypography.headlineLarge.copyWith(
      color: Colors.white,
    ),
    headlineMedium: AppTypography.headlineMedium.copyWith(
      color: Colors.white,
    ),
    headlineSmall: AppTypography.headlineSmall.copyWith(
      color: Colors.white,
    ),
    
    // Title styles
    titleLarge: AppTypography.titleLarge.copyWith(
      color: Colors.white,
    ),
    titleMedium: AppTypography.titleMedium.copyWith(
      color: Colors.white,
    ),
    titleSmall: AppTypography.titleSmall.copyWith(
      color: Colors.white,
    ),
    
    // Body styles
    bodyLarge: AppTypography.bodyLarge.copyWith(
      color: Colors.white.withOpacity(0.87),
    ),
    bodyMedium: AppTypography.bodyMedium.copyWith(
      color: Colors.white.withOpacity(0.87),
    ),
    bodySmall: AppTypography.bodySmall.copyWith(
      color: Colors.white.withOpacity(0.60),
    ),
    
    // Label styles
    labelLarge: AppTypography.labelLarge.copyWith(
      color: Colors.white.withOpacity(0.60),
    ),
    labelMedium: AppTypography.labelMedium.copyWith(
      color: Colors.white.withOpacity(0.60),
    ),
    labelSmall: AppTypography.labelSmall.copyWith(
      color: Colors.white.withOpacity(0.60),
    ),
  );
}


extension TypographyHelpers on TextTheme {
  TextStyle get h1 => headlineLarge!;
  TextStyle get h2 => headlineMedium!;
  TextStyle get h3 => headlineSmall!;
  TextStyle get h4 => titleLarge!;
  TextStyle get h5 => titleMedium!;
  TextStyle get h6 => titleSmall!;
  TextStyle get subtitle1 => bodyLarge!;
  TextStyle get subtitle2 => bodyMedium!;
  TextStyle get caption => labelSmall!;
  TextStyle get overline => labelMedium!;
  
  TextStyle get title => titleMedium!;
  TextStyle get body => bodyMedium!;
  TextStyle get label => labelMedium!;
  
  TextStyle get buttonText => labelLarge!.copyWith(
    fontWeight: DesignTokens.fontWeightSemiBold,
  );
}
