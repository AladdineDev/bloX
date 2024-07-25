import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blox/features/auth/models/app_user.dart';
import 'package:blox/features/auth/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(const AuthState()) {
    on<AuthSignIn>(_onSignInWithGoogle);
    on<AuthSignOut>(_onSignOut);
    on<AuthGetAppUser>(_onWatchAppUser);
  }

  final AuthRepository authRepository;

  Future<void> _onWatchAppUser(
      AuthGetAppUser event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.progress));
    final appUserStream = authRepository.watchAppUser();
    try {
      return emit.forEach(appUserStream, onData: (appUser) {
        return state.copyWith(
          status: appUser == null
              ? AuthStatus.unauthenticated
              : AuthStatus.authenticated,
          appUser: appUser,
        );
      });
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure));
    }
  }

  Future<void> _onSignInWithGoogle(
      AuthSignIn event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.progress));
    try {
      await authRepository.signInWithGoogle();
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure));
    }
  }

  Future<void> _onSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.progress));
    try {
      await authRepository.signOut();
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          appUser: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure));
    }
  }
}
