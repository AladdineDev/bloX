import 'package:blox/features/tweet/models/post.dart';

abstract class PostDataSource {
  Future<void> createPost({required Post post});
  Stream<List<Post>> getPosts({required int limit, List<String>? followingIds, PostId? parentPostId});
  Stream<Post?> getPost({required PostId postId});
  Future<void> updatePost({required Post post});
  Future<void> deletePost({required PostId postId});
  Stream<List<Post>> getUserPosts({required int limit}); // Add this method
}