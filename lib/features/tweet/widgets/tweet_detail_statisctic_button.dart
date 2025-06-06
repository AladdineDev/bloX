import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class TweetDetailStatiscticButton extends StatelessWidget {
  const TweetDetailStatiscticButton({
    super.key,
    required this.title,
    required this.number,
    this.onTap,
  });

  final String title;
  final int number;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: '$number ',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: title,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
