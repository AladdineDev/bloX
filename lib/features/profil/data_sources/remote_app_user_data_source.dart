import 'package:blox/core/extensions/firebase_firestore_extension.dart';
import 'package:blox/features/auth/data_sources/remote_auth_data_source.dart';
import 'package:blox/features/auth/models/app_user.dart';
import 'package:blox/features/profil/data_sources/app_user_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemoteAppUserDataSource extends AppUserDataSource {
  RemoteAppUserDataSource();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const usersCollectionPath = RemoteAuthDataSource.usersCollectionPath;
  static String appUserDocPath({required AppUserId userId}) {
    return RemoteAuthDataSource.appUserDocPath(userId: userId);
  }

  @override
  Stream<AppUser?> getAppUser({required AppUserId appUserId}) {
    final userDoc = _firestore.appUserDocument(
      documentPath: appUserDocPath(userId: appUserId),
    );
    return userDoc.snapshots().map((snapshot) => snapshot.data());
  }

  @override
  Future<void> updateAppUser({required AppUser appUser}) async {
    final userDoc = _firestore.appUserDocument(
      documentPath: appUserDocPath(userId: appUser.id!),
    );
    await userDoc.update(appUser.toJson());
  }

  @override
  Future<void> deleteAppUser({required AppUserId appUserId}) async {
    final userDoc = _firestore.appUserDocument(
      documentPath: appUserDocPath(userId: appUserId),
    );
    await userDoc.delete();
  }
}
