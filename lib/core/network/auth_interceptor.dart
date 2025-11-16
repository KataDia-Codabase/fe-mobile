import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../constants/app_constants.dart';
import '../errors/exceptions.dart';
import '../utils/token_manager.dart';

class AuthInterceptor extends Interceptor {
  final TokenManager _tokenManager;
  final Logger _logger;

  AuthInterceptor({
    required TokenManager tokenManager,
    Logger? logger,
  }) : _tokenManager = tokenManager,
       _logger = logger ?? Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final accessToken = await _tokenManager.getAccessToken();
      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
        _logger.d('Access token added to request headers');
      }
      handler.next(options);
    } catch (e) {
      _logger.e('Failed to add access token to request: $e');
      handler.next(options);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if error is 401 Unauthorized
    if (err.response?.statusCode == 401) {
      _logger.d('Received 401, attempting token refresh');
      
      try {
        final accessToken = await _refreshToken(err.requestOptions);
        if (accessToken != null) {
          // Retry the original request with new token
          _logger.d('Token refreshed successfully, retrying original request');
          final response = await _retryRequest(err.requestOptions, accessToken);
          handler.resolve(response);
          return;
        }
      } catch (e) {
        _logger.e('Token refresh failed: $e');
      }
      
      // If refresh failed, clear tokens and propagate error
      await _tokenManager.clearTokens();
      handler.next(DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: AuthenticationException.sessionExpired(),
      ));
      return;
    }

    // For other errors, pass them through
    handler.next(err);
  }

  Future<String?> _refreshToken(RequestOptions originalRequest) async {
    try {
      final refreshToken = await _tokenManager.getRefreshToken();
      if (refreshToken == null) {
        throw AuthenticationException.sessionExpired();
      }

      // Create a fresh Dio instance for token refresh to avoid infinite loop
      final refreshDio = Dio();
      refreshDio.options.baseUrl = ApiEndpoints.baseUrl;
      refreshDio.options.connectTimeout = AppConstants.connectionTimeout;

      final response = await refreshDio.post<Map<String, dynamic>>(
        ApiEndpoints.refresh,
        data: {
          'refreshToken': refreshToken,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final newAccessToken = data['accessToken'] as String?;
        final newRefreshToken = data['refreshToken'] as String?;

        if (newAccessToken != null) {
          await _tokenManager.saveTokenPair(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken ?? refreshToken,
          );
          return newAccessToken;
        }
      }

      throw AuthenticationException.tokenRefreshFailed();
    } catch (e) {
      _logger.e('Token refresh error: $e');
      rethrow;
    }
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions originalRequest, String accessToken) async {
    final updatedOptions = RequestOptions(
      method: originalRequest.method,
      path: originalRequest.path,
      baseUrl: originalRequest.baseUrl,
      data: originalRequest.data,
      queryParameters: originalRequest.queryParameters,
      headers: {
        ...originalRequest.headers,
        'Authorization': 'Bearer $accessToken',
      },
      followRedirects: originalRequest.followRedirects,
      maxRedirects: originalRequest.maxRedirects,
      receiveTimeout: originalRequest.receiveTimeout,
      sendTimeout: originalRequest.sendTimeout,
      extra: originalRequest.extra,
      responseType: originalRequest.responseType,
      contentType: originalRequest.contentType,
      validateStatus: originalRequest.validateStatus,
      receiveDataWhenStatusError: originalRequest.receiveDataWhenStatusError,
    );

    return await Dio().fetch<dynamic>(updatedOptions);
  }
}

class TokenRefreshInterceptor extends Interceptor {
  final TokenManager _tokenManager;
  final Dio _dio;
  final Logger _logger;

  TokenRefreshInterceptor({
    required TokenManager tokenManager,
    required Dio dio,
    Logger? logger,
  }) : _tokenManager = tokenManager,
       _dio = dio,
       _logger = logger ?? Logger();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Only handle token refresh for specific endpoints
    if (_shouldRefreshToken(err)) {
      _logger.d('Attempting automatic token refresh');
      
      try {
        final newAccessToken = await _performTokenRefresh();
        if (newAccessToken != null) {
          // Update the request with new token
          err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
          
          // Retry the original request
          final response = await _dio.fetch<dynamic>(err.requestOptions);
          handler.resolve(response);
          return;
        }
      } catch (e) {
        _logger.e('Automatic token refresh failed: $e');
      }
      
      // Clear tokens and propagate error
      await _tokenManager.clearTokens();
    }

    handler.next(err);
  }

  bool _shouldRefreshToken(DioException err) {
    return err.response?.statusCode == 401 && 
           !err.requestOptions.path.contains('/auth/refresh');
  }

  Future<String?> _performTokenRefresh() async {
    try {
      final refreshToken = await _tokenManager.getRefreshToken();
      if (refreshToken == null) {
        return null;
      }

      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.refresh,
        data: {'refreshToken': refreshToken},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final accessToken = data['accessToken'] as String?;
        final newRefreshToken = data['refreshToken'] as String?;

        if (accessToken != null) {
          await _tokenManager.saveTokenPair(
            accessToken: accessToken,
            refreshToken: newRefreshToken ?? refreshToken,
          );
          return accessToken;
        }
      }
    } catch (e) {
      _logger.e('Token refresh failed: $e');
    }

    return null;
  }
}
