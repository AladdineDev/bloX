import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class TweetBottomButton extends StatelessWidget {
  const TweetBottomButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.number,
  });

  final VoidCallback onTap;
  final IconData icon;
  final int? number;

  @override
  Widget build(BuildContext context) {
    final number = this.number;
    final color = context.colorScheme.onSurface;
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 2),
          if (number != null)
            Text(
              '$number',
              style: context.textTheme.bodySmall?.copyWith(
                color: color,
              ),
            ),
        ],
      ),
    );
  }
}
