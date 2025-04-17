import 'package:flutter/material.dart';

class SheetHandler extends StatelessWidget {
  const SheetHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          width: 40,
          height: 5,
          decoration: BoxDecoration(
            color: const Color(0xFF7F7F7F),
            borderRadius: BorderRadius.circular(2.5),
          ),
        ),
      ),
    );
  }
}
