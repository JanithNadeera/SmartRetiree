import 'package:flutter/material.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.sendMessage,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback sendMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 12.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 4,
            color: Colors.black.withAlpha(25),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  style:
                      const TextStyle(color: Color(0xFF15294B), fontSize: 14),
                  decoration: const InputDecoration(
                    filled: false,
                    hintText: "Type a message",
                    hintStyle:
                        TextStyle(color: Color(0xFF7A8699), fontSize: 14),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 1,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              color: context.primary,
              onPressed: sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
