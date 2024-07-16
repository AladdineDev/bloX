import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class DotSeparator extends StatelessWidget {
  const DotSeparator({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 2),
  });

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        '·',
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.onSurface,
        ),
      ),
    );
  }
}
