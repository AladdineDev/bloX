part of 'app_user_bloc.dart';

sealed class AppUserEvent {}

final class GetOneAppUser extends AppUserEvent {
  GetOneAppUser(this.appUserId);

  final AppUserId appUserId;
}
