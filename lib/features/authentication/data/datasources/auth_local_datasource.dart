// Placeholder for local datasource
// TODO: Implement actual local storage in Sprint 2

import 'package:katadia_app/features/authentication/domain/entities/user.dart';

class AuthLocalDataSource {
  // Temporary storage until proper implementation
  User? _cachedUser;

  Future<void> saveUser(User user) async {
    // TODO: Use Hive or SharedPreferences for actual local storage
    _cachedUser = user;
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }

  Future<User?> getUser() async {
    // TODO: Implement actual local storage retrieval
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return _cachedUser;
  }

  Future<void> clearUser() async {
    // TODO: Implement actual local storage cleanup
    _cachedUser = null;
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    // TODO: Use flutter_secure_storage for actual token storage
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }

  Future<String?> getAccessToken() async {
    // TODO: Implement actual token retrieval
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return 'mock_access_token';
  }

  Future<String?> getRefreshToken() async {
    // TODO: Implement actual token retrieval
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return 'mock_refresh_token';
  }

  Future<void> clearTokens() async {
    // TODO: Implement actual token cleanup
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }
}
