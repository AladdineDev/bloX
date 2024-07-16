import 'dart:io';

import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/core/extensions/duration_extension.dart';
import 'package:blox/features/tweet/widgets/tweet_post_media_delete_button.dart';
import 'package:blox/features/tweet/widgets/tweet_video_play_icon.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TweetPostVideo extends StatefulWidget {
  const TweetPostVideo({
    super.key,
    required this.mediaPath,
    required this.onTap,
    required this.onDelete,
  });

  final String mediaPath;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  State<TweetPostVideo> createState() => _TweetPostVideoState();
}

class _TweetPostVideoState extends State<TweetPostVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    final mediaPath = widget.mediaPath;
    super.initState();
    _controller = VideoPlayerController.file(File(mediaPath))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: widget.onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _controller.value.isInitialized
                ? FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: TweetPostMediaDeleteButton(
              onPressed: widget.onDelete,
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                _controller.value.duration.formatted,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Center(
            child: TweetVideoPlayIcon(),
          )
        ],
      ),
    );
  }
}
