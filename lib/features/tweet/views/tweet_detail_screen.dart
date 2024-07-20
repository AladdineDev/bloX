import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/features/tweet/bloc/post_detail_bloc/post_detail_bloc.dart';
import 'package:blox/features/tweet/bloc/tweet_media_bloc/tweet_media_bloc.dart';
import 'package:blox/features/tweet/models/post.dart';
import 'package:blox/features/tweet/views/tweet_detail_reply_bottom_sheet.dart';
import 'package:blox/features/tweet/widgets/tweet_comment_list.dart';
import 'package:blox/features/tweet/widgets/tweet_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TweetDetailScreen extends StatelessWidget {
  const TweetDetailScreen({super.key, required this.postId});

  final PostId postId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TweetMediaBloc(),
        ),
        BlocProvider(
          create: (context) =>
              PostDetailBloc(postRepository: context.postRepository)
                ..add(GetOnePostDetail(postId))
                ..add(GetReplyPostsDetail(parentPostId: postId)),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text('Post'),
            bottom: const PreferredSize(
              preferredSize: Size.zero,
              child: Divider(),
            ),
          ),
          bottomSheet: const TweetDetailReplyBottomSheet(),
          body: SafeArea(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: <Widget>[
                const SliverToBoxAdapter(
                  child: TweetDetail(),
                ),
                SliverToBoxAdapter(
                  child: Divider(
                    color: context.theme.dividerColor,
                    height: context.theme.dividerTheme.thickness,
                  ),
                ),
                TweetCommentList(
                  postId: postId,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
