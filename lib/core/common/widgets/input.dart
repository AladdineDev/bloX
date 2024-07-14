import 'dart:math';

import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String labelText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final String? errorText;
  final Function()? onTap;

  const Input({
    super.key,
    this.controller,
    this.focusNode,
    required this.labelText,
    this.keyboardType,
    this.maxLength,
    this.errorText,
    this.onTap,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  Color mainColor = Colors.grey;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      setState(() {
        mainColor = _focusNode.hasFocus ? Colors.blue : Colors.grey;
      });
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 85),
      child: TextFormField(
        focusNode: _focusNode,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        controller: _controller,
        onTap: widget.onTap,
        obscureText: widget.keyboardType == TextInputType.visiblePassword
            ? !_isPasswordVisible
            : false,
        decoration: InputDecoration(
          errorText: widget.errorText,
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor),
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: mainColor,
          ),
          counterStyle: const TextStyle(color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: widget.keyboardType == TextInputType.visiblePassword,
                child: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: mainColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              Visibility(
                visible: widget.errorText != null,
                child: const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
