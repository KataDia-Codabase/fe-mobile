import 'package:flutter/material.dart';

/// Design System Tokens for KataDia
/// Material Design 3 inspired design system
class DesignTokens {
  
  // Spacing
  static const double spacing2 = 8.0;
  static const double spacing4 = 16.0;
  static const double spacing8 = 32.0;
  static const double spacing12 = 48.0;
  static const double spacing16 = 64.0;
  static const double spacing20 = 80.0;
  static const double spacing24 = 96.0;

  // Border Radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radius2xl = 32.0;
  static const double radius3xl = 48.0;
  static const double radiusFull = 9999.0;

  // Typography
  static const String primaryFont = 'Inter';
  static const double fontSizeXs = 12.0;
  static const double fontSizeSm = 14.0;
  static const double fontSizeBase = 16.0;
  static const double fontSizeLg = 18.0;
  static const double fontSizeXl = 20.0;
  static const double fontSize2xl = 24.0;
  static const double fontSize3xl = 30.0;
  static const double fontSize4xl = 36.0;
  static const double fontSize5xl = 48.0;

  // Font Weights
  static const FontWeight fontWeightLight = FontWeight.w300;
  static const FontWeight fontWeightNormal = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;
  static const FontWeight fontWeightBlack = FontWeight.w900;

  // Line Height
  static const double lineHeightTight = 1.2;
  static const double lineHeightSnug = 1.4;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.75;

  // Letter Spacing
  static const double letterSpacingTight = -0.5;
  static const double letterSpacingNormal = 0.0;
  static const double letterSpacingWide = 0.5;

  // Opacity
  static const double opacityDisabled = 0.38;
  static const double opacityHover = 0.04;
  static const double opacityFocus = 0.12;
  static const double opacityPressed = 0.12;
  static const double opacityDragged = 0.16;

  // Elevation
  static const double elevationXs = 1.0;
  static const double elevationSm = 2.0;
  static const double elevationMd = 4.0;
  static const double elevationLg = 8.0;
  static const double elevationXl = 16.0;

  // Shadow Colors
  static Color get shadowColor => Colors.black.withOpacity(0.1);
  static Color get shadowColorDark => Colors.black.withOpacity(0.2);

  // Border Width
  static const double borderWidthThin = 1.0;
  static const double borderWidthThick = 2.0;

  // Icon Sizes
  static const double iconSizeXs = 16.0;
  static const double iconSizeSm = 20.0;
  static const double iconSizeBase = 24.0;
  static const double iconSizeLg = 32.0;
  static const double iconSizeXl = 48.0;

  // Button Heights
  static const double buttonHeightSm = 32.0;
  static const double buttonHeightMd = 40.0;
  static const double buttonHeightLg = 48.0;
  static const double buttonHeightXl = 56.0;

  // Input Field Heights
  static const double inputHeightSm = 40.0;
  static const double inputHeightMd = 48.0;
  static const double inputHeightLg = 56.0;

  // Animation Durations
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 250);
  static const Duration durationSlow = Duration(milliseconds: 350);
  static const Duration durationSlowest = Duration(milliseconds: 500);

  // Animation Curves
  static const Curve curveEaseIn = Curves.easeIn;
  static const Curve curveEaseOut = Curves.easeOut;
  static const Curve curveEaseInOut = Curves.easeInOut;
  static const Curve curveBounceIn = Curves.bounceIn;
  static const Curve curveElasticOut = Curves.elasticOut;

  // Breakpoints (in logical pixels)
  static const double breakpointSm = 600.0;
  static const double breakpointMd = 960.0;
  static const double breakpointLg = 1280.0;
  static const double breakpointXl = 1536.0;
}

/// Spacing extensions
extension SpacingExtensions on double {
  double get xs => this;
  double get sm => this * 2;
  double get md => this * 3;
  double get lg => this * 4;
  double get xl => this * 6;
  double get xxl => this * 8;
}

/// Typography extensions for consistent text styling
extension TextStyling on TextStyle {
  TextStyle xs() => copyWith(fontSize: DesignTokens.fontSizeXs);
  TextStyle sm() => copyWith(fontSize: DesignTokens.fontSizeSm);
  TextStyle base() => copyWith(fontSize: DesignTokens.fontSizeBase);
  TextStyle lg() => copyWith(fontSize: DesignTokens.fontSizeLg);
  TextStyle xl() => copyWith(fontSize: DesignTokens.fontSizeXl);
  TextStyle xxl() => copyWith(fontSize: DesignTokens.fontSize2xl);
  TextStyle xxxl() => copyWith(fontSize: DesignTokens.fontSize3xl);
  TextStyle xxxxl() => copyWith(fontSize: DesignTokens.fontSize4xl);
  TextStyle xxxxxl() => copyWith(fontSize: DesignTokens.fontSize5xl);

  TextStyle light() => copyWith(fontWeight: DesignTokens.fontWeightLight);
  TextStyle normal() => copyWith(fontWeight: DesignTokens.fontWeightNormal);
  TextStyle medium() => copyWith(fontWeight: DesignTokens.fontWeightMedium);
  TextStyle semiBold() => copyWith(fontWeight: DesignTokens.fontWeightSemiBold);
  TextStyle bold() => copyWith(fontWeight: DesignTokens.fontWeightBold);
  TextStyle black() => copyWith(fontWeight: DesignTokens.fontWeightBlack);

  TextStyle tight() => copyWith(height: DesignTokens.lineHeightTight);
  TextStyle snug() => copyWith(height: DesignTokens.lineHeightSnug);
  TextStyle normalHeight() => copyWith(height: DesignTokens.lineHeightNormal);
  TextStyle relaxed() => copyWith(height: DesignTokens.lineHeightRelaxed);

  TextStyle letterSpacingTight() => copyWith(letterSpacing: DesignTokens.letterSpacingTight);
  TextStyle letterSpacingWide() => copyWith(letterSpacing: DesignTokens.letterSpacingWide);
}
