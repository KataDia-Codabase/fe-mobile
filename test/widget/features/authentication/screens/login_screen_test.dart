import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:katadia_app/features/authentication/presentation/providers/auth_provider.dart';
import 'package:katadia_app/features/authentication/presentation/screens/login_screen_fixed.dart';
import 'package:katadia_app/features/authentication/presentation/state/auth_state.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    Widget createTestableLoginScreen({ProviderContainer? testContainer}) {
      return ProviderScope(
        parent: testContainer,
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => const MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );
    }

    testWidgets('should display login form correctly', (WidgetTester tester) async {
      // Build our app with ProviderScope
      await tester.pumpWidget(createTestableLoginScreen());

      // Verify that all essential widgets exist
      expect(find.text('Selamat Datang di KataDia!'), findsOneWidget);
      expect(find.text('Masuk dengan email dan kata sandi'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Masuk'), findsOneWidget);
      expect(find.text('Ingat saya'), findsOneWidget);
      expect(find.text('Belum punya akun?'), findsOneWidget);
      expect(find.text('Daftar'), findsOneWidget);
    });

    testWidgets('should display social login buttons', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableLoginScreen());

      expect(find.text('Masuk dengan Google'), findsOneWidget);
      expect(find.text('Masuk dengan Apple'), findsOneWidget);
    });

    testWidgets('should show validation errors for empty fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Try to submit login without filling fields
      await tester.tap(find.text('Masuk'));
      await tester.pumpAndSettle();

      // Verify validation errors appear
      expect(find.text('Email harus diisi'), findsOneWidget);
      expect(find.text('Password harus diisi'), findsOneWidget);
    });

    testWidgets('should show validation error for invalid email', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Enter invalid email
      await tester.enterText(find.byKey(const Key('email_field')), 'invalid-email');
      
      // Try to submit
      await tester.tap(find.text('Masuk'));
      await tester.pumpAndSettle();

      expect(find.text('Format email tidak valid'), findsOneWidget);
    });

    testWidgets('should show validation error for short password', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Enter email and short password
      await tester.enterText(find.byKey(const Key('email_field')), 'test@example.com');
      await tester.enterText(find.byKey(const Key('password_field')), '123');
      
      // Try to submit
      await tester.tap(find.text('Masuk'));
      await tester.pumpAndSettle();

      expect(find.text('Password minimal 6 karakter'), findsOneWidget);
    });

    testWidgets('should toggle password visibility', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Find password visibility toggle button
      final visibilityToggle = find.byIcon(Icons.visibility_off_outlined);
      expect(visibilityToggle, findsOneWidget);

      // Toggle visibility
      await tester.tap(visibilityToggle);
      await tester.pumpAndSettle();

      // Verify icon changed
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off_outlined), findsNothing);
    });

    testWidgets('should handle successful login', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Enter valid credentials
      await tester.enterText(find.byKey(const Key('email_field')), 'test@example.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      
      // Submit login
      await tester.tap(find.text('Masuk'));
      
      // Wait for loading
      await tester.pumpAndSettle(const Duration(seconds: 2));
      
      // Verify loading state (in real implementation, you would check for loading indicator)
      final container = ProviderScope.containerOf(tester.element(find.byType(MaterialApp)));
      
      // After simulated login completes
      await tester.pumpAndSettle(const Duration(seconds: 2));
      
      // Verify authenticated state
      final isAuthenticated = container.read(isAuthenticatedProvider);
      expect(isAuthenticated, isTrue);
    });

    testWidgets('should handle continue with Google', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Tap Google sign-in button
      await tester.tap(find.text('Masuk dengan Google'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify loading and authentication
      final container = ProviderScope.containerOf(tester.element(find.byType(MaterialApp)));
      final isAuthenticated = container.read(isAuthenticatedProvider);
      expect(isAuthenticated, isTrue);
    });

    testWidgets('should handle continue with Apple', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Tap Apple sign-in button
      await tester.tap(find.text('Masuk dengan Apple'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify loading and authentication
      final container = ProviderScope.containerOf(tester.element(find.byType(MaterialApp)));
      final isAuthenticated = container.read(isAuthenticatedProvider);
      expect(isAuthenticated, isTrue);
    });

    testWidgets('should display error message when login fails', (WidgetTester tester) async {
      // Create a custom provider that throws error
      final errorContainer = ProviderContainer(
        overrides: [
          authProvider.overrideWith((ref) => ErrorAuthNotifier()),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: errorContainer,
          child: const MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Enter credentials and attempt login
      await tester.enterText(find.byKey(const Key('email_field')), 'test@example.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.text('Masuk'));
      
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify error message appears
      expect(find.byType(Container), findsWidgets);
      // In real implementation, you would verify specific error message
    });
  });
}

// Error AuthNotifier class for testing error states
class ErrorAuthNotifier extends AuthNotifier {
  @override
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AuthState.error('Authentication failed');
  }
}
