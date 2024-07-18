import 'package:blox/core/common/widgets/retry.dart';
import 'package:blox/core/common/widgets/spinner.dart';
import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/core/router/router.dart';
import 'package:blox/features/tweet/bloc/post_bloc/post_bloc.dart';
import 'package:blox/features/tweet/models/post.dart';
import 'package:blox/features/tweet/widgets/tweet_item.dart';
import 'package:blox/core/enums/tweet_list_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TweetList extends StatefulWidget {
  const TweetList({super.key, required this.tab});

  final TweetListTabs tab;

  @override
  State<TweetList> createState() => _TweetListState();
}

class TweetListTab {}

class _TweetListState extends State<TweetList> {
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
    switch (widget.tab) {
      case TweetListTabs.forYou:
        final posts = context.postBloc.state.forYouPosts;
        if (_isBottom && posts.length >= _fetchLimit) {
          _fetchLimit += _pageSize;
        }
        return context.postBloc.add(
          GetForYouPosts(limit: _fetchLimit),
        );
      case TweetListTabs.following:
        final posts = context.postBloc.state.followingPosts;
        if (_isBottom && posts.length >= _fetchLimit) {
          _fetchLimit += _pageSize;
        }
        return context.postBloc.add(
          GetFollowingPosts(limit: _fetchLimit),
        );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        return Scrollbar(
          controller: _scrollController,
          child: CustomScrollView(
            key: PageStorageKey<String>(widget.tab.name),
            physics: const ClampingScrollPhysics(),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
              ),
              BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  final List<Post> posts;
                  switch (widget.tab) {
                    case TweetListTabs.forYou:
                      posts = state.forYouPosts;
                      break;
                    case TweetListTabs.following:
                      posts = state.followingPosts;
                  }
                  return switch (state.status) {
                    PostStatus.progressFetchingForYouPostList =>
                      const SliverToBoxAdapter(
                        child: Center(
                          child: Spinner.medium(),
                        ),
                      ),
                    PostStatus.errorFetchingForYouPostList =>
                      SliverToBoxAdapter(
                        child: Retry(
                          errorMessage: state.error.message,
                          onPressed: () => context.postBloc.add(
                            GetForYouPosts(),
                          ),
                        ),
                      ),
                    _ => SliverList.separated(
                        itemCount: posts.length < _fetchLimit
                            ? posts.length
                            : posts.length + 1,
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
              ),
            ],
          ),
        );
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
    context.postBloc.add(GetOnePost(postId));
    TweetDetailScreenRoute().push(context);
    //TODO: implement this method
  }
}
