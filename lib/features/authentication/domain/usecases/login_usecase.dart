import 'package:katadia_fe/core/utils/index.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Future<User> call(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email dan password tidak boleh kosong');
    }

    final emailError = Validators.validateEmail(email);
    if (emailError != null) {
      throw Exception(emailError);
    }

    final passwordError = Validators.validatePassword(password);
    if (passwordError != null) {
      throw Exception(passwordError);
    }

    Logger.info('Attempting login for email: $email', tag: 'Auth');
    final user = await _authRepository.login(email, password);
    Logger.success('Login successful for ${user.name}', tag: 'Auth');

    return user;
  }
}
