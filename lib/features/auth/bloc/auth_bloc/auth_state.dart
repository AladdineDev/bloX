part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  progress,
  success,
  failure,
}

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.appUser,
  });

  final AuthStatus status;
  final AppUser? appUser;

  AuthState copyWith({
    AuthStatus? status,
    AppUser? appUser,
  }) {
    return AuthState(
      status: status ?? this.status,
      appUser: appUser ?? this.appUser,
    );
  }

  @override
  List<Object?> get props => [status, appUser];
}
