import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.onPressed,
    required this.image,
    this.size = const Size.square(48),
  });

  final VoidCallback onPressed;
  final ImageProvider image;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const ClipOval(
        child: Image(
          image: NetworkImage(
            "https://abs.twimg.com/sticky/default_profile_images/default_profile.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
      style: IconButton.styleFrom(
        padding: const EdgeInsets.all(6),
        fixedSize: size,
      ),
    );
  }
}
