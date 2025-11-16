import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:katadia_app/core/constants/design_tokens.dart';
import 'package:katadia_app/shared/theme/app_colors.dart';
import 'package:katadia_app/shared/theme/spacing.dart';

/// Custom button widgets with consistent styling
class AppButtons extends StatelessWidget {
  const AppButtons({super.key});

  @override
  Widget build(BuildContext context) {
    // This class is mainly used for its static methods
    // The build method is implemented to satisfy StatelessWidget
    return const SizedBox.shrink();
  }

  /// Primary button with filled background
  static Widget primary({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    double? width,
    IconData? icon,
    TextStyle? textStyle,
    required BuildContext context,
  }) {
    return _ButtonBase(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      width: width,
      icon: icon,
      textStyle: textStyle,
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: isDisabled ? 0 : Elevation.md,
      context: context,
    );
  }

  /// Secondary button with outlined style
  static Widget secondary({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    double? width,
    IconData? icon,
    TextStyle? textStyle,
    required BuildContext context,
  }) {
    return _ButtonBase(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      width: width,
      icon: icon,
      textStyle: textStyle,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.primary,
      elevation: 0,
      border: BorderSide(
        color: isDisabled ? Colors.grey.shade300 : AppColors.primary,
        width: DesignTokens.borderWidthThick,
      ),
      context: context,
    );
  }

  /// Tertiary button with transparent background
  static Widget tertiary({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    double? width,
    IconData? icon,
    TextStyle? textStyle,
    required BuildContext context,
  }) {
    return _ButtonBase(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      width: width,
      icon: icon,
      textStyle: textStyle,
      backgroundColor: Colors.transparent,
      foregroundColor: isDisabled ? Colors.grey.shade400 : AppColors.primary,
      elevation: 0,
      context: context,
    );
  }

  /// Danger button with error styling
  static Widget danger({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    double? width,
    IconData? icon,
    TextStyle? textStyle,
    required BuildContext context,
  }) {
    return _ButtonBase(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      width: width,
      icon: icon,
      textStyle: textStyle,
      backgroundColor: AppColors.error,
      foregroundColor: Colors.white,
      elevation: isDisabled ? 0 : Elevation.md,
      context: context,
    );
  }

  /// Ghost button with semi-transparent background
  static Widget ghost({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    double? width,
    IconData? icon,
    TextStyle? textStyle,
    required BuildContext context,
  }) {
    return _ButtonBase(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      width: width,
      icon: icon,
      textStyle: textStyle,
      backgroundColor: AppColors.primary.withValues(alpha: 0.08),
      foregroundColor: AppColors.primary,
      elevation: 0,
      context: context,
    );
  }

  /// Icon button without text
  static Widget iconButton({
    required IconData icon,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    double? size,
    Color? color,
    Color? backgroundColor,
    double? elevation,
  }) {
    final buttonSize = size ?? 40.w;
    
    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: backgroundColor ?? (isDisabled ? Colors.grey.shade300 : (color ?? AppColors.primary)),
        shape: BoxShape.circle,
        boxShadow: elevation != null ? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: elevation,
            offset: const Offset(0, 2),
          ),
        ] : null,
      ),
      child: isLoading
          ? Container(
              width: 16.w,
              height: 16.w,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Icon(
              icon,
              size: (buttonSize * 0.5),
              color: isDisabled ? Colors.grey.shade400 : Colors.white,
            ),
    );
  }

  /// Text button with minimal styling
  static Widget textButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    TextStyle? textStyle,
  }) {
    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Text(
        text,
        style: textStyle ?? const TextStyle(
          color: AppColors.primary,
          fontWeight: DesignTokens.fontWeightSemiBold,
          letterSpacing: DesignTokens.letterSpacingWide,
        ),
      ),
    );
  }

  /// Custom button base implementation
  static Widget _ButtonBase({
    required String text,
    required VoidCallback onPressed,
    required bool isLoading,
    required bool isDisabled,
    double? width,
    IconData? icon,
    TextStyle? textStyle,
    required Color backgroundColor,
    required Color foregroundColor,
    required double elevation,
    BorderSide? border,
    required BuildContext context,
  }) {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      color: backgroundColor,
      child: InkWell(
        onTap: isDisabled ? null : onPressed,
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        child: SizedBox(
          width: width,
          height: Sizes.buttonHeightLg,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 18.w,
                  color: foregroundColor,
                ),
                SizedBox(width: text.isNotEmpty ? 8.w : 0),
              ],
              if (text.isNotEmpty) ...[
                if (isLoading) ...[
                  SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
                    ),
                  ),
                ] else
                  Text(
                    text,
                    style: textStyle ?? Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: foregroundColor,
                      fontWeight: DesignTokens.fontWeightSemiBold,
                    ) ?? Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: foregroundColor,
                      fontWeight: DesignTokens.fontWeightSemiBold,
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
