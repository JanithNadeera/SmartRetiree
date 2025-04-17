import 'package:flutter/material.dart';

class ShaderMaskWrapper extends StatelessWidget {
  const ShaderMaskWrapper({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: [
            Color(0xFFEC2824),
            // Color(0xFFF06292),
            // Color(0xFFFFC107),
            // Color(0xFF2196F3),
            // Color(0xFFFF5722),
            Color(0xFF9C27B0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
