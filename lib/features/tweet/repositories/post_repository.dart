import 'package:blox/core/exceptions/app_exception.dart';
import 'package:blox/features/tweet/data_sources/post_data_source.dart';
import 'package:blox/features/tweet/models/post.dart';

class PostRepository {
  PostRepository({required this.remoteDataSource});

  final PostDataSource remoteDataSource;

  Future<void> createPost({required Post post}) async {
    try {
      await remoteDataSource.createPost(post: post);
    } catch (e) {
      throw const CreatePostException();
    }
  }

  Stream<List<Post>> getPosts({
    int limit = 20,
    List<String>? followingIds,
    PostId? parentPostId,
  }) {
    try {
      return remoteDataSource.getPosts(
        limit: limit,
        followingIds: followingIds,
        parentPostId: parentPostId,
      );
    } catch (e) {
      throw const FetchPostListException();
    }
  }

  Stream<Post?> getPost({required PostId postId}) {
    try {
      return remoteDataSource.getPost(postId: postId);
    } catch (e) {
      throw const FetchPostException();
    }
  }

  Stream<List<Post>> getUserPosts({int limit = 20}) {
    try {
      return remoteDataSource.getUserPosts(limit: limit);
    } catch (e) {
      throw const FetchPostListException();
    }
  }

  Future<void> updatePost({required Post post}) async {
    try {
      await remoteDataSource.updatePost(post: post);
    } catch (e) {
      throw const UpdatePostException();
    }
  }

  Future<void> deletePost({required PostId postId}) async {
    try {
      await remoteDataSource.deletePost(postId: postId);
    } catch (e) {
      throw const DeletePostException();
    }
  }
}