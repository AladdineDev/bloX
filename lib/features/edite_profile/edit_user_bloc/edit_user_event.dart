part of 'edit_user_bloc.dart';

sealed class EditUserEvent extends Equatable {
  const EditUserEvent();

  @override
  List<Object> get props => [];
}

final class LoadUser extends EditUserEvent {
  const LoadUser(this.userId);

  final AppUserId userId;

  @override
  List<Object> get props => [userId];
}

final class SaveUser extends EditUserEvent {
  const SaveUser(this.user);

  final AppUser user;

  @override
  List<Object> get props => [user];
}
