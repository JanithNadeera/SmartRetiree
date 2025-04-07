import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.width,
    this.height,
  });

  final VoidCallback onPressed;
  final String label;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          width ?? MediaQuery.of(context).size.width * .8,
          height ?? 50,
        ),
      ),
      child: Text(label),
    );
  }
}
