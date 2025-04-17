import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:smart_retiree/models/chat_room.dart';
import 'package:smart_retiree/providers/user_provider.dart';
import 'package:smart_retiree/ui/mp/chat/chat_bot_screen.dart';
import 'package:smart_retiree/widgets/create_new_chat_popup.dart';
import 'package:smart_retiree/widgets/custom_appbar.dart';
import 'package:smart_retiree/widgets/shader_mask_wrapper.dart';
import 'package:smart_retiree/ui/mp/chat/single_chat_room_screen.dart';
import 'package:smart_retiree/ui/mp/chat/widgets/chat_room_card.dart';
import 'package:smart_retiree/ui/mp/chat/widgets/no_chat_room.dart';
import 'package:smart_retiree/utils/core_utils.dart';
import 'package:smart_retiree/utils/loader.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _newRoomController = TextEditingController();

  @override
  void dispose() {
    _newRoomController.dispose();
    super.dispose();
  }

  Stream<List<ChatRoom>> _chatRoomsStream() {
    return FirebaseFirestore.instance
        .collection('chatRooms')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatRoom.fromMap(doc.id, doc.data()))
            .toList());
  }

  Future<void> _createNewChatRoom() async {
    try {
      Loader.show(true);
      final currentUser = ref.read(userProvider)!;

      final newRoom = ChatRoom(
        id: '',
        name: _newRoomController.text.trim(),
        image: '',
        members: [currentUser.uid],
        createdAt: DateTime.now(),
      );

      final docRef = await FirebaseFirestore.instance
          .collection('chatRooms')
          .add(newRoom.toMap());

      _newRoomController.clear();
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleChatRoomScreen(
                chatRoom: (newRoom.copyWith(id: docRef.id))),
          ),
        );
      }
    } catch (e) {
      CoreUtils.showToast(
          type: ToastType.error, message: 'Failed to create chat room: $e');
    } finally {
      Loader.show(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Gatherings",
        withShader: true,
        actions: [
          IconButton(
            onPressed: () {
              CoreUtils.heroDialog(
                CreateNewChatPopup(
                  controller: _newRoomController,
                  onCreate: _createNewChatRoom,
                ),
              );
            },
            icon: const ShaderMaskWrapper(
              child: Icon(
                MingCuteIcons.mgc_add_circle_line,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatBotScreen(),
                  ));
            },
            icon: const ShaderMaskWrapper(
              child: Icon(
                MingCuteIcons.mgc_ai_line,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<List<ChatRoom>>(
          stream: _chatRoomsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Loader.indicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading chat rooms'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return NoChatRoom(
                onTap: () => CoreUtils.heroDialog(
                  CreateNewChatPopup(
                    controller: _newRoomController,
                    onCreate: _createNewChatRoom,
                  ),
                ),
              );
            }

            final chatRooms = snapshot.data!;

            return ListView.builder(
              itemCount: chatRooms.length,
              itemBuilder: (context, index) {
                final room = chatRooms[index];
                return ChatRoomCard(chatRoom: room);
              },
            );
          },
        ),
      ),
    );
  }
}
