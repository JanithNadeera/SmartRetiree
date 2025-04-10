import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smart_retiree/models/app_user.dart';
import 'package:smart_retiree/models/chat_message.dart';
import 'package:smart_retiree/models/chat_room.dart';
import 'package:smart_retiree/providers/user_provider.dart';
import 'package:smart_retiree/shared_widgets/custom_appbar.dart';
import 'package:smart_retiree/utils/core_utils.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

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

  String _getUserName(String userId) {
    final user = _users.firstWhere(
      (u) => u.uid == userId,
      orElse: () => AppUser.empty(userId),
    );
    return user.fullName;
  }

  Widget _buildMessageItem(ChatMessage message) {
    final isCurrentUser = message.sendBy == _currentUser.uid;
    final time = DateFormat('h:mm a').format(message.createdAt);
    // final date = DateFormat('MMM d').format(message.createdAt);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isCurrentUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[300],
              backgroundImage: _getUserProfileImage(message.sendBy),
              child: _getUserProfileImage(message.sendBy) == null
                  ? Text(_getUserName(message.sendBy)[0])
                  : null,
            ),
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
                        _getUserName(message.sendBy),
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

  ImageProvider? _getUserProfileImage(String userId) {
    final user = _users.firstWhere(
      (u) => u.uid == userId,
      orElse: () => AppUser.empty(userId),
    );

    return user.profilePhoto != null ? NetworkImage(user.profilePhoto!) : null;
  }

  Widget _buildDateSeparator(DateTime date) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              DateFormat('MMMM d, yyyy').format(date),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
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
            icon: const Icon(Icons.people),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Chat Members'),
                  content: SizedBox(
                    width: double.maxFinite,
                    height: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _users.length,
                      itemBuilder: (context, index) {
                        final user = _users[index];
                        final isCurrentUser = user.uid == _currentUser.uid;

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: user.profilePhoto != null
                                ? NetworkImage(user.profilePhoto!)
                                : null,
                            child: user.profilePhoto == null
                                ? Text(user.firstName[0])
                                : null,
                          ),
                          title: Text(
                            isCurrentUser
                                ? '${user.fullName} (You)'
                                : user.fullName,
                          ),
                        );
                      },
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Message list
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
                            _buildDateSeparator(message.createdAt),
                          _buildMessageItem(message),
                        ],
                      );
                    },
                  ),
          ),

          // Message input
          Container(
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
                  // IconButton(
                  //   icon: const Icon(Icons.attach_file),
                  //   onPressed: () {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(
                  //         content: Text('File attachment not implemented yet'),
                  //       ),
                  //     );
                  //   },
                  // ),
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
                        controller: _messageController,
                        focusNode: _focusNode,
                        style: const TextStyle(
                            color: Color(0xFF15294B), fontSize: 14),
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
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: context.primary,
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
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
