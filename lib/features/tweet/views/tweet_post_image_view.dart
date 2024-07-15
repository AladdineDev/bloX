import 'dart:typed_data';

import 'package:flutter/material.dart';

class TweetPostImageViewerScreen extends StatelessWidget {
  const TweetPostImageViewerScreen({super.key, required this.imageBytes});

  final List<int>? imageBytes;

  @override
  Widget build(BuildContext context) {
    final imageBytes = this.imageBytes;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: InteractiveViewer(
          child: imageBytes == null
              ? const SizedBox.shrink()
              : Image.memory(
                  Uint8List.fromList(imageBytes),
                  fit: BoxFit.contain,
                  width: double.maxFinite,
                  height: double.maxFinite,
                ),
        ),
      ),
    );
  }
}
