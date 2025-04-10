import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_retiree/models/chat_room.dart';
import 'package:smart_retiree/providers/user_provider.dart';
import 'package:smart_retiree/shared_widgets/create_new_chat_popup.dart';
import 'package:smart_retiree/shared_widgets/custom_appbar.dart';
import 'package:smart_retiree/shared_widgets/submit_button.dart';
import 'package:smart_retiree/ui/mp/chat_room/single_chat_room_screen.dart';
import 'package:smart_retiree/utils/core_utils.dart';
import 'package:smart_retiree/utils/loader.dart';

class ChatRoomsScreen extends ConsumerStatefulWidget {
  const ChatRoomsScreen({super.key});

  @override
  ConsumerState<ChatRoomsScreen> createState() => _ChatRoomsScreenState();
}

class _ChatRoomsScreenState extends ConsumerState<ChatRoomsScreen> {
  final _newRoomController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
        _openChatRoom(newRoom.copyWith(id: docRef.id));
      }
    } catch (e) {
      CoreUtils.showToast(
          type: ToastType.error, message: 'Failed to create chat room: $e');
    } finally {
      Loader.show(false);
    }
  }

  void _openChatRoom(ChatRoom chatRoom) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingleChatRoomScreen(chatRoom: chatRoom),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Gatherings", withShader: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () => CoreUtils.heroDialog(
          CreateNewChatPopup(
            controller: _newRoomController,
            onCreate: _createNewChatRoom,
          ),
        ),
        child: const Icon(Icons.add),
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
              return _buildEmptyState();
            }

            final chatRooms = snapshot.data!;

            return ListView.builder(
              itemCount: chatRooms.length,
              itemBuilder: (context, index) {
                final room = chatRooms[index];
                return _buildChatRoomItem(room);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.chat_bubble_outline,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'No chat rooms available',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Create a new chat room to get started',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          SubmitButton(
            onPressed: () => CoreUtils.heroDialog(
              CreateNewChatPopup(
                controller: _newRoomController,
                onCreate: _createNewChatRoom,
              ),
            ),
            label: 'Create Chat Room',
          )
        ],
      ),
    );
  }

  Widget _buildChatRoomItem(ChatRoom room) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: room.image.isNotEmpty
          ? CircleAvatar(
              backgroundImage: NetworkImage(room.image),
            )
          : CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                room.name.isNotEmpty ? room.name[0].toUpperCase() : '?',
                style: const TextStyle(color: Colors.white),
              ),
            ),
      title: Text(
        room.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text('${room.members.length} members'),
      onTap: () => _openChatRoom(room),
    );
  }
}
