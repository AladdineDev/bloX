import 'dart:typed_data';

import 'package:flutter/material.dart';

class TweetPostImage extends StatelessWidget {
  const TweetPostImage({
    super.key,
    required this.mediaBytes,
    required this.onTap,
    required this.onDelete,
  });

  final Uint8List mediaBytes;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.memory(mediaBytes),
          ),
          Positioned(
            top: 8,
            right: 12,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: InkWell(
                onTap: _onDeleteTap,
                child: const Icon(
                  Icons.close_rounded,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onDeleteTap() => onDelete();
  _onTap() => onTap();
}
