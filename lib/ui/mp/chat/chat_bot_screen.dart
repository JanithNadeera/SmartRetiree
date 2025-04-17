import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:smart_retiree/providers/chat_provider.dart';
import 'package:smart_retiree/widgets/custom_appbar.dart';

class ChatBotScreen extends ConsumerStatefulWidget {
  const ChatBotScreen({super.key});

  @override
  ConsumerState<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends ConsumerState<ChatBotScreen> {
  @override
  Widget build(BuildContext context) {
    return provider.Consumer<ChatProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: "Smart Retiree Assistant",
          ),
          body: DashChat(
            currentUser: ChatUser(id: "user"),
            onSend: (ChatMessage messages) {
              provider.sendMessages(userMessage: messages.text);
            },
            messages: provider.messages.reversed.map((chat) {
              return ChatMessage(
                text: chat['message'],
                user: ChatUser(
                  id: chat['role'] == 'user' ? "user" : "bot",
                  firstName:
                      chat['role'] == "bot" ? "Smart Retiree Assistant" : "You",
                  profileImage: chat['role'] == "bot"
                      ? "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-PNG.png"
                      : "https://i.imgur.com/QCNbOAo.png",
                ),
                customProperties: {
                  'isImage': chat['isImage'] ?? false,
                  "image": chat['image']
                },
                createdAt: DateTime.now(),
              );
            }).toList(),
            messageOptions: const MessageOptions(
              showOtherUsersName: true,
              showOtherUsersAvatar: true,
              showTime: true,
            ),
          ),
        );
      },
    );
  }
}
