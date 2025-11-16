import 'package:equatable/equatable.dart';

// Base exception class
abstract class BaseException extends Equatable implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  const BaseException({
    required this.message,
    this.code,
    this.details,
  });

  @override
  List<Object?> get props => [message, code, details];

  @override
  String toString() => 'BaseException: $message';
}

// Network Exceptions
class NetworkException extends BaseException {
  const NetworkException({
    required super.message,
    super.code,
    super.details,
  });

  factory NetworkException.noConnection() {
    return const NetworkException(
      message: 'No internet connection',
      code: 'NO_CONNECTION',
    );
  }

  factory NetworkException.requestTimeout() {
    return const NetworkException(
      message: 'Request timeout',
      code: 'REQUEST_TIMEOUT',
    );
  }

  factory NetworkException.serverError({String? message}) {
    return NetworkException(
      message: message ?? 'Server error occurred',
      code: 'SERVER_ERROR',
    );
  }

  factory NetworkException.unauthorized({String? message}) {
    return NetworkException(
      message: message ?? 'Unauthorized access',
      code: 'UNAUTHORIZED',
    );
  }

  factory NetworkException.forbidden({String? message}) {
    return NetworkException(
      message: message ?? 'Access forbidden',
      code: 'FORBIDDEN',
    );
  }

  factory NetworkException.notFound({String? message}) {
    return NetworkException(
      message: message ?? 'Resource not found',
      code: 'NOT_FOUND',
    );
  }

  factory NetworkException.rateLimitExceeded({String? message}) {
    return NetworkException(
      message: message ?? 'Too many requests, please try again later',
      code: 'RATE_LIMIT_EXCEEDED',
    );
  }
}

// Authentication Exceptions
class AuthenticationException extends BaseException {
  const AuthenticationException({
    required super.message,
    super.code,
    super.details,
  });

  factory AuthenticationException.invalidCredentials() {
    return const AuthenticationException(
      message: 'Invalid email or password',
      code: 'INVALID_CREDENTIALS',
    );
  }

  factory AuthenticationException.emailAlreadyInUse() {
    return const AuthenticationException(
      message: 'Email is already in use',
      code: 'EMAIL_ALREADY_IN_USE',
    );
  }

  factory AuthenticationException.weakPassword() {
    return const AuthenticationException(
      message: 'Password is too weak',
      code: 'WEAK_PASSWORD',
    );
  }

  factory AuthenticationException.sessionExpired() {
    return const AuthenticationException(
      message: 'Session has expired, please login again',
      code: 'SESSION_EXPIRED',
    );
  }

  factory AuthenticationException.tokenRefreshFailed() {
    return const AuthenticationException(
      message: 'Failed to refresh authentication token',
      code: 'TOKEN_REFRESH_FAILED',
    );
  }

  factory AuthenticationException.socialLoginFailed(String provider) {
    return AuthenticationException(
      message: 'Failed to login with $provider',
      code: 'SOCIAL_LOGIN_FAILED',
      details: {'provider': provider},
    );
  }
}

// Validation Exceptions
class ValidationException extends BaseException {
  const ValidationException({
    required super.message,
    super.code,
    super.details,
  });

  factory ValidationException.invalidEmail() {
    return const ValidationException(
      message: 'Please enter a valid email address',
      code: 'INVALID_EMAIL',
    );
  }

  factory ValidationException.invalidPassword() {
    return const ValidationException(
      message: 'Password must be at least 8 characters long',
      code: 'INVALID_PASSWORD',
    );
  }

  factory ValidationException.invalidName() {
    return const ValidationException(
      message: 'Please enter a valid name',
      code: 'INVALID_NAME',
    );
  }

  factory ValidationException.requiredField(String fieldName) {
    return ValidationException(
      message: '$fieldName is required',
      code: 'REQUIRED_FIELD',
      details: {'field': fieldName},
    );
  }

  factory ValidationException.custom({
    required String message,
    String? code,
    dynamic details,
  }) {
    return ValidationException(
      message: message,
      code: code ?? 'VALIDATION_ERROR',
      details: details,
    );
  }
}

// File/Storage Exceptions
class FileException extends BaseException {
  const FileException({
    required super.message,
    super.code,
    super.details,
  });

