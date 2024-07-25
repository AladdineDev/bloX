import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:blox/features/auth/models/app_user.dart';
import 'package:blox/features/profil/data_sources/app_user_data_source.dart';
import 'package:blox/features/profil/repositories/app_user_repository.dart';
import 'package:blox/core/exceptions/app_exception.dart';

part 'edit_user_event.dart';
part 'edit_user_state.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  EditUserBloc(this.userRepository) : super(const EditUserState()) {
    on<LoadUser>(_onLoadUser);
    on<SaveUser>(_onSaveUser);
  }

  final AppUserRepository userRepository;

  Future<void> _onLoadUser(LoadUser event, Emitter<EditUserState> emit) async {
    emit(state.copyWith(status: EditUserStatus.loading));
    try {
      final userStream = userRepository.getAppUser(appUserId: event.userId);
      await emit.forEach<AppUser?>(
        userStream,
        onData: (user) => state.copyWith(
          status: EditUserStatus.success,
          user: user,
        ),
        onError: (error, stackTrace) => state.copyWith(
          status: EditUserStatus.failure,
          error: AppException.fromException(error),
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: EditUserStatus.failure,
        error: AppException.fromException(e),
      ));
    }
  }

  Future<void> _onSaveUser(SaveUser event, Emitter<EditUserState> emit) async {
    emit(state.copyWith(status: EditUserStatus.loading));
    try {
      await userRepository.updateAppUser(appUser: event.user);
      emit(state.copyWith(status: EditUserStatus.success, user: event.user));
    } catch (e) {
      emit(state.copyWith(
        status: EditUserStatus.failure,
        error: AppException.fromException(e),
      ));
    }
  }
}
