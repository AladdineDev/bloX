import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/features/tweet/bloc/tweet_media_bloc/tweet_media_bloc.dart';
import 'package:blox/features/tweet/views/tweet_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class TweetPostTakeVideoButton extends StatefulWidget {
  const TweetPostTakeVideoButton({super.key});

  @override
  State<TweetPostTakeVideoButton> createState() =>
      _TweetPostTakeVideoButtonState();
}

class _TweetPostTakeVideoButtonState extends State<TweetPostTakeVideoButton> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TweetMediaBloc, TweetMediaState>(
      builder: (context, state) {
        final mediaList = state.mediaList;
        final hasExceededMaxMedia =
            mediaList.length > TweetPostScreen.maxMediaPicked;
        return IconButton(
          tooltip: "Take video",
          icon: const Icon(Icons.video_camera_back_outlined),
          color: context.colorScheme.primary,
          onPressed: () async {
            if (hasExceededMaxMedia) return _showMaxMediaSnackBar(context);
            final pickedMedia =
                await picker.pickVideo(source: ImageSource.camera);
            if (pickedMedia == null) return;
            if (!context.mounted) return;
            context.tweetMediaBloc.add(AddTweetMedia([pickedMedia]));
          },
        );
      },
    );
  }

  void _showMaxMediaSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("4 media limit reached"),
      ),
    );
  }
}