  factory FileException.fileNotFound() {
    return const FileException(
      message: 'File not found',
      code: 'FILE_NOT_FOUND',
    );
  }

  factory FileException.fileTooLarge(String maxSize) {
    return FileException(
      message: 'File size exceeds maximum allowed size of $maxSize',
      code: 'FILE_TOO_LARGE',
      details: {'maxSize': maxSize},
    );
  }

  factory FileException.unsupportedFileType(String supportedTypes) {
    return FileException(
      message: 'Unsupported file type. Supported types: $supportedTypes',
      code: 'UNSUPPORTED_FILE_TYPE',
      details: {'supportedTypes': supportedTypes},
    );
  }

  factory FileException.uploadFailed() {
    return const FileException(
      message: 'File upload failed',
      code: 'UPLOAD_FAILED',
    );
  }

  factory FileException.storageLimitExceeded() {
    return const FileException(
      message: 'Storage limit exceeded',
      code: 'STORAGE_LIMIT_EXCEEDED',
    );
  }
}

// Audio Recording Exceptions
class AudioException extends BaseException {
  const AudioException({
    required super.message,
    super.code,
    super.details,
  });

  factory AudioException.permissionDenied() {
    return const AudioException(
      message: 'Microphone permission denied',
      code: 'MICROPHONE_PERMISSION_DENIED',
    );
  }

  factory AudioException.recordingFailed() {
    return const AudioException(
      message: 'Failed to record audio',
      code: 'RECORDING_FAILED',
    );
  }

  factory AudioException.recordingTooLong() {
    return const AudioException(
      message: 'Recording duration is too long',
      code: 'RECORDING_TOO_LONG',
    );
  }

  factory AudioException.recordingTooShort() {
    return const AudioException(
      message: 'Recording is too short',
      code: 'RECORDING_TOO_SHORT',
    );
  }

  factory AudioException.audioProcessingFailed() {
    return const AudioException(
      message: 'Failed to process audio',
      code: 'AUDIO_PROCESSING_FAILED',
    );
  }
}

// Cache Exceptions
class CacheException extends BaseException {
  const CacheException({
    required super.message,
    super.code,
    super.details,
  });

  factory CacheException.dataNotFound() {
    return const CacheException(
      message: 'Data not found in cache',
      code: 'CACHE_DATA_NOT_FOUND',
    );
  }

  factory CacheException.cacheExpired() {
    return const CacheException(
      message: 'Cache data has expired',
      code: 'CACHE_EXPIRED',
    );
  }

  factory CacheException.cacheCorrupted() {
    return const CacheException(
      message: 'Cache data is corrupted',
      code: 'CACHE_CORRUPTED',
    );
  }

  factory CacheException.storageLimitExceeded() {
    return const CacheException(
      message: 'Cache storage limit exceeded',
      code: 'CACHE_STORAGE_LIMIT_EXCEEDED',
    );
  }
}

// Configuration Exceptions
class ConfigurationException extends BaseException {
  const ConfigurationException({
    required super.message,
    super.code,
    super.details,
  });

  factory ConfigurationException.missingConfiguration(String key) {
    return ConfigurationException(
      message: 'Missing configuration for: $key',
      code: 'MISSING_CONFIGURATION',
      details: {'key': key},
    );
  }

  factory ConfigurationException.invalidConfiguration(String key) {
    return ConfigurationException(
      message: 'Invalid configuration for: $key',
      code: 'INVALID_CONFIGURATION',
      details: {'key': key},
    );
  }
}

// General Application Exceptions
class AppException extends BaseException {
  const AppException({
    required super.message,
    super.code,
    super.details,
  });

  factory AppException.unexpected({String? message}) {
    return AppException(
      message: message ?? 'An unexpected error occurred',
      code: 'UNEXPECTED_ERROR',
    );
  }

  factory AppException.featureNotImplemented(String feature) {
    return AppException(
      message: 'Feature "$feature" is not yet implemented',
      code: 'FEATURE_NOT_IMPLEMENTED',
      details: {'feature': feature},
    );
  }

  factory AppException.operationCancelled() {
    return const AppException(
      message: 'Operation was cancelled',
      code: 'OPERATION_CANCELLED',
    );
  }
}
