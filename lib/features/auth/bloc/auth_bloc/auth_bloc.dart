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
    on<AuthGetAppUser>(_onGetAppUser);
  }

  final AuthRepository authRepository;

  Future<void> _onGetAppUser(
      AuthGetAppUser event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.progress));
    final appUserStream = authRepository.getAppUser();
    try {
      await emit.forEach(appUserStream, onData: (appUser) {
        print("STATE= $state");
        return state.copyWith(
          status: AuthStatus.success,
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
      emit(state.copyWith(status: AuthStatus.success));
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
          status: AuthStatus.success,
          appUser: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure));
    }
  }
}
