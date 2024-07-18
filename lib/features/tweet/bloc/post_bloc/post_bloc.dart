import 'package:blox/core/exceptions/app_exception.dart';
import 'package:blox/features/auth/models/user.dart';
import 'package:blox/features/tweet/models/post.dart';
import 'package:blox/features/tweet/repositories/post_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.postRepository}) : super(const PostState()) {
    on<CreatePost>(_onCreatePost);
    on<GetForYouPosts>(_onGetForYouPosts);
    on<UpdatePost>(_onUpdatePost);
    on<DeletePost>(_onDeletePost);
    on<GetFollowingPosts>(_onGetFollowingPosts);
  }

  final PostRepository postRepository;

  Future<void> _onCreatePost(CreatePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.progressCreatingPost));
    try {
      final post = event.post;
      await postRepository.createPost(post: post);
      emit(
        state.copyWith(status: PostStatus.successCreatingPost),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorCreatingPost,
          error: e,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorCreatingPost,
          error: const UnknownException(),
        ),
      );
    }
  }

  Future<void> _onGetForYouPosts(
    GetForYouPosts event,
    Emitter<PostState> emit,
  ) async {
    if (state.forYouHasReachedMax) return;
    if (state.forYouPosts.length < event.limit) {
      emit(state.copyWith(forYouHasReachedMax: true));
    }
    try {
      final postsStream = postRepository.getPosts(limit: event.limit);
      return emit.forEach(postsStream, onData: (posts) {
        return state.copyWith(
          status: PostStatus.successFetchingForYouPostList,
          forYouPosts: posts,
          forYouHasReachedMax: false,
        );
      });
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorFetchingForYouPostList,
          error: e,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorFetchingForYouPostList,
          error: const UnknownException(),
        ),
      );
    }
  }

  Future<void> _onGetFollowingPosts(
    GetFollowingPosts event,
    Emitter<PostState> emit,
  ) async {
    if (state.followingHasReachedMax) return;
    if (state.followingPosts.length < event.limit) {
      emit(state.copyWith(followingHasReachedMax: true));
    }
    try {
      final postsStream = postRepository.getPosts(
        limit: event.limit,
        followingIds: event.followingIds,
      );
      return emit.forEach(postsStream, onData: (posts) {
        return state.copyWith(
          status: PostStatus.successFetchingFollowingPostList,
          followingPosts: posts,
          followingHasReachedMax: false,
        );
      });
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorFetchingFollowingPostList,
          error: e,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorFetchingFollowingPostList,
          error: const UnknownException(),
        ),
      );
    }
  }

  Future<void> _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.progressUpdatingPost));
    try {
      final post = event.post;
      await postRepository.updatePost(post: post);
      emit(
        state.copyWith(
          status: PostStatus.successUpdatingPost,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorUpdatingPost,
          error: e,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorUpdatingPost,
          error: const UnknownException(),
        ),
      );
    }
  }

  Future<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.progressDeletingPost));
    try {
      final postId = event.postId;
      await postRepository.deletePost(postId: postId);
      emit(
        state.copyWith(
          status: PostStatus.successDeletingPost,
          post: null,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorDeletingPost,
          error: e,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorDeletingPost,
          error: const UnknownException(),
        ),
      );
    }
  }
}
