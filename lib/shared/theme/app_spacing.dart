import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSpacing {
  // Base spacing unit
  static double get base => 8.w;
  
  // Small spacings
  static double get xs => 2.w;
  static double get sm => 4.w;
  
  // Medium spacings
  static double get md => 8.w;
  static double get lg => 12.w;
  static double get xl => 16.w;
  
  // Large spacings
  static double get xxl => 24.w;
  static double get xxxl => 32.w;
  
  // Extra large spacings
  static double get huge => 48.w;
  static double get massive => 64.w;
  
  // Component-specific spacings
  static double get cardPadding => 16.w;
  static double get screenPadding => 24.w;
  static double get buttonPadding => 16.w;
  static double get iconPadding => 8.w;
  
  // List spacings
  static double get listItemSpacing => 8.w;
  static double get sectionSpacing => 24.w;
  static double get subsectionSpacing => 16.w;
  
  // Form spacings
  static double get fieldSpacing => 16.w;
  static double get labelSpacing => 4.w;
  static double get formSectionSpacing => 24.w;
  
  // Responsive spacings
  static double responsive(BuildContext context, double small, double large) {
    final isTablet = MediaQuery.of(context).size.width >= 768;
    return isTablet ? large : small;
  }
  
  // EdgeInsets shortcuts
  static EdgeInsets get allXs => EdgeInsets.all(xs);
  static EdgeInsets get allSm => EdgeInsets.all(sm);
  static EdgeInsets get allMd => EdgeInsets.all(md);
  static EdgeInsets get allLg => EdgeInsets.all(lg);
  static EdgeInsets get allXl => EdgeInsets.all(xl);
  static EdgeInsets get allXxl => EdgeInsets.all(xxl);
  
  static EdgeInsets get horizontalMd => EdgeInsets.symmetric(horizontal: md);
  static EdgeInsets get horizontalLg => EdgeInsets.symmetric(horizontal: lg);
  static EdgeInsets get horizontalXl => EdgeInsets.symmetric(horizontal: xl);
  static EdgeInsets get horizontalXxl => EdgeInsets.symmetric(horizontal: xxl);
  
  static EdgeInsets get verticalMd => EdgeInsets.symmetric(vertical: md);
  static EdgeInsets get verticalLg => EdgeInsets.symmetric(vertical: lg);
  static EdgeInsets get verticalXl => EdgeInsets.symmetric(vertical: xl);
  static EdgeInsets get verticalXxl => EdgeInsets.symmetric(vertical: xxl);
  
  static EdgeInsets get topXl => EdgeInsets.only(top: xl);
  static EdgeInsets get bottomXl => EdgeInsets.only(bottom: xl);
  static EdgeInsets get leftXl => EdgeInsets.only(left: xl);
  static EdgeInsets get rightXl => EdgeInsets.only(right: xl);
  
  static EdgeInsets get topXxl => EdgeInsets.only(top: xxl);
  static EdgeInsets get bottomXxl => EdgeInsets.only(bottom: xxl);
  
  // Common padding combinations
  static EdgeInsets get cardPaddingAll => EdgeInsets.all(cardPadding);
  static EdgeInsets get screenPaddingAll => EdgeInsets.all(screenPadding);
  static EdgeInsets get buttonPaddingHorizontal => EdgeInsets.symmetric(horizontal: buttonPadding);
  static EdgeInsets get safeAreaPadding => EdgeInsets.fromLTRB(
    screenPadding,
    MediaQueryData().viewPadding.top + 16.w,
    screenPadding,
    MediaQueryData().viewPadding.bottom + 16.w,
  );
}


