import 'package:katadia_app/features/authentication/domain/entities/user.dart';

abstract class AuthRepositoryInterface {
  // Login methods
  Future<User> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<User> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    String? preferredLanguage,
  });

  Future<User> signInWithGoogle();

  Future<User> signInWithApple();

  Future<void> forgotPassword(String email);

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });

  Future<void> logout();

  Future<User> getCurrentUser();

  Future<User> updateProfile({
    String? name,
    String? profilePicture,
    String? preferredLanguage,
  });

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<bool> isAuthenticated();

  Future<void> refreshToken();

  Stream<User?> get userStream;

  Future<bool> requiresReauthentication();
}
