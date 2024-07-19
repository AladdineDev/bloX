import 'dart:core';

abstract class AuthDataSource {
  Stream<void> getAppUser();
  Future<void> signInWithGoogle();
  Future<void> signOut();
}
