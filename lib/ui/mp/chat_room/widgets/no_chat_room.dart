import 'package:flutter/material.dart';
import 'package:smart_retiree/shared_widgets/submit_button.dart';

class NoChatRoom extends StatelessWidget {
  const NoChatRoom({
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
            Icons.chat_bubble_outline,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'No chat rooms available',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Create a new chat room to get started',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          SubmitButton(
            onPressed: onTap,
            label: 'Create Chat Room',
          )
        ],
      ),
    );
  }
}
