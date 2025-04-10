import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

class CommentInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const CommentInputField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextField(
                controller: controller,
                style: const TextStyle(color: Color(0xFF15294B), fontSize: 14),
                maxLines: 1,
                decoration: const InputDecoration(
                  filled: false,
                  hintText: "Add comment here...",
                  hintStyle: TextStyle(color: Color(0xFF7A8699), fontSize: 14),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onSend,
            child: Container(
              alignment: Alignment.center,
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFEC2824), // Primary Red
                    Color(0xFFF06292), // Pink
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius:
                    BorderRadius.circular(4), // Optional: Rounded corners
              ),
              child: const Icon(
                MingCuteIcons.mgc_send_line,
                color: Colors.white,
                size: 22.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
