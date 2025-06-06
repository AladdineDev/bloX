import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TweetPostImageViewerScreen extends StatelessWidget {
  const TweetPostImageViewerScreen({super.key, required this.mediaPath});

  final String mediaPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.close),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.file(
            File(mediaPath),
            fit: BoxFit.contain,
            width: double.maxFinite,
            height: double.maxFinite,
          ),
        ),
      ),
    );
  }
}
