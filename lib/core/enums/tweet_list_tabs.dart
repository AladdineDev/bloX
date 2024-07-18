import 'package:blox/features/tweet/widgets/tweet_list_tab_following.dart';
import 'package:blox/features/tweet/widgets/tweet_list_tab_for_you.dart';
import 'package:flutter/material.dart';

enum TweetListTabs {
  forYou(
    title: Text('For you'),
    body: TweetListTabForYou(),
  ),
  following(
    title: Text('Following'),
    body: TweetListTabFollowing(),
  );

  const TweetListTabs({
    required this.title,
    required this.body,
  });
  final Widget title;
  final Widget body;
}
