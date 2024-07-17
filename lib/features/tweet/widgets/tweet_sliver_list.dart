import 'package:blox/core/common/widgets/retry.dart';
import 'package:blox/core/common/widgets/spinner.dart';
import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/core/router/router.dart';
import 'package:blox/features/tweet/bloc/post_bloc/post_bloc.dart';
import 'package:blox/features/tweet/widgets/tweet_item.dart';
import 'package:blox/features/tweet/widgets/tweet_list_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TweetListView extends StatefulWidget {
  const TweetListView({super.key, required this.tab});

  final TweetListTabs tab;

  @override
  State<TweetListView> createState() => _TweetListViewState();
}

class TweetListTab {}

class _TweetListViewState extends State<TweetListView> {
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
    final posts = context.postBloc.state.posts;
    if (_isBottom && posts.length >= _fetchLimit) {
      _fetchLimit += _pageSize;
      context.postBloc.add(GetAllPosts(limit: _fetchLimit));
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
                  return switch (state.status) {
                    PostStatus.progressFetchingPostList =>
                      const SliverToBoxAdapter(
                        child: Center(
                          child: Spinner.medium(),
                        ),
                      ),
                    PostStatus.errorFetchingPostList => SliverToBoxAdapter(
                        child: Retry(
                          errorMessage: state.error.message,
                          onPressed: () => context.postBloc.add(GetAllPosts()),
                        ),
                      ),
                    _ => SliverList.separated(
                        itemCount: state.posts.length < _fetchLimit
                            ? state.posts.length
                            : state.posts.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= state.posts.length) {
                            return const SizedBox(
                              height: 60,
                              width: double.maxFinite,
                              child: Spinner.medium(),
                            );
                          }
                          return TweetItem(
                            onTap: () {
                              TweetDetailScreenRoute().push(context);
                              //TODO: implement this method
                            },
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
}
