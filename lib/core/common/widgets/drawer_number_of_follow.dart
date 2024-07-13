import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class DrawerNumberOfFollowText extends StatelessWidget {
  const DrawerNumberOfFollowText({
    super.key,
    required this.number,
    required this.text,
    this.onTap,
  });

  final int number;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: onTap,
      child: Text.rich(
        TextSpan(children: [
          TextSpan(
            text: "$number ",
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: text,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
        ]),
      ),
    );
  }
}
