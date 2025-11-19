import 'package:katadia_fe/core/utils/index.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository _authRepository;

  SignupUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Future<User> call(String name, String email, String password) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      throw Exception('Nama, email, dan password tidak boleh kosong');
    }

    final nameError = Validators.validateName(name);
    if (nameError != null) {
      throw Exception(nameError);
    }

    final emailError = Validators.validateEmail(email);
    if (emailError != null) {
      throw Exception(emailError);
    }

    final passwordError = Validators.validatePassword(password);
    if (passwordError != null) {
      throw Exception(passwordError);
    }

    Logger.info('Attempting signup for email: $email', tag: 'Auth');
    final user = await _authRepository.signup(name, email, password);
    Logger.success('Signup successful for ${user.name}', tag: 'Auth');

    return user;
  }
}
