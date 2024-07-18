import 'package:blox/core/enums/tweet_list_tabs.dart';
import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/features/tweet/bloc/tweet_media_bloc/tweet_media_bloc.dart';
import 'package:blox/features/tweet/views/tweet_detail_reply_bottom_sheet.dart';
import 'package:blox/features/tweet/widgets/tweet_detail.dart';
import 'package:blox/features/tweet/widgets/tweet_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TweetDetailScreen extends StatefulWidget {
  const TweetDetailScreen({super.key});

  @override
  State<TweetDetailScreen> createState() => _TweetDetailScreenState();
}

class _TweetDetailScreenState extends State<TweetDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TweetMediaBloc(),
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
                const TweetList(tweetListType: TweetListType.reply),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
