import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final String label;
  final String initialValue;
  final bool readOnly;
  final TextEditingController? controller;

  const ProfileField({
    super.key,
    required this.label,
    required this.initialValue,
    this.readOnly = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}