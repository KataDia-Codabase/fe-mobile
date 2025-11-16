import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  // Font Family
  static const String fontFamily = 'Inter';
  
  // Headline Styles
  static TextStyle get headline1 => TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
  );
  
  static TextStyle get headline2 => TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: -0.25,
  );
  
  static TextStyle get headline3 => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  
  static TextStyle get headline4 => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  
  static TextStyle get headline5 => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  
  static TextStyle get headline6 => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  
  // Body Text Styles
  static TextStyle get bodyLarge => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.15,
  );
  
  static TextStyle get bodyMedium => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.25,
  );
  
  static TextStyle get bodySmall => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.4,
  );
  
  // Label Styles
  static TextStyle get labelLarge => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.1,
  );
  
  static TextStyle get labelMedium => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.5,
  );
  
  static TextStyle get labelSmall => TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.5,
  );
  
  // Button Text Styles
  static TextStyle get buttonLarge => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.5,
  );
  
  static TextStyle get buttonMedium => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.25,
  );
  
  static TextStyle get buttonSmall => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.25,
  );
  
  // Specialized Styles
  static TextStyle get appBarTitle => headline4.copyWith(
    fontWeight: FontWeight.w700,
  );
  
  static TextStyle get sectionTitle => headline5.copyWith(
    fontWeight: FontWeight.w600,
  );
  
  static TextStyle get cardTitle => headline6.copyWith(
    fontWeight: FontWeight.w600,
  );
  
  static TextStyle get caption => bodySmall.copyWith(
    color: Colors.grey[600],
    fontSize: 11.sp,
  );
  
  static TextStyle get overline => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    height: 1.6,
    letterSpacing: 1.5,
  );
  
  // Interactive Text Styles
  static TextStyle get link => bodyMedium.copyWith(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );
  
  static TextStyle get error => bodyMedium.copyWith(
    color: Colors.red,
  );
  
  static TextStyle get success => bodyMedium.copyWith(
    color: Colors.green,
  );
  
  // Language-specific Styles
  static TextStyle get indonesianText => bodyMedium.copyWith(
    fontFamily: fontFamily,
    // Add any Indonesian-specific typography adjustments here
  );
  
  static TextStyle get englishText => bodyMedium.copyWith(
    fontFamily: fontFamily,
    // Add any English-specific typography adjustments here
  );
}

extension TextStyleExtensions on TextStyle {
  /// Apply color to text style
  TextStyle withColor(Color color) => copyWith(color: color);
  
  /// Make text bold
  TextStyle bold() => copyWith(fontWeight: FontWeight.bold);
  
  /// Make text semibold
  TextStyle semibold() => copyWith(fontWeight: FontWeight.w600);
  
  /// Make text medium weight
  TextStyle medium() => copyWith(fontWeight: FontWeight.w500);
  
  /// Apply underline
  TextStyle underline() => copyWith(decoration: TextDecoration.underline);
  
  /// Apply line-through
  TextStyle lineThrough() => copyWith(decoration: TextDecoration.lineThrough);
  
  /// Apply italic
  TextStyle italic() => copyWith(fontStyle: FontStyle.italic);
}
