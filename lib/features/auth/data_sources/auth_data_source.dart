import 'dart:core';

abstract class AuthDataSource {
  Stream<void> watchAppUser();
  Future<void> signInWithGoogle();
  Future<void> signOut();
}
