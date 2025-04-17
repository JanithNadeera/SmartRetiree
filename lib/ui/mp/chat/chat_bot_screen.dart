import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;
import 'package:smart_retiree/utils/theme_extension.dart';
import 'package:smart_retiree/widgets/custom_appbar.dart' show CustomAppBar;
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  ChatBotScreenState createState() => ChatBotScreenState();
}

class ChatBotScreenState extends State<ChatBotScreen> {
  final List<types.Message> _messages = [];

  late final types.User _user;
  final _bot = const types.User(id: 'bot', firstName: 'Retiree Assistant');

  @override
  void initState() {
    super.initState();

    // Set the user from FirebaseAuth
    final currentUser = FirebaseAuth.instance.currentUser;
    _user = types.User(
      id: currentUser?.uid ?? 'user',
      firstName: currentUser?.displayName ?? 'You',
    );
  }

  Future<void> _handleSendPressed(types.PartialText message) async {
    final userMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, userMessage);
    });

    await _sendToChatGPT(message.text);
  }

  Future<void> _sendToChatGPT(String prompt) async {
    const apiKey =
        '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';

    final response = await http.post(
      Uri.parse("https://openrouter.ai/api/v1/chat/completions"),
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
        "HTTP-Referer": "http://localhost:3000",
        "X-Title": "Smart Retiree Assistant"
      },
      body: jsonEncode({
        "model": "mistralai/mistral-7b-instruct",
        "messages": [
          {
            "role": "system",
            "content":
                "You are a kind, caring, and helpful personal assistant for retired people. Speak in warm, friendly, and easy-to-understand language. Help with simple tasks, reminders, jokes, or health tips."
          },
          {"role": "user", "content": prompt}
        ]
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['choices'] != null) {
      final botText = data['choices'][0]['message']['content'];

      final botMessage = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: botText.trim(),
      );

      setState(() {
        _messages.insert(0, botMessage);
      });
    } else {
      final errorMessage = data['error']?['message'] ?? 'Something went wrong.';
      final botMessage = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: '⚠️ Error: $errorMessage',
      );

      setState(() {
        _messages.insert(0, botMessage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Smart Retiree Assistant",
      ),
      body: SafeArea(
        child: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          user: _user,
          theme: DefaultChatTheme(
            backgroundColor: context.surface,
            inputBackgroundColor: context.surface,
            inputTextColor: Colors.black,
            primaryColor: context.primary,
            secondaryColor: const Color(0xFFE5E5EA),
            sentMessageBodyTextStyle: const TextStyle(color: Colors.white),
            receivedMessageBodyTextStyle:
                const TextStyle(color: Colors.black87),
            inputBorderRadius: const BorderRadius.all(Radius.circular(5)),
            inputPadding: const EdgeInsets.all(16),
            inputTextDecoration: const InputDecoration(
                hintText: 'Type a message...',
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 4)),
            inputTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
            sendButtonIcon: Icon(Icons.send, color: context.primary),
          ),
          showUserAvatars: true,
          showUserNames: true,
          customMessageBuilder: (message, {required int messageWidth}) {
            final isUser = message.author.id == _user.id;
            final authorName = message.author.firstName ?? 'Unknown';

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
              child: Column(
                crossAxisAlignment:
                    isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    isUser ? 'You' : authorName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    constraints:
                        BoxConstraints(maxWidth: messageWidth.toDouble()),
                    decoration: BoxDecoration(
                      color: isUser ? context.primary : const Color(0xFFE5E5EA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      (message as types.TextMessage).text,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
