import 'package:flutter/material.dart';

class TweetPostMediaDeleteButton extends StatelessWidget {
  const TweetPostMediaDeleteButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.close_rounded),
      ),
      color: Colors.white,
    );
  }
}
