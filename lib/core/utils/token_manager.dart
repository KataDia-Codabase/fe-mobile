import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import '../constants/app_constants.dart';
import '../../constants/cache_keys.dart' as cache_keys;
import '../errors/exceptions.dart';

class TokenManager {
  final FlutterSecureStorage _secureStorage;
  final Logger _logger;
  StreamController<String?>? _tokenStreamController;

  TokenManager({
    FlutterSecureStorage? secureStorage,
    Logger? logger,
  }) : _secureStorage = secureStorage ?? const FlutterSecureStorage(),
       _logger = logger ?? Logger() {
    _initializeTokenStream();
  }

  void _initializeTokenStream() {
    _tokenStreamController = StreamController<String?>.broadcast();
  }

  // Save token pair
  Future<void> saveTokenPair({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      await Future.wait([
        _secureStorage.write(
          key: cache_keys.CacheKeys.userToken,
          value: accessToken,
        ),
        _secureStorage.write(
          key: AppConstants.refreshTokenKey,
          value: refreshToken,
        ),
      ]);

      _logger.d('Tokens saved successfully');
      _tokenStreamController?.add(accessToken);

      // Store token metadata for session management
      await _storeTokenMetadata(accessToken);
    } catch (e) {
      _logger.e('Failed to save tokens: $e');
      throw AppException.unexpected(message: 'Failed to save tokens: $e');
    }
  }

  // Get access token
  Future<String?> getAccessToken() async {
    try {
      final token = await _secureStorage.read(key: cache_keys.CacheKeys.userToken);
      
      if (token != null && await _isTokenValid(token)) {
        return token;
      } else if (token != null) {
        _logger.d('Access token is expired or invalid');
        await clearTokens();
        return null;
      }
      
      return null;
    } catch (e) {
      _logger.e('Failed to get access token: $e');
      return null;
    }
  }

  // Get refresh token
  Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: AppConstants.refreshTokenKey);
    } catch (e) {
      _logger.e('Failed to get refresh token: $e');
      return null;
    }
  }

  // Clear all tokens
  Future<void> clearTokens() async {
    try {
      final keys = [
        cache_keys.CacheKeys.userToken,
        AppConstants.refreshTokenKey,
        '${AppConstants.refreshTokenKey}_metadata',
        '${AppConstants.accessTokenKey}_metadata',
      ];

      for (final key in keys) {
        await _secureStorage.delete(key: key);
      }

      _logger.d('All tokens cleared successfully');
      _tokenStreamController?.add(null);
    } catch (e) {
      _logger.e('Failed to clear tokens: $e');
      throw AppException.unexpected(message: 'Failed to clear tokens: $e');
    }
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final accessToken = await getAccessToken();
    return accessToken != null;
  }

  // Get access token stream
  Stream<String?> get accessTokenStream {
    if (_tokenStreamController == null) {
      _initializeTokenStream();
    }
    return _tokenStreamController!.stream;
  }

  // Refresh tokens using refresh token
  Future<String?> refreshTokens() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null) {
        throw AuthenticationException.sessionExpired();
      }

      // This would typically make an API call to refresh the token
      // For now, we'll simulate it
      // In a real implementation, you would call your refresh endpoint here
      
      _logger.d('Token refresh simulated');
      return await getAccessToken();
    } catch (e) {
      _logger.e('Failed to refresh tokens: $e');
      await clearTokens();
      throw AuthenticationException.tokenRefreshFailed();
    }
  }

  // Get token expiration time
  Future<DateTime?> getTokenExpiration() async {
    try {
      final metadata = await _secureStorage.read(
        key: '${AppConstants.accessTokenKey}_metadata',
      );
      
      if (metadata != null) {
        // Parse the metadata (this is a simplified implementation)
        final parts = metadata.split('|');
        if (parts.length >= 2) {
          final timestamp = int.tryParse(parts[1]);
          if (timestamp != null) {
            return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
          }
        }
      }
      
      return null;
    } catch (e) {
      _logger.e('Failed to get token expiration: $e');
      return null;
    }
  }

  // Automatic token refresh if needed
  Future<String?> getValidToken() async {
    final accessToken = await getAccessToken();
    if (accessToken != null && await _isTokenValid(accessToken)) {
      return accessToken;
    }

    // Try to refresh the token
    try {
      return await refreshTokens();
    } catch (e) {
      _logger.e('Unable to get valid token: $e');
      return null;
    }
  }

  // Store token metadata for session management
  Future<void> _storeTokenMetadata(String token) async {
    try {
      // In a real implementation, you would decode the JWT token
      // and store the expiration time, user ID, etc.
      // For now, we'll store a simple timestamp
      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final metadata = 'access|$timestamp';
      
      await _secureStorage.write(
        key: '${AppConstants.accessTokenKey}_metadata',
        value: metadata,
      );
    } catch (e) {
      _logger.e('Failed to store token metadata: $e');
    }
  }

  // Check if token is valid (not expired)
  Future<bool> _isTokenValid(String token) async {
    try {
      final expiration = await getTokenExpiration();
      if (expiration == null) {
        // If we don't have expiration info, assume token is valid
        return true;
      }

      // Add some buffer time to account for network latency
      const bufferTime = 60; // 1 minute buffer
      final now = DateTime.now();
      final expiryWithBuffer = expiration.subtract(Duration(seconds: bufferTime));

      return now.isBefore(expiryWithBuffer);
    } catch (e) {
      _logger.e('Error checking token validity: $e');
      return false;
    }
  }

  // Get time until token expires
  Future<Duration?> getTimeUntilExpiration() async {
    try {
      final expiration = await getTokenExpiration();
      if (expiration == null) {
        return null;
      }

      final now = DateTime.now();
      if (expiration.isBefore(now)) {
        return Duration.zero;
      }

      return expiration.difference(now);
    } catch (e) {
      _logger.e('Failed to get time until expiration: $e');
      return null;
    }
  }

  // Force token refresh if it's about to expire
  Future<void> ensureTokenValid() async {
    try {
      final timeUntilExpiration = await getTimeUntilExpiration();
      
      // If token expires in less than 5 minutes, refresh it
      if (timeUntilExpiration != null && 
          timeUntilExpiration.inMinutes < 5) {
        await refreshTokens();
      }
    } catch (e) {
      _logger.e('Failed to ensure token validity: $e');
      // Don't throw here as the caller might handle the token refresh themselves
    }
  }

  // Dispose resources
  void dispose() {
    _tokenStreamController?.close();
    _tokenStreamController = null;
  }
}

// Extension to make token management easier
extension TokenManagerX on TokenManager {
  // Check if user needs re-authentication
  Future<bool> requiresReauthentication() async {
    try {
      final refreshToken = await getRefreshToken();
      final accessToken = await getAccessToken();
      
      return refreshToken == null && accessToken == null;
    } catch (e) {
      return true;
    }
  }

  // Get token info for debugging
  Future<Map<String, dynamic>> getTokenInfo() async {
    return {
      'hasAccessToken': await getAccessToken() != null,
      'hasRefreshToken': await getRefreshToken() != null,
      'tokenExpiration': await getTokenExpiration(),
      'timeUntilExpiration': await getTimeUntilExpiration(),
    };
  }
}
