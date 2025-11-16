import 'package:katadia_app/core/network/dio_client.dart';
import 'package:katadia_app/core/utils/token_manager.dart';
import 'package:katadia_app/core/errors/exceptions.dart';
import 'package:katadia_app/features/authentication/domain/entities/user.dart';
import 'package:katadia_app/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:katadia_app/features/authentication/data/datasources/auth_local_datasource.dart';
import 'package:katadia_app/features/authentication/domain/repositories/auth_repository_interface.dart';

class AuthRepository implements AuthRepositoryInterface {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final TokenManager _tokenManager;
  final DioClient _dioClient;

  AuthRepository({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
    required TokenManager tokenManager,
    required DioClient dioClient,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _tokenManager = tokenManager,
        _dioClient = dioClient;

  @override
  Future<User> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Validate input
      if (email.isEmpty) {
        throw ValidationException.requiredField('Email');
      }
      if (password.isEmpty) {
        throw ValidationException.requiredField('Password');
      }

      // Call remote data source
      final authResponse = await _remoteDataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store tokens
      await _tokenManager.saveTokenPair(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
      );

      // Save user locally
      await _localDataSource.saveUser(authResponse.user);

      return authResponse.user;
    } on BaseException {
      rethrow;
    } catch (e) {
      throw AppException.unexpected(message: e.toString());
    }
  }

  @override
  Future<User> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    String? preferredLanguage,
  }) async {
    try {
      // Validate input
      if (email.isEmpty) {
        throw ValidationException.requiredField('Email');
      }
      if (password.isEmpty) {
        throw ValidationException.requiredField('Password');
      }
      if (name.isEmpty) {
        throw ValidationException.requiredField('Name');
      }

      // Call remote data source
      final authResponse = await _remoteDataSource.registerWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        preferredLanguage: preferredLanguage,
      );

      // Store tokens
      await _tokenManager.saveTokenPair(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
      );

      // Save user locally
      await _localDataSource.saveUser(authResponse.user);

      return authResponse.user;
    } on AuthenticationException {
      rethrow;
    } on ValidationException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw AppException.unexpected(message: e.toString());
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    try {
      final authResponse = await _remoteDataSource.signInWithGoogle();

      // Store tokens
      await _tokenManager.saveTokenPair(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
      );

      // Save user locally
      await _localDataSource.saveUser(authResponse.user);

      return authResponse.user;
    } on AuthenticationException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw AppException.unexpected(message: e.toString());
    }
  }

  @override
  Future<User> signInWithApple() async {
    try {
      final authResponse = await _remoteDataSource.signInWithApple();

      // Store tokens
      await _tokenManager.saveTokenPair(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
      );

      // Save user locally
      await _localDataSource.saveUser(authResponse.user);

      return authResponse.user;
    } on AuthenticationException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw AppException.unexpected(message: e.toString());
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      if (email.isEmpty) {
        throw ValidationException.requiredField('Email');
      }

      await _remoteDataSource.forgotPassword(email);
    } on AuthenticationException {
      rethrow;
    } on ValidationException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw AppException.unexpected(message: e.toString());
    }
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      if (token.isEmpty) {
        throw ValidationException.requiredField('Reset token');
      }
      if (newPassword.isEmpty) {
        throw ValidationException.requiredField('New password');
      }

      await _remoteDataSource.resetPassword(
        token: token,
        newPassword: newPassword,
      );
    } on AuthenticationException {
      rethrow;
    } on ValidationException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw AppException.unexpected(message: e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      final refreshToken = await _tokenManager.getRefreshToken();
      if (refreshToken != null) {
        // Call logout endpoint to invalidate refresh token server-side
        await _remoteDataSource.logout(refreshToken);
      }
    } catch (e) {
      // Continue with local logout even if server logout fails
    } finally {
      // Always clear local data
      await _tokenManager.clearTokens();
      await _localDataSource.clearUser();
    }
  }

  @override
  Future<User> getCurrentUser() async {
    try {
      // Check if user is cached locally
      final cachedUser = await _localDataSource.getUser();
      if (cachedUser != null) {
        return cachedUser;
      }

      // Fetch from remote
      final user = await _remoteCurrentUser();
      
      // Cache the user
      await _localDataSource.saveUser(user);
      
      return user;
    } on NetworkException {
      // If network fails, return cached user if available
      final cachedUser = await _localDataSource.getUser();
      if (cachedUser != null) {
        return cachedUser;
      }
      rethrow;
    } catch (e) {
      throw AppException.unexpected(message: e.toString());
    }
  }

  @override
  Future<User> updateProfile({
    String? name,
    String? profilePicture,
    String? preferredLanguage,
  }) async {
    try {
      final updatedUser = await _remoteDataSource.updateProfile(
        name: name,
        profilePicture: profilePicture,
        preferredLanguage: preferredLanguage,
      );

      // Update cached user
      await _localDataSource.saveUser(updatedUser);

      return updatedUser;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw AppException.unexpected(message: e.toString());
    }
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      if (currentPassword.isEmpty) {
        throw ValidationException.requiredField('Current password');
      }
      if (newPassword.isEmpty) {
        throw ValidationException.requiredField('New password');
      }

      await _remoteDataSource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    } on AuthenticationException {
      rethrow;
    } on ValidationException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw AppException.unexpected(message: e.toString());
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      return await _tokenManager.isAuthenticated();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> refreshToken() async {
    try {
      final accessToken = await _tokenManager.refreshTokens();
      if (accessToken == null) {
        throw AuthenticationException.tokenRefreshFailed();
      }
      
      // Update dio client with new token
      _dioClient.updateToken(accessToken);
    } on AuthenticationException {
      rethrow;
    } catch (e) {
      throw AppException.unexpected(message: e.toString());
    }
  }

  @override
  Stream<User?> get userStream {
    return _tokenManager.accessTokenStream.asyncMap((token) async {
      if (token == null) {
        return null;
      }
      try {
        // Fetch current user when token is available
        return await _remoteCurrentUser();
      } catch (e) {
        return null;
      }
    });
  }

  @override
  Future<bool> requiresReauthentication() async {
    try {
      return await _tokenManager.requiresReauthentication();
    } catch (e) {
      return true;
    }
  }

  // Private helper method
  Future<User> _remoteCurrentUser() async {
    // Ensure we have a valid token
    final accessToken = await _tokenManager.getValidToken();
    if (accessToken == null) {
      throw AuthenticationException.sessionExpired();
    }

    // Update dio client with valid token
    _dioClient.updateToken(accessToken);

    return await _remoteDataSource.getCurrentUser();
  }
}
