import 'package:blox/app.dart';
import 'package:flutter/material.dart';

class XHeader extends StatelessWidget {
  final bool isDarkMode;

  const XHeader({super.key, this.isDarkMode = true});

  @override
  Widget build(BuildContext context) {
    final uri = isDarkMode
        ? './assets/images/x.png'
        : './assets/images/x-dark.png';

    return Center(
      child: Image.asset(
        uri,
        height: 24,
      ),
    );
  }
}
