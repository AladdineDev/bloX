import 'package:blox/features/tweet/widgets/tweet_bottom_button.dart';
import 'package:flutter/material.dart';

class TweetBottomButtonsBar extends StatelessWidget {
  const TweetBottomButtonsBar({super.key});

  @override
  Widget build(BuildContext context) {
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
                  number: 18,
                ),
              ),
              Expanded(
                child: TweetBottomButton(
                  onTap: () {
                    //TODO: implement this function
                  },
                  icon: Icons.repeat_rounded,
                  number: 5,
                ),
              ),
              Expanded(
                child: TweetBottomButton(
                  onTap: () {
                    //TODO: implement this function
                  },
                  icon: Icons.favorite_outline_rounded,
                  number: 27,
                ),
              ),
              Expanded(
                child: TweetBottomButton(
                  onTap: () {
                    //TODO: implement this function
                  },
                  icon: Icons.bar_chart_outlined,
                  number: 130,
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
