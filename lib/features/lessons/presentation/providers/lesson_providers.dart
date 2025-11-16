import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:katadia_app/core/database/app_database.dart';
import 'package:katadia_app/features/lessons/data/repositories/lesson_repository_impl.dart';
import 'package:katadia_app/features/lessons/data/datasources/lesson_local_datasource.dart';
import 'package:katadia_app/features/lessons/data/datasources/lesson_remote_datasource.dart';
import 'package:katadia_app/features/lessons/domain/repositories/lesson_repository.dart';
import 'package:katadia_app/core/network/network_info.dart';
import 'package:katadia_app/core/network/dio_client.dart';

// Database provider
final databaseProvider = FutureProvider<AppDatabase>((ref) async {
  return AppDatabase.create();
});

// Dio client provider  
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient.create();
});

// Network info provider
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  final connectivity = Connectivity();
  return NetworkInfoImpl(connectivity);
});

// Local data source provider
final localDataSourceProvider = FutureProvider<LessonLocalDataSource>((ref) async {
  return LessonLocalDataSourceImpl();
});

// Remote data source provider
final remoteDataSourceProvider = Provider<LessonRemoteDataSource>((ref) {
  final dioClient = ref.read(dioClientProvider);
  return LessonRemoteDataSourceImpl(dioClient);
});

// Lesson repository provider
final lessonRepositoryProvider = FutureProvider<LessonRepository>((ref) async {
  final remoteDataSource = ref.read(remoteDataSourceProvider);
  final localDataSource = await ref.read(localDataSourceProvider.future);
  final networkInfo = ref.read(networkInfoProvider);
  
  return LessonRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    networkInfo: networkInfo,
  );
});
