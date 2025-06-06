import 'dart:io';

import 'package:blox/features/tweet/widgets/tweet_video_play_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

class TweetPostVideoViewerScreen extends StatefulWidget {
  const TweetPostVideoViewerScreen({super.key, required this.mediaPath});

  final String mediaPath;

  @override
  State<TweetPostVideoViewerScreen> createState() =>
      _TweetPostVideoViewerScreenState();
}

class _TweetPostVideoViewerScreenState
    extends State<TweetPostVideoViewerScreen> {
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.close),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Container(
          decoration: const BoxDecoration(),
          child: Stack(
            children: [
              Center(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : const SizedBox.shrink(),
              ),
              Center(
                child: _controller.value.isPlaying
                    ? const SizedBox.shrink()
                    : const TweetVideoPlayIcon(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
