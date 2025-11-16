import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Spacing {
  // Vertical spacing
  static double get spacingXs => 8.h;
  static double get spacingSm => 12.h;
  static double get spacingMd => 16.h;
  static double get spacingLg => 20.h;
  static double get spacingXl => 24.h;
  static double get spacing2xl => 32.h;
  
  // Horizontal spacing
  static double get spacingXsH => 8.w;
  static double get spacingSmH => 12.w;
  static double get spacingMdH => 16.w;
  static double get spacingLgH => 20.w;
  static double get spacingXlH => 24.w;
  static double get spacing2xlH => 32.w;
  
  // Small gaps
  static double get gapXs => 4.h;
  static double get gapSm => 6.h;
  static double get gapMd => 8.h;
  static double get gapLg => 12.h;
  
  // Horizontal gaps
  static double get gapXsH => 4.w;
  static double get gapSmH => 6.w;
  static double get gapMdH => 8.w;
  static double get gapLgH => 12.w;
  
  // Insets (padding/margin)
  static EdgeInsets get insetXs => EdgeInsets.all(8.w);
  static EdgeInsets get insetSm => EdgeInsets.all(12.w);
  static EdgeInsets get insetMd => EdgeInsets.all(16.w);
  static EdgeInsets get insetLg => EdgeInsets.all(20.w);
  static EdgeInsets get insetXl => EdgeInsets.all(24.w);
  static EdgeInsets get inset2xl => EdgeInsets.all(32.w);
  
  // Horizontal insets
  static EdgeInsets get insetHorizontalXs => EdgeInsets.symmetric(horizontal: 8.w);
  static EdgeInsets get insetHorizontalSm => EdgeInsets.symmetric(horizontal: 12.w);
  static EdgeInsets get insetHorizontalMd => EdgeInsets.symmetric(horizontal: 16.w);
  static EdgeInsets get insetHorizontalLg => EdgeInsets.symmetric(horizontal: 20.w);
  static EdgeInsets get insetHorizontalXl => EdgeInsets.symmetric(horizontal: 24.w);
  
  // Vertical insets
  static EdgeInsets get insetVerticalXs => EdgeInsets.symmetric(vertical: 8.h);
  static EdgeInsets get insetVerticalSm => EdgeInsets.symmetric(vertical: 12.h);
  static EdgeInsets get insetVerticalMd => EdgeInsets.symmetric(vertical: 16.h);
  static EdgeInsets get insetVerticalLg => EdgeInsets.symmetric(vertical: 20.h);
  static EdgeInsets get insetVerticalXl => EdgeInsets.symmetric(vertical: 24.h);
  
  // Card spacing
  static EdgeInsets get cardPadding => EdgeInsets.all(16.w);
  static EdgeInsets get cardPaddingSm => EdgeInsets.all(12.w);
  static double get cardSpacing => 12.h;
  
  // Button spacing
  static EdgeInsets get buttonPadding => EdgeInsets.symmetric(
    horizontal: 24.w,
    vertical: 12.h,
  );
  static EdgeInsets get buttonPaddingSm => EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 8.h,
  );
  
  // Input field spacing
  static EdgeInsets get inputPadding => EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 12.h,
  );
  static EdgeInsets get inputPaddingSm => EdgeInsets.symmetric(
    horizontal: 12.w,
    vertical: 8.h,
  );
  
  // Screen spacing helpers
  static EdgeInsets get screenPadding => EdgeInsets.all(16.w);
  static EdgeInsets get screenPaddingLg => EdgeInsets.all(24.w);
  
  // Section spacing
  static double get sectionSpacing => 24.h;
  static double get sectionSpacingSm => 16.h;
}

/// Radius helpers for consistent border radius
abstract class AppBorderRadius {
  static double get xs => 4.r;
  static double get sm => 8.r;
  static double get md => 12.r;
  static double get lg => 16.r;
  static double get xl => 20.r;
  static double get xxl => 24.r;
  static double get full => 9999.r;
  
  // Specific radius helpers
  static BorderRadius get cardRadius => BorderRadius.circular(lg.r);
  static BorderRadius get buttonRadius => BorderRadius.circular(md.r);
  static BorderRadius get inputRadius => BorderRadius.circular(md.r);
  static BorderRadius get chipRadius => BorderRadius.circular(sm.r);
  static BorderRadius get dialogRadius => BorderRadius.circular(xl.r);
}

/// Elevation helpers for consistent shadows
abstract class Elevation {
  static double get xs => 1.0;
  static double get sm => 2.0;
  static double get md => 4.0;
  static double get lg => 8.0;
  static double get xl => 16.0;
  
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withAlpha(20),
      blurRadius: xs,
      offset: const Offset(0, 2),
    ),
  ];
  
  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: Colors.black.withAlpha(38),
      blurRadius: xs,
      offset: const Offset(0, 2),
    ),
    BoxShadow(
      color: Colors.black.withAlpha(13),
      blurRadius: xs,
      offset: const Offset(0, 1),
    ),
  ];
  
  static List<BoxShadow> get floatingShadow => [
    BoxShadow(
      color: Colors.black.withAlpha(64),
      blurRadius: md,
      offset: const Offset(0, 8),
    ),
  ];
}

/// Size helpers for consistent dimensions
abstract class Sizes {
  // Icon sizes
  static double get iconXs => 12.w;
  static double get iconSm => 16.w;
  static double get iconMd => 20.w;
  static double get iconLg => 24.w;
  static double get iconXl => 32.w;
  
  // Avatar sizes
  static double get avatarSm => 32.w;
  static double get avatarMd => 48.w;
  static double get avatarLg => 64.w;
  static double get avatarXl => 96.w;
  
  // Component sizes
  static double get buttonHeightSm => 32.h;
  static double get buttonHeightMd => 40.h;
  static double get buttonHeightLg => 48.h;
  
  static double get inputHeightSm => 40.h;
  static double get inputHeightMd => 48.h;
  static double get inputHeightLg => 56.h;
  
  // Chip sizes
  static double get chipHeight => 32.h;
  static double get tabHeight => 40.h;
  
  // Card dimensions
  static double get cardHeight => 120.h;
  static double get cardCompactHeight => 80.h;
  
  // List item heights
  static double get listItemHeight => 56.h;
  static double get listItemCompactHeight => 40.h;
  static double get listItemTallHeight => 72.h;
  
  // Avatar list item
  static double get avatarListItemHeight => 56.h;
  static double get avatarListItemCompactHeight => 40.h;
}
