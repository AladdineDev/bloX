import 'package:blox/features/auth/models/app_user.dart';
import 'package:blox/features/profil/repositories/app_user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blox/core/exceptions/app_exception.dart';
import 'package:equatable/equatable.dart';

part 'app_user_event.dart';
part 'app_user_state.dart';

class AppUserBloc extends Bloc<AppUserEvent, AppUserState> {
  final AppUserRepository appUserRepository;

  AppUserBloc({required this.appUserRepository}) : super(const AppUserState()) {
    on<GetOneAppUser>(_onGetOneAppUser);
  }

  Future<void> _onGetOneAppUser(
    GetOneAppUser event,
    Emitter<AppUserState> emit,
  ) async {
    emit(state.copyWith(status: AppUserStatus.progressFetchingAppUser));
    try {
      final appUserStream =
          appUserRepository.getAppUser(appUserId: event.appUserId);
      await emit.forEach(appUserStream, onData: (appUser) {
        return state.copyWith(
          status: AppUserStatus.successFetchingAppUser,
          appUser: appUser,
        );
      });
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: AppUserStatus.failureFetchingAppUser,
          error: e,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AppUserStatus.failureFetchingAppUser,
          error: const UnknownException(),
        ),
      );
    }
  }
}
