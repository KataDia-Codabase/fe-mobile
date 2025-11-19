import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> signup(String name, String email, String password);
  Future<User?> getCurrentUser();
  Future<void> logout();
}
