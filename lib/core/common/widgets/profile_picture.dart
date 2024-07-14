import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture.small({
    super.key,
    required this.onPressed,
    required this.image,
    this.dimension = 28,
    this.padding = const EdgeInsets.all(12),
  });

  const ProfilePicture.medium({
    super.key,
    required this.onPressed,
    required this.image,
    this.dimension = 40,
    this.padding = const EdgeInsets.all(0),
  });

  final VoidCallback onPressed;
  final ImageProvider image;
  final double dimension;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: onPressed,
        child: Padding(
          padding: padding,
          child: ClipOval(
            child: Image(
              image: image,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.account_circle_outlined,
                  size: dimension,
                );
              },
              fit: BoxFit.cover,
              width: dimension,
              height: dimension,
            ),
          ),
        ),
      ),
    );
  }
}
