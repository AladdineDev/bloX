import 'package:blox/features/tweet/models/post.dart';
import 'package:blox/features/tweet/widgets/tweet_bottom_button.dart';
import 'package:flutter/material.dart';

class TweetBottomButtonsBar extends StatelessWidget {
  const TweetBottomButtonsBar({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    final postCommentsNumber = post.comments?.length ?? 0;
    final postRepostsNumber = post.reposts?.length ?? 0;
    final postLikesNumber = post.likes?.length ?? 0;
    final postViewsNumber = post.views?.length ?? 0;
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TweetBottomButton(
                  onTap: () {
                    //TODO: implement this function
                  },
                  icon: Icons.chat_bubble_outline_rounded,
                  number: postCommentsNumber,
                ),
              ),
              Expanded(
                child: TweetBottomButton(
                  onTap: () {
                    //TODO: implement this function
                  },
                  icon: Icons.repeat_rounded,
                  number: postRepostsNumber,
                ),
              ),
              Expanded(
                child: TweetBottomButton(
                  onTap: () {
                    //TODO: implement this function
                  },
                  icon: Icons.favorite_outline_rounded,
                  number: postLikesNumber,
                ),
              ),
              Expanded(
                child: TweetBottomButton(
                  onTap: () {
                    //TODO: implement this function
                  },
                  icon: Icons.bar_chart_outlined,
                  number: postViewsNumber,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: TweetBottomButton(
                  onTap: () {
                    //TODO: implement this function
                  },
                  icon: Icons.bookmark_outline_rounded,
                ),
              ),
              Expanded(
                child: TweetBottomButton(
                  onTap: () {
                    //TODO: implement this function
                  },
                  icon: Icons.share_outlined,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
