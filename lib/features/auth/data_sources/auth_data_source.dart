import 'dart:core';

import 'package:blox/features/auth/models/app_user.dart';

abstract class AuthDataSource {
  Stream<AppUser?> getAppUser();
  Future<void> signInWithGoogle();
  Future<void> signOut();
}
