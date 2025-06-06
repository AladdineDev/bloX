part of 'post_bloc.dart';

enum PostStatus {
  initial,
  progressCreatingPost,
  successCreatingPost,
  errorCreatingPost,
  progressFetchingForYouPostList,
  successFetchingForYouPostList,
  errorFetchingForYouPostList,
  progressFetchingFollowingPostList,
  successFetchingFollowingPostList,
  errorFetchingFollowingPostList,
  progressUpdatingPost,
  successUpdatingPost,
  errorUpdatingPost,
  progressDeletingPost,
  successDeletingPost,
  errorDeletingPost,
}

class PostState extends Equatable {
  const PostState({
    this.status = PostStatus.initial,
    this.post,
    this.forYouPosts = const [],
    this.followingPosts = const [],
    this.error = const UnknownException(),
    this.forYouHasReachedMax = false,
    this.followingHasReachedMax = false,
    this.replyHasReachedMax = false,
  });

  final PostStatus status;
  final Post? post;
  final List<Post> forYouPosts;
  final List<Post> followingPosts;
  final AppException error;
  final bool forYouHasReachedMax;
  final bool followingHasReachedMax;
  final bool replyHasReachedMax;

  PostState copyWith({
    PostStatus? status,
    Post? post,
    List<Post>? forYouPosts,
    List<Post>? followingPosts,
    AppException? error,
    bool? forYouHasReachedMax,
    bool? followingHasReachedMax,
    bool? replyHasReachedMax,
  }) {
    return PostState(
      status: status ?? this.status,
      error: error ?? this.error,
      post: post ?? this.post,
      forYouPosts: forYouPosts ?? this.forYouPosts,
      followingPosts: followingPosts ?? this.followingPosts,
      forYouHasReachedMax: forYouHasReachedMax ?? this.forYouHasReachedMax,
      followingHasReachedMax:
          followingHasReachedMax ?? this.followingHasReachedMax,
      replyHasReachedMax: replyHasReachedMax ?? this.replyHasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        status,
        post,
        forYouPosts,
        followingPosts,
        error,
        forYouHasReachedMax,
        followingHasReachedMax,
        replyHasReachedMax,
      ];
}
