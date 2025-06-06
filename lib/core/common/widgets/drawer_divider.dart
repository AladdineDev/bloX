import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class DrawerDivider extends StatelessWidget {
  const DrawerDivider({
    super.key,
    required this.padding,
  });

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.theme.listTileTheme.contentPadding ?? padding,
      child: const Column(
        children: [
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
