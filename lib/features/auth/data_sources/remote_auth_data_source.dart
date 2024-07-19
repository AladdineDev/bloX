import 'package:blox/core/extensions/app_user_extension.dart';
import 'package:blox/features/auth/data_sources/auth_data_source.dart';
import 'package:blox/features/auth/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RemoteAuthDataSource extends AuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.standard();

  static const appUsersCollectionPath = 'appUsers';
  static String appUserPath({required AppUserId appUserId}) {
    return '$appUsersCollectionPath/$appUserId';
  }

  @override
  Stream<AppUser?> getAppUser() {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser?.toAppUser;
    });
  }

  @override
  Future<void> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      _googleSignIn.signOut(),
      _firebaseAuth.signOut(),
    ]);
  }
}
