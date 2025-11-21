import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../data/datasources/local/auth_local_datasource.dart';
import '../../../../data/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({required AuthLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<User> login(String email, String password) async {
    final user = await _localDataSource.getUser(email);
    if (user == null) {
      throw Exception('User not found');
    }
    
    // Simple password validation (in real app, use proper hashing)
    if (user.password != password) {
      throw Exception('Invalid password');
    }
    
    return User(
      id: user.id,
      name: user.name,
      email: user.email,
      avatar: user.avatar,
      accessToken: user.accessToken,
      cefrLevel: user.cefrLevel,
      xp: user.xp,
      streak: user.streak,
    );
  }

  @override
  Future<User> signup(String name, String email, String password) async {
    // Check if user already exists
    final existingUser = await _localDataSource.getUser(email);
    if (existingUser != null) {
      throw Exception('User already exists');
    }
    
    // Create new user
    final newUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      password: password, // In real app, hash this
      avatar: null,
      accessToken: 'local_token_${DateTime.now().millisecondsSinceEpoch}',
      cefrLevel: 'A1',
      xp: 0,
      streak: 0,
    );
    
    await _localDataSource.saveUser(newUser);
    
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
  }

  @override
  Future<User?> getCurrentUser() async {
    // Get the most recently saved user (for simplicity)
    // In real app, use token storage to identify current user
    final users = await _localDataSource.getAllUsers();
    if (users.isNotEmpty) {
      final lastUser = users.last;
      return User(
        id: lastUser.id,
        name: lastUser.name,
        email: lastUser.email,
        avatar: lastUser.avatar,
        accessToken: lastUser.accessToken,
        cefrLevel: lastUser.cefrLevel,
        xp: lastUser.xp,
        streak: lastUser.streak,
      );
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await _localDataSource.logout();
  }
}
