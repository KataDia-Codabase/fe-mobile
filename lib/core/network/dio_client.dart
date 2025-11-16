import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../constants/app_constants.dart';
import '../errors/exceptions.dart';

class DioClient {
  final Dio _dio;
  final Logger _logger;

  DioClient({
    required Dio dio,
    Logger? logger,
  })  : _dio = dio,
        _logger = logger ?? Logger() {
    _setupInterceptors();
  }

  DioClient._create({
    required String baseUrl,
    required Duration connectTimeout,
    required Duration receiveTimeout,
    Map<String, String>? headers,
    Logger? logger,
  }) : this(
    dio: Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          ...?headers,
        },
      ),
    ),
    logger: logger,
  );

  // Factory constructor for default configuration
  factory DioClient.create({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Map<String, String>? headers,
    Logger? logger,
  }) {
    return DioClient._create(
      baseUrl: baseUrl ?? ApiEndpoints.baseUrl,
      connectTimeout: connectTimeout ?? AppConstants.connectionTimeout,
      receiveTimeout: receiveTimeout ?? AppConstants.apiTimeout,
      headers: headers,
      logger: logger,
    );
  }

  void _setupInterceptors() {
    // Request interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.d('REQUEST[${options.method}] => PATH: ${options.path}');
          if (options.data != null) {
            _logger.d('REQUEST DATA: ${options.data}');
          }
          if (options.queryParameters.isNotEmpty) {
            _logger.d('QUERY PARAMETERS: ${options.queryParameters}');
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.d(
            'RESPONSE[${response.requestOptions.method}] => '
            'STATUS: ${response.statusCode} '
            'PATH: ${response.requestOptions.path}',
          );
          _logger.d('RESPONSE DATA: ${response.data}');
          handler.next(response);
        },
        onError: (error, handler) {
          final request = error.requestOptions;
          _logger.e(
            'ERROR[${request.method}] => '
            'STATUS: ${error.response?.statusCode} '
            'PATH: ${request.path}',
            error: error,
          );
          
          final failure = _handleError(error);
          handler.reject(DioException(
            requestOptions: request,
            error: failure,
            type: error.type,
            response: error.response,
          ));
        },
      ),
    );

    // Retry interceptor
    _dio.interceptors.add(
      RetryInterceptor(
        dio: _dio,
        logger: _logger,
      ),
    );
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<dynamic>> head(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.head(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<dynamic>> uploadFile(
    String path,
    File file, {
    Map<String, dynamic>? fields,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final fileName = file.path.split('/').last;
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
        ...?fields,
      });

      return await _dio.post(
        path,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
        onSendProgress: onSendProgress,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  void updateHeaders(Map<String, String> headers) {
    _dio.options.headers.addAll(headers);
  }

  void updateToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearToken() {
    _dio.options.headers.remove('Authorization');
  }

  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return NetworkException.requestTimeout();
      case DioExceptionType.cancel:
        return AppException.operationCancelled();
      case DioExceptionType.connectionError:
        return NetworkException.noConnection();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;
        
        switch (statusCode) {
          case 400:
            return _handleBadRequest(data);
          case 401:
            return NetworkException.unauthorized(
              message: data?['message'] as String?,
            );
          case 403:
            return NetworkException.forbidden(
              message: data?['message'] as String?,
            );
          case 404:
            return NetworkException.notFound(
              message: data?['message'] as String?,
            );
          case 429:
            return NetworkException.rateLimitExceeded(
              message: data?['message'] as String?,
            );
          case 500:
          case 502:
          case 503:
          case 504:
            return NetworkException.serverError(
              message: data?['message'] as String?,
            );
          default:
            return NetworkException.serverError(
              message: data?['message'] as String?,
            );
        }
      case DioExceptionType.unknown:
      default:
        if (error.error is SocketException) {
          return NetworkException.noConnection();
        }
        return AppException.unexpected(message: error.toString());
    }
  }

  Exception _handleBadRequest(dynamic data) {
    if (data is Map<String, dynamic>) {
      final message = data['message'] as String?;
      final code = data['code'] as String?;
      final errors = data['errors'] as Map<String, dynamic>?;

      if (errors != null) {
        // Handle validation errors
        final firstError = errors.entries.first;
        return ValidationException.custom(
          message: firstError.value.toString(),
          code: code,
          details: errors,
        );
      }

      switch (code) {
        case 'INVALID_CREDENTIALS':
          return AuthenticationException.invalidCredentials();
        case 'EMAIL_ALREADY_IN_USE':
          return AuthenticationException.emailAlreadyInUse();
        case 'WEAK_PASSWORD':
          return AuthenticationException.weakPassword();
        case 'INVALID_EMAIL':
          return ValidationException.invalidEmail();
        case 'INVALID_PASSWORD':
          return ValidationException.invalidPassword();
        case 'INVALID_NAME':
          return ValidationException.invalidName();
        case 'FILE_TOO_LARGE':
          final maxSize = data['maxSize'] as String?;
          return FileException.fileTooLarge(maxSize ?? '10MB');
        case 'UNSUPPORTED_FILE_TYPE':
          final supportedTypes = data['supportedTypes'] as String?;
          return FileException.unsupportedFileType(
            supportedTypes ?? 'jpg, png, mp3, wav',
          );
        default:
          return ValidationException.custom(
            message: message ?? 'Bad request',
            code: code,
            details: data,
          );
      }
    }

    return ValidationException.custom(message: data.toString());
  }
}

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final Logger logger;
  final int maxRetries = 3;
  final Duration retryDelay = const Duration(seconds: 1);

  RetryInterceptor({
    required this.dio,
    required this.logger,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final extra = err.requestOptions.extra;
    final retryCount = extra['retryCount'] as int? ?? 0;

    if (_shouldRetry(err) && retryCount < maxRetries) {
      logger.d('Retrying request... Attempt ${retryCount + 1}/$maxRetries');
      
      extra['retryCount'] = retryCount + 1;
      
      // Wait before retrying
      await Future<void>.delayed(retryDelay);
      
      try {
        final response = await dio.fetch<dynamic>(err.requestOptions);
        handler.resolve(response);
        return;
      } catch (e) {
        logger.e('Retry failed: $e');
      }
    }

    super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    // Don't retry for these status codes
    if (err.response != null) {
      final statusCode = err.response!.statusCode;
      if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
        return false;
      }
    }

    // Retry for network errors and server errors
    return err.type == DioExceptionType.connectionError ||
           err.type == DioExceptionType.connectionTimeout ||
           err.type == DioExceptionType.receiveTimeout ||
           (err.type == DioExceptionType.badResponse &&
               err.response?.statusCode != null &&
               err.response!.statusCode! >= 500);
  }
}
