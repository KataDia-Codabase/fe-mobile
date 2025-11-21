import 'package:katadia_fe/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:katadia_fe/features/authentication/domain/usecases/login_usecase.dart';
import 'package:katadia_fe/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:katadia_fe/data/datasources/local/database_service.dart';
import 'package:katadia_fe/data/datasources/local/auth_local_datasource.dart';
import 'package:katadia_fe/data/repositories/auth_repository_impl.dart';

class AuthBLocProvider {
  static late AuthBLoC _authBLoC;
  static bool _initialized = false;

  static void initialize() {
    if (_initialized) return;

    final databaseService = DatabaseService();
    final localDataSource = AuthLocalDataSourceImpl(databaseService: databaseService);
    final authRepository = AuthRepositoryImpl(localDataSource: localDataSource);

    _authBLoC = AuthBLoC(
      loginUseCase: LoginUseCase(authRepository: authRepository),
      signupUseCase: SignupUseCase(authRepository: authRepository),
    );

    _initialized = true;
  }

  static AuthBLoC get instance {
    if (!_initialized) {
      initialize();
    }
    return _authBLoC;
  }
}
