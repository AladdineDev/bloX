part of 'edit_user_bloc.dart';

enum EditUserStatus {
  initial,
  loading,
  success,
  failure,
}

class EditUserState extends Equatable {
  const EditUserState({
    this.status = EditUserStatus.initial,
    this.user,
    this.error,
  });

  final EditUserStatus status;
  final AppUser? user;
  final AppException? error;

  EditUserState copyWith({
    EditUserStatus? status,
    AppUser? user,
    AppException? error,
  }) {
    return EditUserState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, user, error];
}
