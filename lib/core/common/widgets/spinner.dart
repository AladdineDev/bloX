import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  const Spinner.small({
    super.key,
    this.strokeWidth = 2.5,
    this.dimension = 20,
    this.value,
    this.color,
    this.backgroundColor,
  });

  const Spinner.medium({
    super.key,
    this.strokeWidth = 4,
    this.dimension = 36,
    this.value,
    this.color,
    this.backgroundColor,
  });

  final double strokeWidth;
  final double dimension;
  final double? value;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          value: value,
          color: color,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}
