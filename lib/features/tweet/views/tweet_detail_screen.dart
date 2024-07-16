import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/features/tweet/widgets/tweet.dart';
import 'package:blox/features/tweet/widgets/tweet_detail.dart';
import 'package:flutter/material.dart';

class TweetDetailScreen extends StatelessWidget {
  const TweetDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Post'),
        bottom: const PreferredSize(
          preferredSize: Size.zero,
          child: Divider(),
        ),
      ),
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
            SliverList.separated(
              itemCount: 50,
              itemBuilder: (context, index) {
                return Tweet(
                  onTap: () {
                    //TODO: implement this method
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ],
        ),
      ),
    );
  }
}
