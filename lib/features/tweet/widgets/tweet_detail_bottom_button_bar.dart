import 'package:blox/features/tweet/widgets/tweet_bottom_button.dart';
import 'package:flutter/material.dart';

class TweetDetailBottomButtonsBar extends StatelessWidget {
  const TweetDetailBottomButtonsBar({
    super.key,
    this.buttonAlignment = MainAxisAlignment.center,
    this.buttonSize = 20,
  });

  final MainAxisAlignment buttonAlignment;
  final double buttonSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: TweetBottomButton(
              size: buttonSize,
              mainAxisAlignment: buttonAlignment,
              onTap: () {
                //TODO: implement this function
              },
              icon: Icons.chat_bubble_outline_rounded,
            ),
          ),
          Expanded(
            child: TweetBottomButton(
              size: buttonSize,
              mainAxisAlignment: buttonAlignment,
              onTap: () {
                //TODO: implement this function
              },
              icon: Icons.repeat_rounded,
            ),
          ),
          Expanded(
            child: TweetBottomButton(
              size: buttonSize,
              mainAxisAlignment: buttonAlignment,
              onTap: () {
                //TODO: implement this function
              },
              icon: Icons.favorite_outline_rounded,
            ),
          ),
          Expanded(
            child: TweetBottomButton(
              size: buttonSize,
              mainAxisAlignment: buttonAlignment,
              onTap: () {
                //TODO: implement this function
              },
              icon: Icons.bookmark_outline_rounded,
            ),
          ),
          Expanded(
            child: TweetBottomButton(
              size: buttonSize,
              mainAxisAlignment: buttonAlignment,
              onTap: () {
                //TODO: implement this function
              },
              icon: Icons.share_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
