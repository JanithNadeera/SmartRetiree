import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:smart_retiree/widgets/submit_button.dart';

class NoEvents extends StatelessWidget {
  const NoEvents({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            MingCuteIcons.mgc_heart_crack_line,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'No events available',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Create a new event to get started',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          SubmitButton(
            onPressed: onTap,
            label: 'Create new event',
          )
        ],
      ),
    );
  }
}
