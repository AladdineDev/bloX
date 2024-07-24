import 'package:blox/features/tweet/widgets/tweet_post_length_indicator.dart';
import 'package:blox/features/tweet/widgets/tweet_post_pick_media_button.dart';
import 'package:blox/features/tweet/widgets/tweet_post_take_picture_button.dart';
import 'package:blox/features/tweet/widgets/tweet_post_take_video_button.dart';
import 'package:flutter/material.dart';

class TweetPostBottomRow extends StatelessWidget {
  const TweetPostBottomRow({
    super.key,
    required this.postController,
  });

  final TextEditingController postController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            TweetPostPickMediaButton(),
            TweetPostTakePictureButton(),
            TweetPostTakeVideoButton(),
          ],
        ),
        TweetPostLengthIndicator(
          postController: postController,
        ),
      ],
    );
  }
}
