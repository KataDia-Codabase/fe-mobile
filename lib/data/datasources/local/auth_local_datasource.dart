import 'package:katadia_fe/core/utils/index.dart';
import '../../models/user_model.dart';
import 'database_service.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser(String email);
  Future<UserModel?> getUserById(String id);
  Future<void> deleteUser(String id);
  Future<void> logout();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final DatabaseService _databaseService;

  AuthLocalDataSourceImpl({required DatabaseService databaseService})
      : _databaseService = databaseService;

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      await _databaseService.insertUser(user);
      Logger.success('User saved locally', tag: 'LocalDataSource');
    } catch (e) {
      Logger.error('Failed to save user', tag: 'LocalDataSource', error: e);
      rethrow;
    }
  }

  @override
  Future<UserModel?> getUser(String email) async {
    try {
      final user = await _databaseService.getUser(email);
      if (user != null) {
        Logger.info('User retrieved from local database', tag: 'LocalDataSource');
      }
      return user;
    } catch (e) {
      Logger.error('Failed to get user', tag: 'LocalDataSource', error: e);
      rethrow;
    }
  }

  @override
  Future<UserModel?> getUserById(String id) async {
    try {
      final user = await _databaseService.getUserById(id);
      if (user != null) {
        Logger.info('User retrieved by ID from local database', tag: 'LocalDataSource');
      }
      return user;
    } catch (e) {
      Logger.error('Failed to get user by id', tag: 'LocalDataSource', error: e);
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      await _databaseService.deleteUser(id);
      Logger.info('User deleted from local database', tag: 'LocalDataSource');
    } catch (e) {
      Logger.error('Failed to delete user', tag: 'LocalDataSource', error: e);
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _databaseService.deleteAllUsers();
      Logger.info('All users deleted on logout', tag: 'LocalDataSource');
    } catch (e) {
      Logger.error('Failed to logout', tag: 'LocalDataSource', error: e);
      rethrow;
    }
  }
}
