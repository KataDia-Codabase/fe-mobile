import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl({required AuthRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<User> login(String email, String password) async {
    return await _remoteDataSource.login(email, password);
  }

  @override
  Future<User> signup(String name, String email, String password) async {
    return await _remoteDataSource.signup(name, email, password);
  }

  @override
  Future<User?> getCurrentUser() async {
    // TODO: Implement get current user from API
    return null;
  }

  @override
  Future<void> logout() async {
    return await _remoteDataSource.logout();
  }
}
