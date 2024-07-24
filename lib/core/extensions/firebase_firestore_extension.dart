import 'package:blox/features/auth/data_sources/auth_data_source.dart';
import 'package:blox/features/auth/data_sources/remote_auth_data_source.dart';
import 'package:blox/features/auth/models/app_user.dart';
import 'package:blox/features/tweet/data_sources/post_data_source.dart';
import 'package:blox/features/tweet/data_sources/remote_post_data_source.dart';
import 'package:blox/features/tweet/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

typedef ModelFromFirestore<T> = T Function(Map<String, dynamic> json);
typedef ModelToFirestore<T> = Map<String, Object?> Function(T value);

extension FirebaseFirestoreExtension on FirebaseFirestore {
  CollectionReference<R> collectionWithConverter<R extends Object?>({
    required String collectionPath,
    required ModelFromFirestore<R> fromJson,
    required ModelToFirestore<R> toJson,
  }) {
    final collectionRef = collection(collectionPath);
    return collectionRef.withConverter(
      fromFirestore: (snapshot, _) {
        final data = snapshot.data()!;
        data['id'] = snapshot.id;
        return fromJson(data);
      },
      toFirestore: (value, _) => toJson(value),
    );
  }

  DocumentReference<R> documentWithConverter<R extends Object?>({
    required String documentPath,
    required ModelFromFirestore<R> fromJson,
    required ModelToFirestore<R> toJson,
  }) {
    final docRef = doc(documentPath);
    return docRef.withConverter(
      fromFirestore: (snapshot, _) {
        final data = snapshot.data()!;
        data['id'] = snapshot.id;
        return fromJson(data);
      },
      toFirestore: (value, _) => toJson(value),
    );
  }
}

extension PostFirestoreExtension on FirebaseFirestore {
  CollectionReference<Post> postsCollection(PostDataSource postDataSource) {
    return collectionWithConverter(
      collectionPath: RemotePostDataSource.postsCollectionPath,
      fromJson: (json) => Post.fromJson(json),
      toJson: (post) => post.toJson(),
    );
  }

  DocumentReference<Post> postDocument({required String documentPath}) {
    return documentWithConverter(
      documentPath: documentPath,
      fromJson: (json) => Post.fromJson(json),
      toJson: (post) => post.toJson(),
    );
  }
}

extension AuthFirestoreExtension on FirebaseFirestore {
  CollectionReference<AppUser> appUsersCollection(
    AuthDataSource appUserDataSource,
  ) {
    return collectionWithConverter(
      collectionPath: RemoteAuthDataSource.appUsersCollectionPath,
      fromJson: (json) => AppUser.fromJson(json),
      toJson: (appUser) => appUser.toJson(),
    );
  }

  DocumentReference<AppUser> appUserDocument({required String documentPath}) {
    return documentWithConverter(
      documentPath: documentPath,
      fromJson: (json) => AppUser.fromJson(json),
      toJson: (appUser) => appUser.toJson(),
    );
  }
}
