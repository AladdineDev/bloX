import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class TweetPostTextField extends StatelessWidget {
  const TweetPostTextField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  final TextEditingController controller;
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: true,
      onChanged: onChanged,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration.collapsed(
        hintText: "What's happening?",
      ),
      maxLines: null,
      style: context.textTheme.titleMedium,
    );
  }
}
