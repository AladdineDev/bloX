part of 'post_bloc.dart';

sealed class PostEvent {}

final class GetOnePost extends PostEvent {
  GetOnePost(this.postId);

  final PostId postId;
}

final class GetForYouPosts extends PostEvent {
  GetForYouPosts({this.limit = 20});

  final int limit;
}

final class CreatePost extends PostEvent {
  CreatePost(this.post);

  final Post post;
}

final class UpdatePost extends PostEvent {
  UpdatePost(this.post);

  final Post post;
}

class DeletePost extends PostEvent {
  DeletePost(this.postId);

  final PostId postId;
}

final class GetFollowingPosts extends PostEvent {
  GetFollowingPosts({
    this.limit = 20,
    this.followingIds = const [],
  });

  final int limit;
  final List<AppUserId> followingIds;
}

final class GetReplyPosts extends PostEvent {
  GetReplyPosts({
    this.limit = 10,
    required this.parentPostId,
  });

  final int limit;
  final PostId parentPostId;
}
