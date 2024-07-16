import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class TweetVideoPlayIcon extends StatelessWidget {
  const TweetVideoPlayIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: context.colorScheme.secondary,
          width: 3,
        ),
        color: context.colorScheme.primary,
      ),
      child: Icon(
        Icons.play_arrow_rounded,
        color: context.colorScheme.secondary,
        size: 30,
      ),
    );
  }
}
