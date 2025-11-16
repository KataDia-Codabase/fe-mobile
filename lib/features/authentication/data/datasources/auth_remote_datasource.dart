// Placeholder for remote datasource
// TODO: Implement actual API integration in Sprint 2

import 'package:katadia_app/features/authentication/domain/entities/user.dart';

class AuthRemoteDataSource {
  Future<AuthResponse> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // TODO: Implement actual API call
    await Future<void>.delayed(const Duration(seconds: 2));
    
    return AuthResponse(
      accessToken: 'mock_access_token',
      refreshToken: 'mock_refresh_token',
      user: User(
        id: '1',
        email: email,
        name: 'Test User',
        preferredLanguage: 'en',
        cefrLevel: 'A1',
        learningStreak: 5,
        xp: 150,
      ),
    );
  }

  Future<AuthResponse> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    String? preferredLanguage,
  }) async {
    // TODO: Implement actual API call
    await Future<void>.delayed(const Duration(seconds: 2));
    
    return AuthResponse(
      accessToken: 'mock_access_token',
      refreshToken: 'mock_refresh_token',
      user: User(
        id: '1',
        email: email,
        name: name,
        preferredLanguage: preferredLanguage ?? 'en',
        cefrLevel: null,
        learningStreak: 0,
        xp: 0,
      ),
    );
  }

  Future<AuthResponse> signInWithGoogle() async {
    // TODO: Implement actual Google sign-in
    await Future<void>.delayed(const Duration(seconds: 2));
    
    return AuthResponse(
      accessToken: 'mock_google_token',
      refreshToken: 'mock_google_refresh',
      user: User(
        id: '1',
        email: 'google.user@gmail.com',
        name: 'Google User',
        preferredLanguage: 'en',
        socialLoginProvider: 'google',
        googleUserId: 'google_123',
        cefrLevel: null,
        learningStreak: 0,
        xp: 0,
      ),
    );
  }

  Future<AuthResponse> signInWithApple() async {
    // TODO: Implement actual Apple sign-in
    await Future<void>.delayed(const Duration(seconds: 2));
    
    return AuthResponse(
      accessToken: 'mock_apple_token',
      refreshToken: 'mock_apple_refresh',
      user: User(
        id: '1',
        email: 'apple.user@icloud.com',
        name: 'Apple User',
        preferredLanguage: 'en',
        socialLoginProvider: 'apple',
        appleUserId: 'apple_123',
        cefrLevel: null,
        learningStreak: 0,
        xp: 0,
      ),
    );
  }

  Future<void> forgotPassword(String email) async {
    // TODO: Implement actual forgot password API call
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    // TODO: Implement actual reset password API call
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  Future<void> logout(String refreshToken) async {
    // TODO: Implement actual logout API call
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  Future<User> getCurrentUser() async {
    // TODO: Implement actual get current user API call
    await Future<void>.delayed(const Duration(seconds: 1));
    
    return User(
      id: '1',
      email: 'user@example.com',
      name: 'Current User',
      preferredLanguage: 'en',
      cefrLevel: 'A1',
      learningStreak: 5,
      xp: 150,
    );
  }

  Future<User> updateProfile({
    String? name,
    String? profilePicture,
    String? preferredLanguage,
  }) async {
    // TODO: Implement actual update profile API call
    await Future<void>.delayed(const Duration(seconds: 1));
    
    return User(
      id: '1',
      email: 'user@example.com',
      name: name ?? 'Updated User',
      profilePicture: profilePicture,
      preferredLanguage: preferredLanguage ?? 'en',
      cefrLevel: 'A1',
      learningStreak: 5,
      xp: 150,
    );
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    // TODO: Implement actual change password API call
    await Future<void>.delayed(const Duration(seconds: 1));
  }
}

class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final User user;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });
}
