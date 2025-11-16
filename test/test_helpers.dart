import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Helper class for test setup
class TestHelpers {
  /// Initialize ScreenUtil for testing
  static void initScreenUtil() {
    TestWidgetsFlutterBinding.ensureInitialized();
    // ScreenUtil initialization is handled by ScreenUtilInit wrapper
    // This method is kept for backward compatibility
  }

  /// Utility function to pump and settle with additional wait time
  static Future<void> pumpAndSettleWithDelay(
    WidgetTester tester, {
    Duration delay = const Duration(milliseconds: 500),
  }) async {
    await tester.pumpAndSettle();
    await Future<void>.delayed(delay);
    await tester.pumpAndSettle();
  }

  /// Create a testable widget with provider scope
  static Widget createTestableWidget(Widget child) {
    return MaterialApp(
      home: child,
    );
  }

  /// Create a testable widget with provider scope and screen util
  static Widget createTestableWidgetWithProvider(Widget child) {
    return MaterialApp(
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) => child,
      ),
    );
  }
}
