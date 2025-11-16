import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bahasaku_app/features/authentication/domain/entities/user.dart';
import 'package:bahasaku_app/features/authentication/presentation/providers/auth_provider.dart';
import 'package:bahasaku_app/features/authentication/presentation/state/auth_state.dart';

// Mock classes
class MockUser extends User {
  const MockUser({
    required super.id,
    required super.email,
    required super.name,
    super.profilePicture,
    super.preferredLanguage,
    super.cefrLevel,
    super.learningStreak,
    super.xp,
    super.currentLevel,
    super.totalLessonsCompleted,
    super.pronunciationSessions,
    super.averageScore,
    super.isPremium,
    super.subscriptionExpiry,
    super.socialLoginProvider,
    super.googleUserId,
    super.appleUserId,
    super.createdAt,
    super.updatedAt,
    super.metadata,
  });

  factory MockUser.test() {
    return MockUser(
      id: 'test-id',
      email: 'test@example.com',
      name: 'Test User',
      preferredLanguage: 'en',
      cefrLevel: 'A1',
      learningStreak: 5,
      xp: 100,
    );
  }
}

void main() {
  group('AuthProvider Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should start with initial state', () {
      final authState = container.read(authProvider);
      expect(authState.status, equals(AuthStatus.initial));
      expect(authState.user, isNull);
      expect(authState.errorMessage, isNull);
    });

    test('should login successfully', () async {
      const email = 'test@example.com';
      const password = 'password123';

      // Execute login
      await container.read(authProvider.notifier).loginWithEmailAndPassword(
        email: email,
        password: password,
      );

      final authState = container.read(authProvider);
      expect(authState.status, equals(AuthStatus.authenticated));
      expect(authState.user?.email, equals(email));
      expect(authState.user?.name, equals('Test User'));
    });

    test('should register successfully', () async {
      const email = 'newuser@example.com';
      const password = 'password123';
      const name = 'New User';

      // Execute registration
      await container.read(authProvider.notifier).registerWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );

      final authState = container.read(authProvider);
      expect(authState.status, equals(AuthStatus.authenticated));
      expect(authState.user?.email, equals(email));
      expect(authState.user?.name, equals(name));
    });

    test('should handle Google sign in', () async {
      // Execute Google sign in
      await container.read(authProvider.notifier).signInWithGoogle();

      final authState = container.read(authProvider);
      expect(authState.status, equals(AuthStatus.authenticated));
      expect(authState.user?.email, equals('google.user@gmail.com'));
      expect(authState.user?.socialLoginProvider, equals('google'));
    });

    test('should handle Apple sign in', () async {
      // Execute Apple sign in
      await container.read(authProvider.notifier).signInWithApple();

      final authState = container.read(authProvider);
      expect(authState.status, equals(AuthStatus.authenticated));
      expect(authState.user?.email, equals('apple.user@icloud.com'));
      expect(authState.user?.socialLoginProvider, equals('apple'));
    });

    test('should logout successfully', () async {
      // First login
      await container.read(authProvider.notifier).loginWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      );

      // Then logout
      await container.read(authProvider.notifier).logout();

      final authState = container.read(authProvider);
      expect(authState.status, equals(AuthStatus.unauthenticated));
      expect(authState.user, isNull);
      expect(authState.errorMessage, isNull);
    });

    test('should get current user when authenticated', () async {
      // Login first
      await container.read(authProvider.notifier).loginWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      );

      // Get current user
      await container.read(authProvider.notifier).getCurrentUser();

      final authState = container.read(authProvider);
      expect(authState.status, equals(AuthStatus.unauthenticated));
    });

    test('should update profile when authenticated', () async {
      // Login first
      await container.read(authProvider.notifier).loginWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      );

      // Update profile
      await container.read(authProvider.notifier).updateProfile(
        name: 'Updated Name',
        preferredLanguage: 'id',
      );

      final authState = container.read(authProvider);
      expect(authState.user?.name, equals('Updated Name'));
      expect(authState.user?.preferredLanguage, equals('id'));
    });
  });

  group('AuthProvider Convenience Providers Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('isAuthenticatedProvider should return false initially', () {
      final isAuthenticated = container.read(isAuthenticatedProvider);
      expect(isAuthenticated, isFalse);
    });

    test('isAuthenticatedProvider should return true after login', () async {
      await container.read(authProvider.notifier).loginWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      );

      final isAuthenticated = container.read(isAuthenticatedProvider);
      expect(isAuthenticated, isTrue);
    });

    test('isLoadingProvider should return true during login', () {
      // Start login process
      // Note: In a real test, you would use unawaited or manage the future differently
      container.read(authProvider.notifier).loginWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      );

      final isLoading = container.read(isLoadingProvider);
      expect(isLoading, isTrue);
    });

    test('currentUserProvider should return user after login', () async {
      await container.read(authProvider.notifier).loginWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      );

      final currentUser = container.read(currentUserProvider);
      expect(currentUser, isNotNull);
      expect(currentUser?.email, equals('test@example.com'));
    });

    test('authErrorProvider should be null initially', () {
      final authError = container.read(authErrorProvider);
      expect(authError, isNull);
    });
  });
}
