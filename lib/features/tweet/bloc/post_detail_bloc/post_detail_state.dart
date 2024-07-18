part of 'post_detail_bloc.dart';

enum PostDetailStatus {
  initial,
  progressFetchingPost,
  successFetchingPost,
  errorFetchingPost,
  progressFetchingReplyPostList,
  successFetchingReplyPostList,
  errorFetchingReplyPostList,
}

class PostDetailState extends Equatable {
  const PostDetailState({
    this.status = PostDetailStatus.initial,
    this.post,
    this.replyPosts = const [],
    this.error = const UnknownException(),
  });

  final PostDetailStatus status;
  final Post? post;
  final List<Post> replyPosts;
  final AppException error;

  PostDetailState copyWith({
    PostDetailStatus? status,
    Post? post,
    List<Post>? replyPosts,
    AppException? error,
  }) {
    return PostDetailState(
      status: status ?? this.status,
      post: post ?? this.post,
      replyPosts: replyPosts ?? this.replyPosts,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        post,
        replyPosts,
        error,
      ];
}
