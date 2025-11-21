import 'package:katadia_fe/core/utils/index.dart';
import '../../features/authentication/domain/entities/user_entity.dart';
import '../../features/authentication/domain/repositories/auth_repository.dart';
import '../datasources/local/auth_local_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({required AuthLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<User> login(String email, String password) async {
    try {
      final userModel = await _localDataSource.getUser(email);

      if (userModel == null) {
        throw Exception('Email atau password salah');
      }

      Logger.success('Login successful', tag: 'Repository');
      return User(
        id: userModel.id,
        name: userModel.name,
        email: userModel.email,
        avatar: userModel.avatar,
        accessToken: userModel.accessToken,
        cefrLevel: userModel.cefrLevel,
        xp: userModel.xp,
        streak: userModel.streak,
      );
    } catch (e) {
      Logger.error('Login failed', tag: 'Repository', error: e);
      rethrow;
    }
  }

  @override
  Future<User> signup(String name, String email, String password) async {
    try {
      // Check if user already exists
      final existingUser = await _localDataSource.getUser(email);
      if (existingUser != null) {
        throw Exception('Email sudah terdaftar');
      }

      // Generate simple ID (in production, use UUID or server-generated)
      final userId = 'user_${DateTime.now().millisecondsSinceEpoch}';

      final newUser = UserModel(
        id: userId,
        name: name,
        email: email,
        password: password,
        cefrLevel: 'A1',
        xp: 0,
        streak: 0,
      );

      await _localDataSource.saveUser(newUser);
      Logger.success('Signup successful', tag: 'Repository');

      return User(
        id: newUser.id,
        name: newUser.name,
        email: newUser.email,
        avatar: newUser.avatar,
        accessToken: newUser.accessToken,
        cefrLevel: newUser.cefrLevel,
        xp: newUser.xp,
        streak: newUser.streak,
      );
    } catch (e) {
      Logger.error('Signup failed', tag: 'Repository', error: e);
      rethrow;
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      // This would typically retrieve from a secure storage
      // For now, returning null as no session is stored
      return null;
    } catch (e) {
      Logger.error('Get current user failed', tag: 'Repository', error: e);
      return null;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _localDataSource.logout();
      Logger.info('Logout successful', tag: 'Repository');
    } catch (e) {
      Logger.error('Logout failed', tag: 'Repository', error: e);
      rethrow;
    }
  }
}
