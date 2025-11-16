import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:katadia_app/core/constants/design_tokens.dart';
import 'package:katadia_app/shared/theme/app_colors.dart';
import 'package:katadia_app/shared/theme/spacing.dart';

class LoadingSkeleton extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final Widget? child;
  final bool showAvatar;

  const LoadingSkeleton({
    super.key,
    this.height,
    this.width,
    this.color,
    this.borderRadius,
    this.padding,
    this.child,
    this.showAvatar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? Spacing.insetMd,
      decoration: BoxDecoration(
        color: color ?? Colors.grey[200]!,
        borderRadius: borderRadius ?? BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showAvatar) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[300]!,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Container(
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300]!,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
          ],
          if (child != null) ...[
            Expanded(child: child!),
          ] else ...[
            Container(
              height: 12.h,
              decoration: BoxDecoration(
                color: Colors.grey[200]!,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              height: 16.h,
              decoration: BoxDecoration(
                color: Colors.grey[200]!,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Skeleton for avatar with default placeholder
  static Widget avatar({
    Key? key,
    double? size,
  }) {
    return Container(
      width: size ?? 48.w,
      height: size ?? 48.w,
      decoration: BoxDecoration(
        color: Colors.grey[300]!,
        shape: BoxShape.circle,
      ),
    );
  }

  /// Skeleton for text content
  static Widget text({
    Key? key,
    double? width,
    double? height,
    String? text,
    TextStyle? textStyle,
    required BuildContext context,
  }) {
    return Container(
      width: width,
      height: height ?? 16.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.grey[200]!,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        text ?? '',
        style: textStyle ?? Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.transparent,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// Skeleton for image placeholder
  static Widget image({
    Key? key,
    double? width,
    double? height,
  }) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 200.h,
      decoration: BoxDecoration(
        color: Colors.grey[200]!,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image, size: 32.w, color: Colors.grey[400]),
            SizedBox(height: 8.h),
            Text(
              'Image',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Skeleton for audio player placeholder
  static Widget audio({
    Key? key,
    double? width,
    double? height,
  }) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 60.h,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_arrow, size: 20.w, color: AppColors.primary),
            SizedBox(width: 8.w),
            Text(
              'Audio Loading...',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Skeleton for video player placeholder
  static Widget video({
    Key? key,
    double? width,
    double? height,
  }) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 120.h,
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_circle_filled, size: 32.w, color: AppColors.secondary),
            SizedBox(height: 8.h),
            Text(
              'Video Loading...',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Skeleton for card components
  static Widget card({
    Key? key,
    double? width,
    double? height,
    bool showAvatar = false,
    double avatarSize = 48,
  }) {
    return Container(
      width: width,
      height: height ?? 120.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: Elevation.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showAvatar) ...[
            Row(
              children: [
                LoadingSkeleton.avatar(size: avatarSize.w),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 6.h,
                        margin: EdgeInsets.only(bottom: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.grey[200]!,
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 8.h,
                  margin: EdgeInsets.only(bottom: 4.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200]!,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                Container(
                  height: 8.h,
                  margin: EdgeInsets.only(bottom: 4.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200]!,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[200]!,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Skeleton for list items
  static Widget listItem({
    Key? key,
    double? height,
    bool showAvatar = false,
    double avatarSize = 40,
    bool showTitle = true,
    bool showSubtitle = false,
    String? title,
    String? subtitle,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      height: height ?? Sizes.listItemHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showAvatar) ...[
            LoadingSkeleton.avatar(size: avatarSize.w),
            SizedBox(width: 12.w),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showTitle) ...[
                  Container(
                    height: showSubtitle ? 16.h : 20.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[200]!,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      title ?? 'Loading...',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.transparent,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
                if (showSubtitle) ...[
                  SizedBox(height: 4.h),
                  Container(
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[200]!,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      subtitle ?? 'Loading...',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.transparent,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Grid item skeleton with customizable dimensions
  static Widget gridItem({
    Key? key,
    double? height,
    double? width,
    bool hasImage = true,
    String? title,
    String? subtitle,
  }) {
    return Container(
      height: height ?? 100.h,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        boxShadow: Elevation.cardShadow,
      ),
      child: Column(
        children: [
          if (hasImage) ...[
            Expanded(
              child: Container(
                color: Colors.grey[100]!,
                margin: EdgeInsets.only(bottom: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4.h),
                ],
                if (subtitle != null) ...[
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4.h),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Skeleton for chip components
  static Widget chip({
    Key? key,
    double? height,
  }) {
    return Container(
      height: height ?? 32.h,
      constraints: BoxConstraints(
        minHeight: height ?? 32.h,
        maxWidth: 120.w,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300]!,
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        border: Border.all(
          color: Colors.grey[400]!,
        ),
      ),
    );
  }

  /// Skeleton section header
  static Widget sectionHeader({
    Key? key,
    String? title,
    double? height,
  }) {
    return Container(
      height: height ?? 24.h,
      child: Text(
        title ?? 'Loading...',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

/// Shimmer animation for skeleton
class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({super.key});

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        color: Colors.grey[200],
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return LinearProgressIndicator(
              value: _animation.value,
              backgroundColor: Colors.grey[300]!,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.primary.withOpacity(0.3)
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Loading wrapper with shimmer effect
class LoadingShimmer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? loadingText;
  final Color backgroundColor;
  final double? height;
  final double? width;

  const LoadingShimmer({
    super.key,
    required this.child,
    this.isLoading = false,
    this.loadingText,
    this.backgroundColor = Colors.white,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return child;
    }

    Color bg = backgroundColor;
    
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: bg,
      ),
      child: Stack(
        children: [
          child,
          if (loadingText != null) ...[
            Container(
              color: bg.withOpacity(0.8),
              child: Center(
                child: Text(
                  loadingText!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Full screen loader with shimmer
class FullScreenLoader extends StatelessWidget {
  final String? message;
  final Widget? child;
  final Color backgroundColor;

  const FullScreenLoader({
    super.key,
    this.message,
    this.child,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: child ?? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.downloading,
            size: 48.w,
            color: Colors.grey[400],
          ),
          SizedBox(height: Spacing.sectionSpacing),
          if (message != null) ...[
            Text(
              message!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: Spacing.sectionSpacing),
            Text(
              'Please wait...',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[500],
              ),
            ),
          ],
          if (child != null) ...[
            Expanded(child: child!),
          ],
        ],
      ),
    );
  }
}

/// Progress indicator for showing loading states
class LoadingProgressIndicator extends StatelessWidget {
  final double value;
  final double? height;
  final Color? backgroundColor;
  final String? labelText;
  final TextStyle? labelStyle;
  final bool showLabel;
  final Animation<Color?>? valueColor;

  const LoadingProgressIndicator({
    super.key,
    this.value = 0.0,
    this.height,
    this.backgroundColor,
    this.labelText,
    this.labelStyle,
    this.showLabel = true,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final progressHeight = height ?? 4.h;
    final bgColor = backgroundColor ?? Colors.grey[200]!;
    
    List<Widget> children = [];
    
    if (showLabel && labelText != null) {
      children.add(
        Text(
          labelText!,
          textAlign: TextAlign.center,
          style: labelStyle ?? TextStyle(
            fontSize: 12.sp,
            color: AppColors.primary,
          ),
        ),
      );
    }
    
    children.add(
      SizedBox(
        height: progressHeight,
        child: LinearProgressIndicator(
          value: value.clamp(0.0, 1.0),
          backgroundColor: bgColor,
          valueColor: valueColor ?? AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}

/// Button with skeleton loading state
class LoadingButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final double? width;
  final double? height;
  final Color? color;
  final double? elevation;
  final TextStyle? textStyle;

  const LoadingButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height,
    this.color,
    this.elevation,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: isLoading ? elevation ?? 0 : elevation ?? Elevation.md,
      borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      color: color ?? (isLoading ? Colors.grey.shade300 : AppColors.primary),
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        child: Container(
          width: width,
          height: height ?? Sizes.buttonHeightMd,
          padding: Spacing.buttonPadding,
          child: isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white.withOpacity(0.8)
                        ),
                        strokeWidth: 2,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Loading...',
                      style: textStyle ?? TextStyle(
                        color: Colors.white,
                        fontWeight: DesignTokens.fontWeightSemiBold,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(
                        icon,
                        color: Colors.white,
                        size: 16.w,
                      ),
                      SizedBox(width: icon != null && text.isNotEmpty ? 8.w : 0),
                    ],
                    Expanded(
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: textStyle ?? TextStyle(
                          color: Colors.white,
                          fontWeight: DesignTokens.fontWeightSemiBold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
