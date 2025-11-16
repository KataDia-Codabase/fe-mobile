import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);
  
  final String message;
  
  @override
  List<Object?> get props => [message];
}

// Specific Failure Types for Lessons

class NetworkFailure extends Failure {
  const NetworkFailure(String message, {this.statusCode})
      : super(message);
  
  final int? statusCode;
  
  @override
  List<Object?> get props => [message, if (statusCode != null) statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure(String message, {this.statusCode})
      : super(message);
  
  final int? statusCode;
  
  @override
  List<Object?> get props => [message, if (statusCode != null) statusCode];
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(String message) : super(message);
}

class PermissionFailure extends Failure {
  const PermissionFailure(String message, {this.permissionType})
      : super(message);
  
  final String? permissionType;
  
  @override
  List<Object?> get props => [message, if (permissionType != null) permissionType];
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(String message) : super(message);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure(String message) : super(message);
}

class AudioFailure extends Failure {
  const AudioFailure(String message) : super(message);
}

class FileSystemFailure extends Failure {
  const FileSystemFailure(String message, {this.path})
      : super(message);
  
  final String? path;
  
  @override
  List<Object?> get props => [message, if (path != null) path];
}

 class SyncFailure extends Failure {
  const SyncFailure(String message) : super(message);
}

class ParsingFailure extends Failure {
  const ParsingFailure(String message) : super(message);
}

class StorageFailure extends Failure {
  const StorageFailure(String message, {this.storageType})
      : super(message);
  
  final String? storageType;
  
  @override
  List<Object?> get props => [message, if (storageType != null) storageType];
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(String message, {this.stackTrace})
      : super(message);
  
  final StackTrace? stackTrace;
  
  @override
  List<Object?> get props => [message, if (stackTrace != null) stackTrace];
}

// Lesson-specific Failures

class LessonNotFoundFailure extends NotFoundFailure {
  const LessonNotFoundFailure(String lessonId) 
      : super('Lesson with id $lessonId not found');
}

class ContentNotFoundFailure extends NotFoundFailure {
  const ContentNotFoundFailure(String contentId) 
      : super('Content with id $contentId not found');
}

class DownloadFailure extends Failure {
  const DownloadFailure(String message, {this.contentId})
      : super(message);
  
  final String? contentId;
  
  @override
  List<Object?> get props => [message, if (contentId != null) contentId];
}

class PlaybackFailure extends AudioFailure {
  const PlaybackFailure(String message, {this.contentId})
      : super(message);
  
  final String? contentId;
  
  @override
  List<Object?> get props => [message, if (contentId != null) contentId];
}

class RecordingFailure extends AudioFailure {
  const RecordingFailure(String message) : super(message);
}

class ProgressFailure extends Failure {
  const ProgressFailure(String message, {this.lessonId})
      : super(message);
  
  final String? lessonId;
  
  @override
  List<Object?> get props => [message, if (lessonId != null) lessonId];
}

class CacheLimitExceededFailure extends StorageFailure {
  const CacheLimitExceededFailure(String message, {this.currentSize, this.maxSize})
      : super(message, storageType: 'cache');
  
  final int? currentSize;
  final int? maxSize;
  
  @override
  List<Object?> get props => [
        message, 
        storageType,
        if (currentSize != null) currentSize,
        if (maxSize != null) maxSize,
      ];
}

class InsufficientStorageFailure extends StorageFailure {
  const InsufficientStorageFailure(String message, {this.requiredSpace})
      : super(message, storageType: 'device');
  
  final int? requiredSpace;
  
  @override
  List<Object?> get props => [message, storageType, if (requiredSpace != null) requiredSpace];
}
