import 'package:flutter/material.dart';

class TweetCreationScreen extends StatelessWidget {
  const TweetCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.close),
        ),
        actions: [
          FilledButton(
            onPressed: () {},
            child: const Text('Post'),
          ),
        ],
      ),
      body: const Center(
        child: Text("TweetCreationScreen"),
      ),
    );
  }
}
