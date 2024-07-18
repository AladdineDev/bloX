import 'package:blox/features/tweet/repositories/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blox/core/exceptions/app_exception.dart';
import 'package:blox/features/tweet/models/post.dart';
import 'package:equatable/equatable.dart';

part 'post_detail_event.dart';
part 'post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final PostRepository postRepository;

  PostDetailBloc({required this.postRepository})
      : super(const PostDetailState()) {
    on<GetOnePostDetail>(_onGetOnePostDetail);
    on<GetReplyPostsDetail>(_onGetReplyPostsDetail);
  }

  Future<void> _onGetOnePostDetail(
      GetOnePostDetail event, Emitter<PostDetailState> emit) async {
    emit(state.copyWith(status: PostDetailStatus.progressFetchingPost));
    try {
      final postStream = postRepository.getPost(postId: event.postId);
      await emit.forEach(postStream, onData: (post) {
        return state.copyWith(
          status: PostDetailStatus.successFetchingPost,
          post: post,
        );
      });
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: PostDetailStatus.errorFetchingPost,
          error: e,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostDetailStatus.errorFetchingPost,
          error: const UnknownException(),
        ),
      );
    }
  }

  Future<void> _onGetReplyPostsDetail(
      GetReplyPostsDetail event, Emitter<PostDetailState> emit) async {
    try {
      final repliesStream = postRepository.getPosts(
        limit: event.limit,
        parentPostId: event.parentPostId,
      );
      await emit.forEach(repliesStream, onData: (replies) {
        return state.copyWith(
          status: PostDetailStatus.successFetchingReplyPostList,
          replyPosts: replies,
        );
      });
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: PostDetailStatus.errorFetchingReplyPostList,
          error: e,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostDetailStatus.errorFetchingReplyPostList,
          error: const UnknownException(),
        ),
      );
    }
  }
}
