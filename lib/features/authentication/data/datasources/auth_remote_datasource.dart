import '../../../../core/services/index.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signup(String name, String email, String password);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSourceImpl({required ApiService apiService})
    : _apiService = apiService;

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _apiService.post(
        '/api/auth/login',
        body: {'email': email, 'password': password},
        requiresAuth: false,
      );

      final data = response['data'] as Map<String, dynamic>;
      final accessToken = response['accessToken'] as String;

      await _apiService.saveAuthToken(accessToken);

      return UserModel.fromJson(data, accessToken);
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signup(String name, String email, String password) async {
    try {
      final response = await _apiService.post(
        '/api/auth/register',
        body: {'name': name, 'email': email, 'password': password},
        requiresAuth: false,
      );

      var data = <String, dynamic>{};
      if (response['data'] != null) {
        data = response['data'] as Map<String, dynamic>;
      }
      final responseLogin = await _apiService.post(
        '/api/auth/login',
        body: {'email': email, 'password': password},
        requiresAuth: false,
      );
      final accessToken = responseLogin['accessToken'] as String;

      await _apiService.saveAuthToken(accessToken);

      return UserModel.fromJson(data, accessToken);
    } catch (e) {
      throw Exception('Signup failed: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _apiService.clearAuthToken();
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }
}
