import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:katadia_app/features/authentication/presentation/screens/login_screen_fixed.dart';
import 'package:katadia_app/features/authentication/presentation/screens/register_screen.dart';
import 'package:katadia_app/features/authentication/presentation/providers/auth_provider.dart';
import 'package:katadia_app/features/home/presentation/screens/home_screen.dart';
import 'package:katadia_app/features/lessons/presentation/screens/lesson_catalog_screen.dart';
import 'package:katadia_app/features/lessons/presentation/screens/lesson_detail_screen.dart';
import 'package:katadia_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:katadia_app/features/settings/presentation/screens/settings_screen.dart';

/// App router configuration
class AppRouter {
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String lessonsRoute = '/lessons';
  static const String lessonDetailRoute = '/lessons/:lessonId';
  static const String profileRoute = '/profile';
  static const String settingsRoute = '/settings';
  static const String pronunciationRoute = '/pronunciation';

  static GoRouter router(ProviderContainer container) {
    return GoRouter(
      initialLocation: loginRoute,
      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: Text(
            'Page not found',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      redirect: (context, state) {
        try {
          // Auth guard logic using Riverpod state
          final authState = container.read(authStateProvider);
          final isAuthenticated = authState.maybeWhen(
            authenticated: (user) => true,
            unauthenticated: () => false, // Explicitly handle unauthenticated state
            loading: () => false, // Consider loading as unauthenticated
            initial: () => false, // Consider initial as unauthenticated
            error: (error) => false, // Consider error as unauthenticated
            orElse: () => false,
          );
          
          // Protect authenticated routes
          final protectedRoutes = [homeRoute, lessonsRoute, lessonDetailRoute, profileRoute, settingsRoute];
          final isProtectedRoute = protectedRoutes.any((route) => state.uri.path.startsWith(route));
          
          if (!isAuthenticated && isProtectedRoute) {
            return loginRoute;
          }
          
          // If user is authenticated, don't allow access to auth routes
          if (isAuthenticated && (state.uri.path == loginRoute || state.uri.path == registerRoute)) {
            return homeRoute;
          }
          
          return null;
        } catch (e) {
          // If there's an error reading auth state, allow navigation to continue
          // This prevents black screen during initialization
          return null;
        }
      },
      routes: [
      // Authentication routes
      GoRoute(
        path: loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: registerRoute,
        builder: (context, state) => const RegisterScreen(),
      ),
      
      // Main app routes
      GoRoute(
        path: homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: lessonsRoute,
        builder: (context, state) => const LessonCatalogScreen(),
      ),
      GoRoute(
        path: lessonDetailRoute,
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId']!;
          return LessonDetailScreen(lessonId: lessonId);
        },
      ),
      GoRoute(
        path: pronunciationRoute,
        builder: (context, state) {
          // Placeholder for when accessing without context
          return const Scaffold(
            body: Center(
              child: Text('Pronunciation practice memerlukan lesson context'),
            ),
          );
        },
      ),
      GoRoute(
        path: profileRoute,
        builder: (context, state) => const ProfileScreen(),
      ),
      
      // Additional routes
      GoRoute(
        path: settingsRoute,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    );
  }
}

/// Navigation extensions for easier navigation
extension NavigationExtensions on BuildContext {
  void goToLogin() => go(AppRouter.loginRoute);
  void goToRegister() => go(AppRouter.registerRoute);
  void goToHome() => go(AppRouter.homeRoute);
  void goToLessons() => go(AppRouter.lessonsRoute);
  void goToLessonDetail(String lessonId) => go('${AppRouter.lessonDetailRoute.replaceAll(':lessonId', lessonId)}');
  void goToProfile() => go(AppRouter.profileRoute);
  void goToSettings() => go(AppRouter.settingsRoute);
}

/// Route names for type safety
class AppRouteNames {
  static const String login = 'login';
  static const String register = 'register';
  static const String home = 'home';
  static const String lessons = 'lessons';
  static const String lessonDetail = 'lessonDetail';
  static const String profile = 'profile';
  static const String settings = 'settings';
}
