import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smart_retiree/models/app_user.dart';
import 'package:smart_retiree/models/chat_message.dart';
import 'package:smart_retiree/providers/user_provider.dart';
import 'package:smart_retiree/ui/mp/chat_room/widgets/user_avatar.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class ChatBubble extends ConsumerWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.user,
  });

  final ChatMessage message;
  final AppUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCurrentUser = message.sendBy == ref.watch(userProvider)!.uid;
    final time = DateFormat('h:mm a').format(message.createdAt);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isCurrentUser) ...[
            UserAvatar(imageUrl: user.profilePhoto),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isCurrentUser
                    ? context.primary.withAlpha(200)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isCurrentUser)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        user.fullName,
                        style: TextStyle(
                          color: context.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  Text(
                    message.message,
                    style: TextStyle(
                      color: isCurrentUser ? Colors.white : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          color:
                              isCurrentUser ? Colors.white : Colors.grey[500],
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isCurrentUser) const SizedBox(width: 4),
        ],
      ),
    );
  }
}
