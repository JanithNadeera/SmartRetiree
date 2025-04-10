import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:smart_retiree/models/app_user.dart';
import 'package:smart_retiree/models/chat_message.dart';
import 'package:smart_retiree/models/chat_room.dart';
import 'package:smart_retiree/providers/user_provider.dart';
import 'package:smart_retiree/shared_widgets/custom_appbar.dart';
import 'package:smart_retiree/shared_widgets/members_popup.dart';
import 'package:smart_retiree/shared_widgets/shader_mask_wrapper.dart';
import 'package:smart_retiree/ui/mp/chat_room/widgets/chat_bubble.dart';
import 'package:smart_retiree/ui/mp/chat_room/widgets/date_separator.dart';
import 'package:smart_retiree/ui/mp/chat_room/widgets/message_input.dart';
import 'package:smart_retiree/utils/core_utils.dart';

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
  StreamSubscription? _messageSubscription;

  List<AppUser> _users = [];
  late AppUser _currentUser;
  List<ChatMessage> _messages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _currentUser = ref.read(userProvider)!;
    _loadChatData();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    _messageSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadChatData() async {
    try {
      // Load room data
      final roomDoc = await FirebaseFirestore.instance
          .collection('chatRooms')
          .doc(widget.chatRoom.id)
          .get();

      if (!roomDoc.exists) {
        setState(() => _isLoading = false);
        return;
      }

      // Get member IDs
      final List<String> memberIds =
          List<String>.from(roomDoc.data()?['members'] ?? []);
      log(memberIds.toString());
      // Load users
      await _loadUsers(memberIds);

      // Start listening to messages
      _setupMessageListener();
    } catch (e) {
      log('Error loading chat data: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadUsers(List<String> userIds) async {
    if (userIds.isEmpty) {
      setState(() => _isLoading = false);
      return;
    }
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where(FieldPath.documentId, whereIn: userIds)
          .get();

      final users = querySnapshot.docs
          .map((doc) => AppUser.fromMap(doc.id, doc.data()))
          .toList();

      setState(() {
        _users = users;
        _currentUser = users.firstWhere(
          (user) => user.uid == _currentUser.uid,
        );
        _isLoading = false;
      });
    } catch (e) {
      log('Error loading users: $e');
      setState(() => _isLoading = false);
    }
  }

  void _setupMessageListener() {
    _messageSubscription = FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(widget.chatRoom.id)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      final messages = snapshot.docs
          .map((doc) => ChatMessage.fromMap(doc.id, doc.data()))
          .toList();

      // Check if the widget is still mounted before updating state
      if (mounted) {
        CoreUtils.postFrameCall(() {
          if (mounted) {
            setState(() => _messages = messages);
          }
        });
      }

      // Scroll to bottom on new messages if already at bottom
      if (mounted) {
        CoreUtils.postFrameCall(() {
          if (mounted) {
            _scrollToBottomIfNeeded();
          }
        });
      }
    });
  }

  void _scrollToBottomIfNeeded() {
    if (_scrollController.hasClients) {
      final position = _scrollController.position;
      final isNearBottom = position.pixels > position.maxScrollExtent - 100;

      if (isNearBottom) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _messageController.clear();
    _focusNode.requestFocus();

    try {
      final message = ChatMessage(
        id: '', // Will be updated after adding
        message: text,
        createdAt: DateTime.now(),
        sendBy: _currentUser.uid,
      );

      // Get the current room document first
      final roomDoc = await FirebaseFirestore.instance
          .collection('chatRooms')
          .doc(widget.chatRoom.id)
          .get();

      final List<String> existingMembers =
          List<String>.from(roomDoc.data()?['members'] ?? []);

      // Check if current user needs to be added to members
      bool isNewMember = !existingMembers.contains(_currentUser.uid);

      // First add the message
      await FirebaseFirestore.instance
          .collection('chatRooms')
          .doc(widget.chatRoom.id)
          .collection('messages')
          .add(message.toMap());

      // Then update members list if needed
      if (isNewMember) {
        existingMembers.add(_currentUser.uid);

        await FirebaseFirestore.instance
            .collection('chatRooms')
            .doc(widget.chatRoom.id)
            .update({'members': existingMembers});

        // Update local state if needed - safely
        if (mounted && !_users.any((user) => user.uid == _currentUser.uid)) {
          setState(() {
            _users.add(_currentUser);
          });
        }
      }
    } catch (e) {
      if (mounted) {
        CoreUtils.showToast(
            type: ToastType.error, message: 'Failed to send message: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: CustomAppBar(title: widget.chatRoom.name),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.chatRoom.name,
        actions: [
          IconButton(
            icon: const ShaderMaskWrapper(
              child: Icon(
                MingCute.group_fill,
                size: 25,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              CoreUtils.heroDialog(MembersPopup(
                title: 'Chat Members',
                users: _users,
              ));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Text(
                      'No messages yet.\nStart a conversation!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final showDateSeparator = index == _messages.length - 1 ||
                          !_isSameDay(
                            message.createdAt,
                            _messages[index + 1].createdAt,
                          );

                      return Column(
                        children: [
                          if (showDateSeparator)
                            DateSeparator(date: message.createdAt),
                          ChatBubble(
                            message: message,
                            user: _users.firstWhere(
                              (u) => u.uid == message.sendBy,
                              orElse: () => AppUser.empty(message.sendBy),
                            ),
                          )
                        ],
                      );
                    },
                  ),
          ),
          MessageInput(
            controller: _messageController,
            focusNode: _focusNode,
            sendMessage: _sendMessage,
          ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
