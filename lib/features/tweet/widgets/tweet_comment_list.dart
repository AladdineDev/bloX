import 'package:blox/core/common/widgets/retry.dart';
import 'package:blox/core/common/widgets/spinner.dart';
import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/core/router/router.dart';
import 'package:blox/features/tweet/bloc/post_bloc/post_bloc.dart';
import 'package:blox/features/tweet/bloc/post_detail_bloc/post_detail_bloc.dart';
import 'package:blox/features/tweet/models/post.dart';
import 'package:blox/features/tweet/widgets/tweet_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TweetCommentList extends StatefulWidget {
  const TweetCommentList({
    super.key,
    this.postId,
  });

  final PostId? postId;

  @override
  State<TweetCommentList> createState() => _TweetListState();
}

class _TweetListState extends State<TweetCommentList> {
  final _scrollController = ScrollController();
  static const _pageSize = 20;
  int _fetchLimit = _pageSize;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final posts = context.postDetailBloc.state.replyPosts;
    final parentPostId = widget.postId;
    if (parentPostId == null) {
      return; //TODO: display error
    }
    if (_isBottom && posts.length >= _fetchLimit) {
      _fetchLimit += _pageSize;
    }
    return context.postBloc.add(
      GetReplyPosts(limit: _fetchLimit, parentPostId: parentPostId),
    );
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostDetailBloc, PostDetailState>(
      builder: (context, state) {
        final posts = state.replyPosts;
        return switch (state.status) {
          PostDetailStatus.progressFetchingReplyPostList =>
            const SliverToBoxAdapter(
              child: Center(
                child: Spinner.medium(),
              ),
            ),
          PostDetailStatus.errorFetchingReplyPostList => SliverToBoxAdapter(
              child: Retry(
                errorMessage: state.error.message,
                onPressed: () => context.postBloc.add(
                  GetForYouPosts(),
                ),
              ),
            ),
          _ => SliverList.separated(
              itemCount:
                  posts.length < _fetchLimit ? posts.length : posts.length + 1,
              itemBuilder: (context, index) {
                if (index >= posts.length) {
                  return const SizedBox(
                    height: 60,
                    width: double.maxFinite,
                    child: Spinner.medium(),
                  );
                }
                return TweetItem(
                  post: posts[index],
                  onTap: () => _onTweetItemTap(
                    context,
                    post: posts[index],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
        };
      },
    );
  }

  void _onTweetItemTap(BuildContext context, {required Post post}) {
    final postId = post.id;
    if (postId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Post unavailable",
          ),
        ),
      );
      return;
    }
    TweetDetailScreenRoute(postId: postId).push(context);
    //TODO: implement this method
  }
}
