import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';
import '../state/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState.initial());

  // Login with email and password
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();
    
    try {
      // TODO: Implement actual login logic
      // For now, simulate a successful login
      await Future<void>.delayed(const Duration(seconds: 2));
      
      final user = User(
        id: '1',
        email: email,
        name: 'Test User',
        preferredLanguage: 'en',
        cefrLevel: 'A1',
        learningStreak: 5,
        xp: 150,
      );
      
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // Register new account
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    String? preferredLanguage,
  }) async {
    state = const AuthState.loading();
    
    try {
      // TODO: Implement actual registration logic
      await Future<void>.delayed(const Duration(seconds: 2));
      
      final user = User(
        id: '1',
        email: email,
        name: name,
        preferredLanguage: preferredLanguage ?? 'en',
        cefrLevel: null,
        learningStreak: 0,
        xp: 0,
      );
      
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // Social login with Google
  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();
    
    try {
      // TODO: Implement actual Google sign-in
      await Future<void>.delayed(const Duration(seconds: 2));
      
      const user = User(
        id: '1',
        email: 'google.user@gmail.com',
        name: 'Google User',
        preferredLanguage: 'en',
        socialLoginProvider: 'google',
        googleUserId: 'google_123',
        cefrLevel: null,
        learningStreak: 0,
        xp: 0,
      );
      
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // Social login with Apple
  Future<void> signInWithApple() async {
    state = const AuthState.loading();
    
    try {
      // TODO: Implement actual Apple sign-in
      await Future<void>.delayed(const Duration(seconds: 2));
      
      const user = User(
        id: '1',
        email: 'apple.user@icloud.com',
        name: 'Apple User',
        preferredLanguage: 'en',
        socialLoginProvider: 'apple',
        appleUserId: 'apple_123',
        cefrLevel: null,
        learningStreak: 0,
        xp: 0,
      );
      
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // Logout
  Future<void> logout() async {
    state = const AuthState.loading();
    
    try {
      // TODO: Implement actual logout
      await Future<void>.delayed(const Duration(seconds: 1));
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // Get current user
  Future<void> getCurrentUser() async {
    state = const AuthState.loading();
    
    try {
      // TODO: Implement actual get user logic
      await Future<void>.delayed(const Duration(seconds: 1));
      
      // For demo, default to unauthenticated
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // Reset error state
  void resetError() {
    if (state.maybeWhen(
      error: (message) => true,
      orElse: () => false,
    )) {
      state = const AuthState.unauthenticated();
    }
  }

  // Update user profile
  Future<void> updateProfile({
    String? name,
    String? preferredLanguage,
  }) async {
    state.when(
      initial: () {},
      loading: () {},
      unauthenticated: () {},
      authenticated: (user) async {
        try {
          final updatedUser = user.copyWith(
            name: name,
            preferredLanguage: preferredLanguage,
          );
          state = AuthState.authenticated(updatedUser);
        } catch (e) {
          state = AuthState.error(e.toString());
        }
      },
      error: (message) {},
    );
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      // TODO: Implement actual password reset
      await Future<void>.delayed(const Duration(seconds: 1));
      // Show success message
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}

// Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);

// Convenience providers
final authStateProvider = authProvider;
final isAuthenticatedProvider = authProvider.select(
  (state) => state.maybeWhen(
    authenticated: (user) => true,
    orElse: () => false,
  ),
);
final currentUserProvider = authProvider.select(
  (state) => state.maybeWhen(
    authenticated: (user) => user,
    orElse: () => null,
  ),
);
final isLoadingProvider = authProvider.select(
  (state) => state.maybeWhen(
    loading: () => true,
    orElse: () => false,
  ),
);
final authErrorProvider = authProvider.select(
  (state) => state.maybeWhen(
    error: (message) => message,
    orElse: () => null,
  ),
);
