import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class TweetBottomButton extends StatelessWidget {
  const TweetBottomButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.number,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.size = 16,
  });

  final VoidCallback onTap;
  final IconData icon;
  final int? number;
  final MainAxisAlignment mainAxisAlignment;
  final double size;

  @override
  Widget build(BuildContext context) {
    final number = this.number;
    final color = context.colorScheme.onSurface;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            Icon(
              icon,
              size: size,
              color: color,
            ),
            if (number != null) ...[
              const SizedBox(width: 2),
              Text(
                '$number',
                style: context.textTheme.bodySmall?.copyWith(
                  color: color,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
