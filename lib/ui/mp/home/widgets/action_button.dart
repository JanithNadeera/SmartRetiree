import 'package:flutter/material.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Text(
            label,
            style: context.titleMedium.copyWith(
              color: context.titleMedium.color?.withAlpha(180),
            ),
          ),
        ],
      ),
    );
  }
}
