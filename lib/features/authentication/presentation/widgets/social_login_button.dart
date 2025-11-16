import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SocialProvider {
  google,
  apple,
}

class SocialLoginButton extends StatelessWidget {
  final SocialProvider provider;
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Widget? customIcon;

  const SocialLoginButton({
    super.key,
    required this.provider,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.customIcon,
  });

  factory SocialLoginButton.google({
    required VoidCallback onPressed,
    required String text,
    bool isLoading = false,
  }) {
    return SocialLoginButton(
      provider: SocialProvider.google,
      onPressed: onPressed,
      text: text,
      isLoading: isLoading,
    );
  }

  factory SocialLoginButton.apple({
    required VoidCallback onPressed,
    required String text,
    bool isLoading = false,
  }) {
    return SocialLoginButton(
      provider: SocialProvider.apple,
      onPressed: onPressed,
      text: text,
      isLoading: isLoading,
    );
  }

  Color get _backgroundColor {
    switch (provider) {
      case SocialProvider.google:
        return Colors.white;
      case SocialProvider.apple:
        return Colors.black;
    }
  }

  Color get _textColor {
    switch (provider) {
      case SocialProvider.google:
        return Colors.black87;
      case SocialProvider.apple:
        return Colors.white;
    }
  }

  Widget get _defaultIcon {
    switch (provider) {
      case SocialProvider.google:
        return Container(
          width: 24.w,
          height: 24.h,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Center(
            child: Text(
              'G',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      case SocialProvider.apple:
        return Icon(
          Icons.apple,
          size: 24.w,
          color: Colors.white,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: _backgroundColor,
        side: BorderSide(
          color: provider == SocialProvider.google ? Colors.grey.shade300 : Colors.black,
          width: 1,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        minimumSize: Size(0, 60.h),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: isLoading
          ? SizedBox(
              width: 20.w,
              height: 20.h,
              child: CircularProgressIndicator(
                strokeWidth: 2.w,
                valueColor: AlwaysStoppedAnimation<Color>(_textColor),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                customIcon ?? _defaultIcon,
                SizedBox(width: 12.w),
                Flexible(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: _textColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
    );
  }
}
