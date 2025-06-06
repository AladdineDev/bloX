import 'dart:io';

import 'package:blox/features/tweet/widgets/tweet_post_media_delete_button.dart';
import 'package:flutter/material.dart';

class TweetPostImage extends StatelessWidget {
  const TweetPostImage({
    super.key,
    required this.mediaPath,
    required this.onTap,
    required this.onDelete,
  });

  final String mediaPath;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              File(mediaPath),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: TweetPostMediaDeleteButton(
              onPressed: onDelete,
            ),
          ),
        ],
      ),
    );
  }
}
