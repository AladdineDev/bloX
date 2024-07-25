import 'dart:core';

import 'package:blox/features/auth/models/app_user.dart';

abstract class AppUserDataSource {
  Stream<AppUser?> getAppUser({required AppUserId appUserId});
  Future<void> updateAppUser({required AppUser appUser});
  Future<void> deleteAppUser({required AppUserId appUserId});
}
