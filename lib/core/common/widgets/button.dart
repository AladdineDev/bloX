import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Widget leading;
  final Widget trailing;
  final void Function() onPressed;

  const Button(
    this.text, {
    super.key,
    this.leading = const SizedBox(width: 0),
    this.trailing = const SizedBox(width: 0),
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            leading,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(text),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
