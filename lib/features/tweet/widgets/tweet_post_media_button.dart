import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TweetPostMediaButton extends StatefulWidget {
  const TweetPostMediaButton({super.key});

  @override
  State<TweetPostMediaButton> createState() => _TweetPostMediaButtonState();
}

class _TweetPostMediaButtonState extends State<TweetPostMediaButton> {
  final ImagePicker picker = ImagePicker();
  final List<XFile> images = [];

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: context.colorScheme.primary,
      onPressed: () async {
        await picker.pickImage(source: ImageSource.gallery);
      },
      icon: const Icon(Icons.image_outlined),
    );
  }
}
