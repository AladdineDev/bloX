import 'dart:async';
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
  final Function(String)? onChanged;
  final Function(String)? debouncedOnChanged;
  final String? Function(String?)? validator;
  final bool showCheckMarkWhenValid;
  final bool Function(String? value)? customValidation;
  final bool readOnly;

  const Input({
    super.key,
    this.controller,
    this.focusNode,
    required this.labelText,
    this.keyboardType,
    this.maxLength,
    this.errorText,
    this.onTap,
    this.onChanged,
    this.debouncedOnChanged,
    this.validator,
    this.showCheckMarkWhenValid = false,
    this.customValidation,
    this.readOnly = false
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  Color mainColor = Colors.grey;
  bool _isPasswordVisible = false;

  Timer? _debounce;

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
    _debounce?.cancel();
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
    return GestureDetector(
      onTap: () {
        widget.onTap?.call();
      },
      child: Container(
        constraints: const BoxConstraints(minHeight: 85),
        child: TextFormField(
          focusNode: _focusNode,
          maxLength: widget.maxLength,
          keyboardType: widget.keyboardType,
          controller: _controller,
          readOnly: widget.readOnly,
          onChanged: _onInputChanged,
          obscureText: widget.keyboardType == TextInputType.visiblePassword
              ? !_isPasswordVisible
              : false,
          validator: widget.validator,
          decoration: InputDecoration(
            errorText: widget.errorText,
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: mainColor),
            ),
            labelText: widget.labelText,
            labelStyle: TextStyle(
              color: widget.errorText != null ? Colors.red : mainColor,
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
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: mainColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                _buildValidationIcon(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onInputChanged(String value) {
    widget.onChanged?.call(value);
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.debouncedOnChanged?.call(value);
      setState(() {
        // Force rebuild to update validation icon
      });
    });
  }

  Widget _buildValidationIcon() {
    if (widget.errorText != null) {
      return const Icon(Icons.error, color: Colors.red, size: 20);
    }
    final validationResult = widget.customValidation?.call(_controller.text) ??
        _controller.text.isNotEmpty;
    if (widget.showCheckMarkWhenValid && validationResult) {
      return const Icon(Icons.check_circle, color: Colors.green, size: 20);
    }
    return const SizedBox();
  }
}
