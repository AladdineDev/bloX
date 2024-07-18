import 'package:blox/features/tweet/widgets/tweet_list_tab_following.dart';
import 'package:blox/features/tweet/widgets/tweet_list_tab_for_you.dart';
import 'package:flutter/material.dart';

enum TweetListType {
  forYou(
    title: Text('For you'),
  ),
  following(
    title: Text('Following'),
  ),
  reply(
    title: Text('Reply'),
  );

  const TweetListType({
    required this.title,
  });
  final Widget title;
}
