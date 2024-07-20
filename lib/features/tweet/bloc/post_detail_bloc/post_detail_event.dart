part of 'post_detail_bloc.dart';

sealed class PostDetailEvent {}

final class GetOnePostDetail extends PostDetailEvent {
  GetOnePostDetail(this.postId);

  final String postId;
}

final class GetReplyPostsDetail extends PostDetailEvent {
  GetReplyPostsDetail({
    this.limit = 10,
    required this.parentPostId,
  });

  final int limit;
  final String parentPostId;
}
