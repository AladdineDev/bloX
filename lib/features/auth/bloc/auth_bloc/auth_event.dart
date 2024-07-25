part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class AuthGetAppUser extends AuthEvent {
  const AuthGetAppUser();
}

final class AuthSignInWithGoogle extends AuthEvent {
  const AuthSignInWithGoogle();
}

final class AuthSignOut extends AuthEvent {
  const AuthSignOut();
}
