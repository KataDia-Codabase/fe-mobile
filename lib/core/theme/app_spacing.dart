/// Centralized spacing and sizing system
/// All spacing should use multiples of 4 or 8 for consistency
class AppSpacing {
  // ==================== PADDING & MARGINS ====================
  
  /// Extra small spacing (4px)
  static const double xs = 4.0;
  
  /// Small spacing (8px)
  static const double sm = 8.0;
  
  /// Medium spacing (12px)
  static const double md = 12.0;
  
  /// Large spacing (16px)
  static const double lg = 16.0;
  
  /// Extra large spacing (20px)
  static const double xl = 20.0;
  
  /// Double extra large spacing (24px)
  static const double xxl = 24.0;
  
  /// Triple extra large spacing (32px)
  static const double xxxl = 32.0;

  // ==================== BORDER RADIUS ====================
  
  /// Small border radius (8px) - buttons, small components
  static const double radiusSmall = 8.0;
  
  /// Medium border radius (12px) - input fields, small cards
  static const double radiusMedium = 12.0;
  
  /// Large border radius (16px) - cards, dialogs
  static const double radiusLarge = 16.0;
  
  /// Extra large border radius (20px) - large containers
  static const double radiusXL = 20.0;
  
  /// Full rounded (24px) - circular buttons, badges
  static const double radiusFull = 24.0;

  // ==================== ICON & COMPONENT SIZES ====================
  
  /// Icon small (20px) - for compact UIs
  static const double iconSmall = 20.0;
  
  /// Icon medium (24px) - standard icon size
  static const double iconMedium = 24.0;
  
  /// Icon large (28px) - prominent icons
  static const double iconLarge = 28.0;
  
  /// Icon extra large (32px) - emphasis icons
  static const double iconXL = 32.0;
  
  /// Icon extra extra large (36px) - large icons
  static const double iconXXL = 36.0;

  // ==================== BUTTON HEIGHTS ====================
  
  /// Small button height (40px)
  static const double buttonSmall = 40.0;
  
  /// Standard button height (48px)
  static const double buttonMedium = 48.0;
  
  /// Large button height (56px)
  static const double buttonLarge = 56.0;

  // ==================== INPUT FIELD HEIGHTS ====================
  
  /// Input field height
  static const double inputHeight = 48.0;

  // ==================== CARD PADDING ====================
  
  /// Compact card padding
  static const double cardPaddingCompact = 12.0;
  
  /// Standard card padding
  static const double cardPaddingStandard = 16.0;
  
  /// Comfortable card padding
  static const double cardPaddingComfortable = 20.0;

  // ==================== CONTAINER SIZES ====================
  
  /// Small container/box (56x56)
  static const double containerSmall = 56.0;
  
  /// Medium container/box (60x60)
  static const double containerMedium = 60.0;
  
  /// Large container/box (80x80)
  static const double containerLarge = 80.0;

  // ==================== TOP/BOTTOM SHEET ====================
  
  /// Default top sheet corner radius
  static const double sheetRadius = 24.0;
  
  /// Default top sheet padding
  static const double sheetPadding = 24.0;

  // ==================== SHADOW ELEVATION ====================
  
  /// Light shadow elevation (2dp)
  static const double elevationLight = 2.0;
  
  /// Medium shadow elevation (4dp)
  static const double elevationMedium = 4.0;
  
  /// Standard shadow elevation (8dp)
  static const double elevationStandard = 8.0;

  // ==================== ANIMATION DURATIONS ====================
  
  /// Fast animation (250ms)
  static const Duration animationFast = Duration(milliseconds: 250);
  
  /// Standard animation (300ms)
  static const Duration animationStandard = Duration(milliseconds: 300);
  
  /// Slow animation (500ms)
  static const Duration animationSlow = Duration(milliseconds: 500);
}
