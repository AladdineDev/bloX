import 'package:blox/features/auth/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension AppUserExtension on User {
  AppUser get toAppUser {
    return AppUser(
      id: uid,
      email: email,
      displayName: displayName,
      photoURL: photoURL,
      phoneNumber: phoneNumber,
    );
  }
}
