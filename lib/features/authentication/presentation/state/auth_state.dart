import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.user,
    this.errorMessage,
  });

  const AuthState.initial()
      : status = AuthStatus.initial,
        user = null,
        errorMessage = null;

  const AuthState.loading()
      : status = AuthStatus.loading,
        user = null,
        errorMessage = null;

  const AuthState.unauthenticated()
      : status = AuthStatus.unauthenticated,
        user = null,
        errorMessage = null;

  const AuthState.authenticated(User user)
      : status = AuthStatus.authenticated,
        user = user,
        errorMessage = null;

  const AuthState.error(String message)
      : status = AuthStatus.error,
        user = null,
        errorMessage = message;

  bool get isLoading => status == AuthStatus.loading;
  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;
  bool get hasError => status == AuthStatus.error;

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'AuthState(status: $status, user: $user, errorMessage: $errorMessage)';
  }

  @override
  List<Object?> get props => [status, user, errorMessage];

  // Convenience methods for when pattern matching
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(User user) authenticated,
    required T Function() unauthenticated,
    required T Function(String message) error,
  }) {
    switch (status) {
      case AuthStatus.initial:
        return initial();
      case AuthStatus.loading:
        return loading();
      case AuthStatus.authenticated:
        return authenticated(user!);
      case AuthStatus.unauthenticated:
        return unauthenticated();
      case AuthStatus.error:
        return error(errorMessage!);
    }
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(User user)? authenticated,
    T Function()? unauthenticated,
    T Function(String message)? error,
    required T Function() orElse,
  }) {
    switch (status) {
      case AuthStatus.initial:
        if (initial != null) return initial();
        break;
      case AuthStatus.loading:
        if (loading != null) return loading();
        break;
      case AuthStatus.authenticated:
        if (authenticated != null) return authenticated(user!);
        break;
      case AuthStatus.unauthenticated:
        if (unauthenticated != null) return unauthenticated();
        break;
      case AuthStatus.error:
        if (error != null) return error(errorMessage!);
        break;
    }
    return orElse();
  }

  T map<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(User user) authenticated,
    required T Function() unauthenticated,
    required T Function(String message) error,
  }) {
    switch (status) {
      case AuthStatus.initial:
        return initial();
      case AuthStatus.loading:
        return loading();
      case AuthStatus.authenticated:
        return authenticated(user!);
      case AuthStatus.unauthenticated:
        return unauthenticated();
      case AuthStatus.error:
        return error(errorMessage!);
    }
  }

  T maybeMap<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(User user)? authenticated,
    T Function()? unauthenticated,
    T Function(String message)? error,
    required T Function() orElse,
  }) {
    switch (status) {
      case AuthStatus.initial:
        if (initial != null) return initial();
        break;
      case AuthStatus.loading:
        if (loading != null) return loading();
        break;
      case AuthStatus.authenticated:
        if (authenticated != null) return authenticated(user!);
        break;
      case AuthStatus.unauthenticated:
        if (unauthenticated != null) return unauthenticated();
        break;
      case AuthStatus.error:
        if (error != null) return error(errorMessage!);
        break;
    }
    return orElse();
  }
}
