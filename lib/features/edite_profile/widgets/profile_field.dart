import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final String label;
  final String initialValue;
  final bool readOnly;

  const ProfileField({super.key,
    required this.label,
    required this.initialValue,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          border:const OutlineInputBorder(),
        ),
      ),
    );
  }
}