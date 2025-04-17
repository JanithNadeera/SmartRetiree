import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:smart_retiree/models/app_user.dart';
import 'package:smart_retiree/models/chat_message.dart';
import 'package:smart_retiree/models/chat_room.dart';
import 'package:smart_retiree/providers/user_provider.dart';
import 'package:smart_retiree/widgets/custom_appbar.dart';
import 'package:smart_retiree/widgets/members_popup.dart';
import 'package:smart_retiree/widgets/shader_mask_wrapper.dart';
import 'package:smart_retiree/ui/mp/chat/widgets/chat_bubble.dart';
import 'package:smart_retiree/ui/mp/chat/widgets/date_separator.dart';
import 'package:smart_retiree/ui/mp/chat/widgets/message_input.dart';
import 'package:smart_retiree/utils/core_utils.dart';
import 'package:smart_retiree/utils/loader.dart';

class SingleChatRoomScreen extends ConsumerStatefulWidget {
  final ChatRoom chatRoom;

  const SingleChatRoomScreen({super.key, required this.chatRoom});

  @override
  ConsumerState<SingleChatRoomScreen> createState() =>
      _SingleChatRoomScreenState();
}

class _SingleChatRoomScreenState extends ConsumerState<SingleChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  late AppUser _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = ref.read(userProvider)!;
  }

  Stream<Map<String, AppUser>> _usersStream(List<String> userIds) {
    if (userIds.isEmpty) return const Stream.empty();

    return FirebaseFirestore.instance
        .collection('users')
        .where(FieldPath.documentId, whereIn: userIds)
        .snapshots()
        .map((snapshot) {
      return {
        for (var doc in snapshot.docs)
          doc.id: AppUser.fromMap(doc.id, doc.data())
      };
    });
  }

  Stream<List<ChatMessage>> _messageStream() {
    return FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(widget.chatRoom.id)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatMessage.fromMap(doc.id, doc.data()))
            .toList());
  }

  Future<void> _sendMessage(AppUser currentUser, List<String> memberIds) async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _messageController.clear();
    _focusNode.requestFocus();

    try {
      final message = ChatMessage(
        id: '',
        message: text,
        createdAt: DateTime.now(),
        sendBy: currentUser.uid,
      );

      final docRef = FirebaseFirestore.instance
          .collection('chatRooms')
          .doc(widget.chatRoom.id);

      await docRef.collection('messages').add(message.toMap());

      if (!memberIds.contains(currentUser.uid)) {
        final updated = List<String>.from(memberIds)..add(currentUser.uid);
        await docRef.update({'members': updated});
      }
    } catch (e) {
      CoreUtils.showToast(
          type: ToastType.error, message: 'Failed to send message: $e');
    }
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chatRooms')
            .doc(widget.chatRoom.id)
            .snapshots(),
        builder: (context, roomSnapshot) {
          if (!roomSnapshot.hasData || !roomSnapshot.data!.exists) {
            return Scaffold(
              appBar: CustomAppBar(title: widget.chatRoom.name),
              body: Loader.indicator(),
            );
          }

          final roomData = roomSnapshot.data!.data() as Map<String, dynamic>;
          final List<String> memberIds =
              List<String>.from(roomData['members'] ?? []);

          return StreamBuilder<Map<String, AppUser>>(
            stream: _usersStream(memberIds),
            builder: (context, userSnapshot) {
              if (!userSnapshot.hasData) {
                return Scaffold(
                  appBar: CustomAppBar(title: widget.chatRoom.name),
                  body: Loader.indicator(),
                );
              }

              final userMap = userSnapshot.data!;
              final currentUser =
                  userMap[_currentUser.uid] ?? ref.watch(userProvider);

              return Scaffold(
                appBar: CustomAppBar(
                  title: widget.chatRoom.name,
                  actions: [
                    IconButton(
                      icon: const ShaderMaskWrapper(
                        child: Icon(
                          MingCuteIcons.mgc_group_line,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        CoreUtils.heroDialog(
                          MembersPopup(
                            title: 'Chat Members',
                            userIds:
                                userMap.values.map((user) => user.uid).toList(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<List<ChatMessage>>(
                        stream: _messageStream(),
                        builder: (context, messageSnapshot) {
                          if (!messageSnapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final messages = messageSnapshot.data!;
                          if (messages.isEmpty) {
                            return Center(
                              child: Text(
                                'No messages yet.\nStart a conversation!',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            );
                          }

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (_scrollController.hasClients) {
                              _scrollController.animateTo(
                                0.0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            }
                          });

                          return ListView.builder(
                            controller: _scrollController,
                            reverse: true,
                            padding: const EdgeInsets.only(bottom: 16),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              final showDateSeparator =
                                  index == messages.length - 1 ||
                                      !_isSameDay(
                                        message.createdAt,
                                        messages[index + 1].createdAt,
                                      );

                              final user = userMap[message.sendBy] ??
                                  AppUser.empty(message.sendBy);

                              return Column(
                                children: [
                                  if (showDateSeparator)
                                    DateSeparator(date: message.createdAt),
                                  ChatBubble(message: message, user: user),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                    MessageInput(
                      controller: _messageController,
                      focusNode: _focusNode,
                      sendMessage: () => _sendMessage(currentUser!, memberIds),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
