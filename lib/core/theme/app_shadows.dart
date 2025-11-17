import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralized shadow system for consistent depth across the app
/// Use these instead of creating BoxShadow inline
class AppShadows {
  // ==================== CARD SHADOWS ====================
  
  /// Light shadow (for cards, subtle depth)
  static final List<BoxShadow> light = [
    BoxShadow(
      color: AppColors.shadowLight,
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  /// Medium shadow (for elevated containers)
  static final List<BoxShadow> medium = [
    BoxShadow(
      color: AppColors.shadowMedium,
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  /// Dark shadow (for modal dialogs, high elevation)
  static final List<BoxShadow> dark = [
    BoxShadow(
      color: AppColors.shadowDark,
      blurRadius: 32,
      offset: const Offset(0, 12),
    ),
  ];

  // ==================== SPECIFIC COMPONENT SHADOWS ====================
  
  /// Top app bar shadow
  static final List<BoxShadow> appBar = [
    BoxShadow(
      color: AppColors.shadowLight,
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  /// Bottom navbar shadow (upward shadow)
  static final List<BoxShadow> navbar = [
    BoxShadow(
      color: AppColors.shadowLight,
      blurRadius: 12,
      offset: const Offset(0, -4),
    ),
  ];

  /// Floating action button shadow
  static final List<BoxShadow> fab = [
    BoxShadow(
      color: AppColors.shadowDark,
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  /// Input field shadow (subtle)
  static final List<BoxShadow> input = [
    BoxShadow(
      color: AppColors.darkWithAlpha(0.04),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  /// Hover/Elevated state shadow
  static final List<BoxShadow> hover = [
    BoxShadow(
      color: AppColors.shadowMedium,
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];

  /// Popup/Dropdown shadow
  static final List<BoxShadow> popup = [
    BoxShadow(
      color: AppColors.shadowDark,
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  /// Icon bubble shadow (floating elements)
  static final List<BoxShadow> bubble = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.25),
      blurRadius: 16,
      offset: const Offset(0, 10),
    ),
  ];

  // ==================== FLAT SHADOWS (NO OFFSET) ====================
  
  /// Flat light shadow (no offset, subtle)
  static final List<BoxShadow> flatLight = [
    BoxShadow(
      color: AppColors.shadowLight,
      blurRadius: 8,
      offset: Offset.zero,
    ),
  ];

  /// Flat medium shadow
  static final List<BoxShadow> flatMedium = [
    BoxShadow(
      color: AppColors.shadowMedium,
      blurRadius: 16,
      offset: Offset.zero,
    ),
  ];
}
