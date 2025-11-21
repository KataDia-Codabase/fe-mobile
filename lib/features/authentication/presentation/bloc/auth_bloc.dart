import 'package:flutter/foundation.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import 'auth_state.dart';

class AuthBLoC {
  final LoginUseCase _loginUseCase;
  final SignupUseCase _signupUseCase;

  AuthState _state = AuthInitial();
  final List<Function(AuthState)> _listeners = [];

  AuthBLoC({
    required LoginUseCase loginUseCase,
    required SignupUseCase signupUseCase,
  })
      : _loginUseCase = loginUseCase,
        _signupUseCase = signupUseCase;

  AuthState get state => _state;

  void addListener(Function(AuthState) callback) {
    _listeners.add(callback);
  }

  void removeListener(Function(AuthState) callback) {
    _listeners.remove(callback);
  }

  void emit(AuthState newState) {
    _state = newState;
    for (var listener in _listeners) {
      listener(_state);
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _loginUseCase(email, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> signup(String name, String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _signupUseCase(name, email, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  void updateUser(User updatedUser) {
    if (_state is AuthSuccess) {
      emit(AuthSuccess(updatedUser));
      debugPrint('✅ AuthBLoC updated with new user: ${updatedUser.email}');
    }
  }

  void reset() {
    emit(AuthInitial());
  }
}
