import 'package:flutter/material.dart';

class VisibilityToggle extends StatelessWidget {
  final String label;

  const VisibilityToggle({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(label),
    );
  }
}