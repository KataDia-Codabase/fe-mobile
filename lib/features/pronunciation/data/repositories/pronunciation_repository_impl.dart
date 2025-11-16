import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import '../../domain/models/pronunciation_session.dart';
import '../../domain/repositories/pronunciation_repository.dart';
import '../datasources/pronunciation_local_datasource_simple.dart';
import '../datasources/pronunciation_remote_datasource_simple.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';

class PronunciationRepositoryImpl implements PronunciationRepository {
  final PronunciationRemoteDataSource remoteDataSource;
  final PronunciationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final Logger logger;

  PronunciationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.logger,
  });

  @override
  Future<Either<Failure, String>> uploadAudio({
    required String audioPath,
    required String sessionId,
    required String lessonId,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final uploadResult = await remoteDataSource.uploadAudio(
          audioPath: audioPath,
          sessionId: sessionId,
          lessonId: lessonId,
        );
        
        // Cache the upload result locally
        await localDataSource.cacheUploadInfo(sessionId, uploadResult);
        
        return Right(uploadResult);
      } else {
        // Queue upload for when network is available
        await localDataSource.queueUpload(
          audioPath: audioPath,
          sessionId: sessionId,
          lessonId: lessonId,
        );
        return const Left(NetworkFailure('No internet connection. Recording queued for later upload.'));
      }
    } on ServerFailure catch (e) {
      logger.e('Server failure during upload: ${e.message}');
      return Left(e);
    } on NetworkFailure catch (e) {
      logger.e('Network failure during upload: ${e.message}');
      return Left(e);
    } catch (e) {
      logger.e('Unexpected error during upload: $e');
      return Left(UnexpectedFailure('Upload failed: $e'));
    }
  }

  @override
  Future<Either<Failure, PronunciationEvaluationResult>> getEvaluationResult(
    String sessionId,
  ) async {
    try {
      // First check local cache
      final cachedResult = await localDataSource.getEvaluationResult(sessionId);
      if (cachedResult != null) {
        return Right(cachedResult);
      }

      // If not cached, try to fetch from remote
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getEvaluationResult(sessionId);
        
        // Cache the result locally
        await localDataSource.saveEvaluationResult(result);
        
        return Right(result);
      } else {
        return const Left(NetworkFailure('No internet connection and no cached result available.'));
      }
    } on ServerFailure catch (e) {
      logger.e('Server failure getting evaluation result: ${e.message}');
      return Left(e);
    } on NetworkFailure catch (e) {
      logger.e('Network failure getting evaluation result: ${e.message}');
      return Left(e);
    } catch (e) {
      logger.e('Unexpected error getting evaluation result: $e');
      return Left(UnexpectedFailure('Failed to get evaluation result: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> saveEvaluationResult(
    PronunciationEvaluationResult result,
  ) async {
    try {
      await localDataSource.saveEvaluationResult(result);
      return const Right(null);
    } on CacheFailure catch (e) {
      logger.e('Cache failure saving evaluation result: ${e.message}');
      return Left(e);
    } catch (e) {
      logger.e('Unexpected error saving evaluation result: $e');
      return Left(UnexpectedFailure('Failed to save evaluation result: $e'));
    }
  }

  @override
  Future<Either<Failure, List<PronunciationEvaluationResult>>> getHistory({
    int limit = 20,
    int offset = 0,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      // Always fetch from local cache first for history
      final history = await localDataSource.getHistory(
        limit: limit,
        offset: offset,
        startDate: startDate,
        endDate: endDate,
      );

      // If online, try to sync and get latest data
      if (await networkInfo.isConnected) {
        try {
          final remoteHistory = await remoteDataSource.getHistory(
            limit: limit,
            offset: offset,
            startDate: startDate,
            endDate: endDate,
          );
          
          // Update local cache with remote data
          for (final result in remoteHistory) {
            await localDataSource.saveEvaluationResult(result);
          }
          
          return Right(remoteHistory);
        } catch (e) {
          logger.w('Failed to fetch remote history, using local cache: $e');
        }
      }

      return Right(history);
    } on CacheFailure catch (e) {
      logger.e('Cache failure getting history: ${e.message}');
      return Left(e);
    } catch (e) {
      logger.e('Unexpected error getting history: $e');
      return Left(UnexpectedFailure('Failed to get history: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSession(String sessionId) async {
    try {
      // Delete from local cache first
      await localDataSource.deleteSession(sessionId);

      // If online, also delete from remote
      if (await networkInfo.isConnected) {
        await remoteDataSource.deleteSession(sessionId);
      }

      return const Right(null);
    } on ServerFailure catch (e) {
      logger.e('Server failure deleting session: ${e.message}');
      return Left(e);
    } on CacheFailure catch (e) {
      logger.e('Cache failure deleting session: ${e.message}');
      return Left(e);
    } catch (e) {
      logger.e('Unexpected error deleting session: $e');
      return Left(UnexpectedFailure('Failed to delete session: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getStatistics() async {
    try {
      // Get from local cache first
      final localStats = await localDataSource.getStatistics();

      // If online, try to sync with remote statistics
      if (await networkInfo.isConnected) {
        try {
          final remoteStats = await remoteDataSource.getStatistics();
          
          // Update local cache with latest statistics
          await localDataSource.saveStatistics(remoteStats);
          
          return Right(remoteStats);
        } catch (e) {
          logger.w('Failed to fetch remote statistics, using local cache: $e');
        }
      }

      return Right(localStats);
    } on CacheFailure catch (e) {
      logger.e('Cache failure getting statistics: ${e.message}');
      return Left(e);
    } catch (e) {
      logger.e('Unexpected error getting statistics: $e');
      return Left(UnexpectedFailure('Failed to get statistics: $e'));
    }
  }

  @override
  Future<bool> hasMicrophonePermission() async {
    return await localDataSource.hasMicrophonePermission();
  }

  @override
  Future<Either<Failure, bool>> requestMicrophonePermission() async {
    try {
      final hasPermission = await localDataSource.requestMicrophonePermission();
      return Right(hasPermission);
    } on PermissionFailure catch (e) {
      logger.e('Permission failure: ${e.message}');
      return Left(e);
    } catch (e) {
      logger.e('Unexpected error requesting permission: $e');
      return Left(UnexpectedFailure('Failed to request permission: $e'));
    }
  }

  @override
  Stream<Map<String, dynamic>> connectRealTimeScoring(String sessionId) {
    try {
      return remoteDataSource.connectRealTimeScoring(sessionId);
    } catch (e) {
      logger.e('Error connecting to real-time scoring: $e');
      return Stream.error(UnexpectedFailure('Failed to connect to real-time scoring: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getPersonalizedFeedback(
    String userId,
    String sessionId,
  ) async {
    try {
      // Fetch from remote if online
      if (await networkInfo.isConnected) {
        final feedback = await remoteDataSource.getPersonalizedFeedback(userId, sessionId);
        return Right(feedback);
      } else {
        return const Left(NetworkFailure('No internet connection'));
      }
    } on ServerFailure catch (e) {
      logger.e('Server failure getting personalized feedback: ${e.message}');
      return Left(e);
    } catch (e) {
      logger.e('Unexpected error getting personalized feedback: $e');
      return Left(UnexpectedFailure('Failed to get personalized feedback: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getLearningPathRecommendations(
    String userId,
  ) async {
    try {
      // Fetch from remote if online
      if (await networkInfo.isConnected) {
        final path = await remoteDataSource.getLearningPathRecommendations(userId);
        return Right(path);
      } else {
        return const Left(NetworkFailure('No internet connection'));
      }
    } on ServerFailure catch (e) {
      logger.e('Server failure getting learning path: ${e.message}');
      return Left(e);
    } catch (e) {
      logger.e('Unexpected error getting learning path: $e');
      return Left(UnexpectedFailure('Failed to get learning path: $e'));
    }
  }
}
