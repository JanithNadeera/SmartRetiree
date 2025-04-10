import 'package:flutter/material.dart';
import 'package:smart_retiree/models/chat_room.dart';
import 'package:smart_retiree/ui/mp/chat_room/single_chat_room_screen.dart';
import 'package:smart_retiree/utils/string_extension.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class ChatRoomCard extends StatelessWidget {
  const ChatRoomCard({super.key, required this.chatRoom});

  final ChatRoom chatRoom;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: context.primary,
        child: Text(
          chatRoom.name.initials,
          style: context.titleMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        chatRoom.name,
        style: context.headlineSmall,
      ),
      subtitle: Text(
        '${chatRoom.members.length} members',
        style: context.bodyMedium,
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SingleChatRoomScreen(chatRoom: chatRoom),
        ),
      ),
    );
  }
}
