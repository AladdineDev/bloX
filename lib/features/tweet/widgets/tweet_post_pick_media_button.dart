import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/features/tweet/bloc/tweet_media_bloc/tweet_media_bloc.dart';
import 'package:blox/features/tweet/views/tweet_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class TweetPostPickMediaButton extends StatefulWidget {
  const TweetPostPickMediaButton({super.key});

  @override
  State<TweetPostPickMediaButton> createState() =>
      _TweetPostPickMediaButtonState();
}

class _TweetPostPickMediaButtonState extends State<TweetPostPickMediaButton> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TweetMediaBloc, TweetMediaState>(
      builder: (context, state) {
        final mediaList = state.mediaList;
        final mediaLimit = TweetPostScreen.maxMediaPicked - mediaList.length;
        final hasExceededMaxMedia =
            mediaList.length > TweetPostScreen.maxMediaPicked;
        return IconButton(
          tooltip: "Pick media",
          icon: const Icon(Icons.image_outlined),
          color: context.colorScheme.primary,
          onPressed: () async {
            if (hasExceededMaxMedia) return _showMaxMediaSnackBar(context);
            final List<XFile> pickedMedia;
            if (mediaLimit < 2) {
              pickedMedia = [await picker.pickMedia()].nonNulls.toList();
            } else {
              pickedMedia = await picker.pickMultipleMedia(
                limit: mediaLimit,
              );
            }
            if (mediaList.length + pickedMedia.length >
                TweetPostScreen.maxMediaPicked) {
              if (!context.mounted) return;
              return _showMaxMediaSnackBar(context);
            }
            if (!context.mounted) return;
            context.tweetMediaBloc.add(AddTweetMedia(pickedMedia));
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
