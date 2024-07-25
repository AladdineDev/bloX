import 'package:blox/features/auth/models/app_user.dart';
import 'package:blox/features/profil/data_sources/app_user_data_source.dart';

class AppUserRepository {
  AppUserRepository({required this.remoteDataSource});

  final AppUserDataSource remoteDataSource;

  Stream<AppUser?> getAppUser({required AppUserId appUserId}) {
    try {
      return remoteDataSource.getAppUser(appUserId: appUserId);
    } catch (e) {
      //TODO: implement
      rethrow;
    }
  }

  Future<void> updateAppUser({required AppUser appUser}) async {
    try {
      await remoteDataSource.updateAppUser(appUser: appUser);
    } catch (e) {
      //TODO: implement
      rethrow;
    }
  }

  Future<void> deleteAppUser({required AppUserId appUserId}) async {
    try {
      await remoteDataSource.deleteAppUser(appUserId: appUserId);
    } catch (e) {
      //TODO: implement
      rethrow;
    }
  }
}
