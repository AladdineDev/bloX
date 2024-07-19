import 'package:blox/features/auth/data_sources/remote_auth_data_source.dart';
import 'package:blox/features/auth/models/app_user.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  AuthRepository({required this.remoteAuthDataSource});

  final RemoteAuthDataSource remoteAuthDataSource;

  Stream<AppUser?> getAppUser() {
    return remoteAuthDataSource.getAppUser();
  }

  Future<void> signInWithGoogle() async {
    try {
      await remoteAuthDataSource.signInWithGoogle();
    } catch (e) {
      //TODO: handle exception
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await remoteAuthDataSource.signOut();
      //TODO: handle exception
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
