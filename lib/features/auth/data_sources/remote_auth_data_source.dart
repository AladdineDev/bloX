import 'package:blox/core/extensions/app_user_extension.dart';
import 'package:blox/core/extensions/firebase_firestore_extension.dart';
import 'package:blox/features/auth/data_sources/auth_data_source.dart';
import 'package:blox/features/auth/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RemoteAuthDataSource extends AuthDataSource {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _googleSignIn = GoogleSignIn.standard();

  static const usersCollectionPath = 'users';
  static String appUserDocPath({required AppUserId userId}) {
    return '$usersCollectionPath/$userId';
  }

  @override
  Stream<AppUser?> watchAppUser() {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser?.toAppUser;
    });
  }

  @override
  Future<void> signInWithGoogle() async {
    print("appUser1:");
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final appUser = userCredential.user!.toAppUser;
    print("appUser: $appUser");
    await _checkAndCreateUser(appUser);
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      _googleSignIn.signOut(),
      _firebaseAuth.signOut(),
    ]);
  }

  Future<void> _checkAndCreateUser(AppUser user) async {
    final userDoc = await _firestore
        .appUserDocument(documentPath: appUserDocPath(userId: user.id!))
        .get();
    if (!userDoc.exists) {
      await _firestore.appUsersCollection().doc(user.id).set(user);
    }
  }
}
