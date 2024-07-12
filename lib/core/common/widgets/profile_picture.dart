import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.onPressed,
    required this.image,
    this.dimension = 28,
  });

  final VoidCallback onPressed;
  final ImageProvider image;
  final double dimension;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: ClipOval(
        child: Image(
          image: image,
          fit: BoxFit.cover,
          width: dimension,
          height: dimension,
        ),
      ),
    );
  }
}
