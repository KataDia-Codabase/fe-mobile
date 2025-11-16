import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katadia_app/core/constants/design_tokens.dart';
import 'package:katadia_app/shared/theme/app_colors.dart';
import 'package:katadia_app/shared/theme/spacing.dart';


/// Primary elevated button component
class PrimaryButton extends ConsumerWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final double? width;
  final IconData? icon;
  final TextStyle? textStyle;

  const PrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.icon,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      elevation: isDisabled ? 0 : Elevation.md,
      borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      color: isDisabled ? Colors.grey.shade300 : AppColors.primary,
      child: InkWell(
        onTap: isDisabled ? null : onPressed,
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        child: SizedBox(
          width: width,
          height: Sizes.buttonHeightLg,
          child: _buildButtonContent(context),
        ),
      ),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    if (isLoading) {
      return Center(
        child: SizedBox(
          width: 16.w,
          height: 16.w,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white.withOpacity(0.8),
            ),
            strokeWidth: 2,
          ),
        ),
      );
    }

    List<Widget> content = [];
    
    if (icon != null) {
      content.add(
        Icon(
          icon,
          size: 18.w,
          color: Colors.white,
        ),
      );
    }
    
    if (text.isNotEmpty) {
      if (icon != null) {
        content.add(SizedBox(width: 8.w));
      }
      content.add(
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: textStyle ?? Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Colors.white,
              fontWeight: DesignTokens.fontWeightSemiBold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: content,
    );
  }
}

/// Outlined button component
class OutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final double? width;
  final IconData? icon;
  final TextStyle? textStyle;

  const OutlinedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.icon,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : onPressed,
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        child: Container(
          width: width,
          height: Sizes.buttonHeightLg,
          decoration: BoxDecoration(
            border: Border.all(
              color: isDisabled ? Colors.grey.shade300 : AppColors.primary,
              width: DesignTokens.borderWidthThick,
            ),
            borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
          ),
          child: isLoading
              ? Center(
                  child: SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      strokeWidth: 2,
                    ),
                  ),
                )
              : _buildButtonContent(context),
        ),
      ),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    List<Widget> content = [];
    
    if (icon != null) {
      content.add(
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Icon(icon, size: 16.w, color: AppColors.primary),
        ),
      );
    }
    
    content.add(
      Text(
        text,
        textAlign: TextAlign.center,
        style: textStyle ?? Theme.of(context).textTheme.labelLarge!.copyWith(
          color: AppColors.primary,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: content,
    );
  }
}

class TextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final TextStyle? textStyle;

  const TextButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isDisabled = false,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Text(
        text,
        style: textStyle ?? Theme.of(context).textTheme.labelMedium?.copyWith(
          color: isDisabled ? Colors.grey.shade400 : AppColors.primary,
          fontWeight: DesignTokens.fontWeightSemiBold,
        ),
      ),
    );
  }
}

/// Icon button component
class IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final double? size;
  final Color? color;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  const IconButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.size,
    this.color,
    this.backgroundColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonSize = size ?? 40.w;
    final btnColor = color ?? (isDisabled ? Colors.grey.shade400 : AppColors.primary);
    final bgColor = backgroundColor ?? (isDisabled ? Colors.transparent : btnColor);

    return Material(
      color: bgColor,
      shape: CircleBorder(),
      elevation: backgroundColor == Colors.transparent ? 0 : Elevation.sm,
      child: InkWell(
        onTap: isDisabled || isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(buttonSize / 2),
        child: Container(
          width: buttonSize,
          height: buttonSize,
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white.withOpacity(0.8),
                      ),
                      strokeWidth: 2,
                    ),
                  )
                : Icon(
                    icon,
                    size: (buttonSize * 0.5),
                    color: isDisabled ? Colors.grey.shade400 : Colors.white,
                  ),
          ),
        ),
      ),
    );
  }
}

/// Custom elevated button with builder function
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double? height;
  final Widget? child;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final bool isLoading;
  final bool isDisabled;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height,
    this.child,
    this.textStyle,
    this.borderRadius,
    this.isLoading = false,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: isDisabled ? 0 : Elevation.md,
      borderRadius: borderRadius ?? BorderRadius.circular(DesignTokens.radiusLg),
      color: backgroundColor ?? Theme.of(context).primaryColor,
      child: InkWell(
        onTap: isDisabled ? null : onPressed,
        borderRadius: borderRadius ?? BorderRadius.circular(DesignTokens.radiusLg),
        child: Container(
          width: width,
          height: height ?? Sizes.buttonHeightMd,
          child: child ?? _buildDefaultContent(context),
        ),
      ),
    );
  }

  Widget _buildDefaultContent(BuildContext context) {
    List<Widget> content = [];
    
    if (isLoading) {
      return Center(
        child: SizedBox(
          width: 16.w,
          height: 16.w,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              _getForegroundColor(),
            ),
            strokeWidth: 2,
          ),
        ),
      );
    }

    if (icon != null) {
      content.add(
        Icon(
          icon,
          size: 20.w,
          color: _getForegroundColor(),
        ),
      );
      content.add(SizedBox(width: 8.w));
    }

    content.add(
      Text(
        text,
        textAlign: TextAlign.center,
        style: textStyle ?? Theme.of(context).textTheme.labelLarge,
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: content,
    );
  }

  Color _getForegroundColor() {
    if (isDisabled) return Colors.grey.shade400;
    return foregroundColor ?? Colors.white;
  }
}
