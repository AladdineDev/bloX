part of 'app_user_bloc.dart';

enum AppUserStatus {
  initial,
  progressFetchingAppUser,
  successFetchingAppUser,
  failureFetchingAppUser,
}

class AppUserState extends Equatable {
  const AppUserState({
    this.status = AppUserStatus.initial,
    this.appUser,
    this.error = const UnknownException(),
  });

  final AppUserStatus status;
  final AppUser? appUser;
  final AppException error;

  AppUserState copyWith({
    AppUserStatus? status,
    AppUser? appUser,
    AppException? error,
  }) {
    return AppUserState(
      status: status ?? this.status,
      appUser: appUser ?? this.appUser,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        appUser,
        error,
      ];
}
