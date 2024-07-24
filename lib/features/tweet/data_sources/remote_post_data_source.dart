import 'package:blox/core/extensions/firebase_firestore_extension.dart';
import 'package:blox/features/tweet/data_sources/post_data_source.dart';
import 'package:blox/features/tweet/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemotePostDataSource extends PostDataSource {
  RemotePostDataSource();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const postsCollectionPath = 'posts';
  static String postPath({required PostId postId}) {
    return '$postsCollectionPath/$postId';
  }

  @override
  Future<void> createPost({required Post post}) async {
    final postsCollection = _firestore.postsCollection(this);
    await postsCollection.add(
      post.copyWith(
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  Stream<List<Post>> getPosts({
    required int limit,
    List<String>? followingIds,
    PostId? parentPostId,
  }) {
    final postsCollection = _firestore.postsCollection(this);
    Query<Post> postsQuery = postsCollection;
    if (followingIds != null) {
      postsQuery = postsQuery.where('userId', whereIn: followingIds);
    }
    if (parentPostId != null) {
      postsQuery = postsQuery.where(
        'parentPostId',
        isEqualTo: parentPostId,
      );
    }
    postsQuery = postsQuery.limit(limit);
    return postsQuery.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Stream<Post?> getPost({required PostId postId}) {
    final postDoc = _firestore.postDocument(
      documentPath: postPath(postId: postId),
    );
    return postDoc.snapshots().map((snapshot) => snapshot.data());
  }

  @override
  Future<void> updatePost({required Post post}) async {
    final postDoc = _firestore.postDocument(
      documentPath: postPath(postId: post.id!),
    );
    await postDoc.update(
      post.copyWith(timestamp: DateTime.now()).toJson(),
    );
  }

  @override
  Future<void> deletePost({required PostId postId}) async {
    final postDoc = _firestore.postDocument(
      documentPath: postPath(postId: postId),
    );
    await postDoc.delete();
  }
}
