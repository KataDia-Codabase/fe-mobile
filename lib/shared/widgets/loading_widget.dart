import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Loading spinner widget.
class LoadingSpinner extends StatelessWidget {
  /// Size of the spinner.
  final double? size;
  /// Color of the spinner.
  final Color? color;

  const LoadingSpinner({
    super.key,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 24.w,
      height: size ?? 24.w,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

/// Full screen loader widget.
class FullScreenLoader extends StatelessWidget {
  /// Message to display below the spinner.
  final String? message;
  /// Custom widget to show instead of default content.
  final Widget? child;

  const FullScreenLoader({
    super.key,
    this.message,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: child ??
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingSpinner(size: 32.w),
                if (message != null) ...[
                  SizedBox(height: 16.h),
                  Text(
                    message!,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
    );
  }
}

/// Loading button widget.
class LoadingButton extends StatefulWidget {
  /// Child widget to display inside the button.
  final Widget child;
  /// Callback when button is pressed.
  final VoidCallback? onPressed;
  /// Whether the button is in loading state.
  final bool isLoading;
  /// Button color.
  final Color? color;
  /// Button height.
  final double? height;
  /// Button width.
  final double? width;
  /// Button border radius.
  final BorderRadius? borderRadius;

  const LoadingButton({
    super.key,
    required this.child,
    this.onPressed,
    this.isLoading = false,
    this.color,
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height ?? 48.h,
      child: ElevatedButton(
        onPressed: widget.isLoading ? null : widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color ?? Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: widget.isLoading
            ? LoadingSpinner(size: 20.w, color: Colors.white)
            : widget.child,
      ),
    );
  }
}

/// Loading skeleton widget.
class LoadingSkeleton extends StatelessWidget {
  /// Height of the skeleton.
  final double? height;
  /// Width of the skeleton.
  final double? width;
  /// Border radius of the skeleton.
  final BorderRadius? borderRadius;
  /// Base color of the skeleton.
  final Color? baseColor;
  /// Highlight color of the skeleton.
  final Color? highlightColor;

  const LoadingSkeleton({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 20.h,
      decoration: BoxDecoration(
        color: baseColor ?? Colors.grey[300],
        borderRadius: borderRadius ?? BorderRadius.circular(4.r),
      ),
      child: SkeletonHighlight(
        baseColor: baseColor ?? Colors.grey[300],
        highlightColor: highlightColor ?? Colors.grey[200],
      ),
    );
  }
}

/// Skeleton highlight animation widget.
class SkeletonHighlight extends StatefulWidget {
  /// Base color of the animation.
  final Color? baseColor;
  /// Highlight color of the animation.
  final Color? highlightColor;
  /// Child widget.
  final Widget? child;

  const SkeletonHighlight({
    super.key,
    this.baseColor,
    this.highlightColor,
    this.child,
  });

  @override
  State<SkeletonHighlight> createState() => _SkeletonHighlightState();
}

class _SkeletonHighlightState extends State<SkeletonHighlight>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}

/// List item skeleton widget.
class ListItemSkeleton extends StatelessWidget {
  /// Whether to show avatar skeleton.
  final bool showAvatar;
  /// Whether to show subtitle skeleton.
  final bool showSubtitle;
  /// Height of the list item.
  final double? itemHeight;

  const ListItemSkeleton({
    super.key,
    this.showAvatar = true,
    this.showSubtitle = true,
    this.itemHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          if (showAvatar) ...[
            LoadingSkeleton(
              width: 48.w,
              height: 48.w,
              borderRadius: BorderRadius.circular(24.r),
            ),
            SizedBox(width: 12.w),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadingSkeleton(
                  height: 16.h,
                  width: double.infinity,
                ),
                if (showSubtitle) ...[
                  SizedBox(height: 8.h),
                  LoadingSkeleton(
                    height: 14.h,
                    width: 200.w,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Grid item skeleton widget.
class GridItemSkeleton extends StatelessWidget {
  /// Height of the grid item.
  final double? itemHeight;
  /// Aspect ratio of the grid item.
  final double? aspectRatio;

  const GridItemSkeleton({
    super.key,
    this.itemHeight,
    this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            flex: 2,
            child: LoadingSkeleton(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          const SizedBox(height: 8),
          const LoadingSkeleton(height: 14, width: double.infinity),
          const SizedBox(height: 4),
          const LoadingSkeleton(height: 12, width: 100),
        ],
      ),
    );
  }
}
