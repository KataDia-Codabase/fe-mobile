import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:katadia_app/core/routing/app_router.dart';
import 'package:katadia_app/shared/theme/app_theme.dart';
import 'package:katadia_app/features/settings/providers/theme_provider.dart';

void main() {
  // Setup error handling for debugging
  FlutterError.onError = (FlutterErrorDetails error) {
    print('BUILD ERROR: ${error.exception}');
    print('STACK TRACE: ${error.stack}');
  };
  
  try {
    runApp(
      const ProviderScope(
        child: KataDiaApp(),
      ),
    );
  } catch (e, stackTrace) {
    print('RUNTIME ERROR: $e');
    print('STACK TRACE: $stackTrace');
  }
}

class KataDiaApp extends ConsumerWidget {
  const KataDiaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = AppRouter.router(ProviderScope.containerOf(context));
    final themeMode = ref.watch(themeProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: router,
          title: 'KataDia',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}
