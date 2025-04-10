import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_retiree/models/app_user.dart';
import 'package:smart_retiree/models/chat_room.dart';
import 'package:smart_retiree/utils/user_role_selector.dart';

class FirebaseUtils {
  static Future<Map<String, dynamic>> populateDummyChatForTesting() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final result = {'userIds': <String>[], 'roomId': ''};

      // Create 3 test users with auto-generated IDs
      final userIds = <String>[];
      final testUsers = [
        AppUser(
          uid: '',
          email: 'asela@gmail.com',
          firstName: 'Asela',
          lastName: 'Ranathunga',
          occupation: 'Mobile Developer',
          profilePhoto: 'https://i.pravatar.cc/150?img=1',
          role: UserRole.retiree,
        ),
        AppUser(
          uid: '',
          email: 'thushan@gmail.com',
          firstName: 'Thushan',
          lastName: 'Karunathilaka',
          occupation: 'Senior Mobile Developer',
          profilePhoto: 'https://i.pravatar.cc/150?img=2',
          role: UserRole.retiree,
        ),
        AppUser(
          uid: '',
          email: 'janith@gmail.com',
          firstName: 'Janith',
          lastName: 'Nadeera',
          occupation: 'Mobile Developer',
          profilePhoto: 'https://i.pravatar.cc/150?img=3',
          role: UserRole.seeker,
        ),
      ];

      // Add users with auto-generated IDs
      for (final user in testUsers) {
        final docRef = await firestore.collection('users').add(user.toMap());
        userIds.add(docRef.id);
      }

      result['userIds'] = userIds;

      // Create a test room with auto-generated ID
      final roomRef = await firestore.collection('chatRooms').add(ChatRoom(
            id: '',
            name: 'Life Hacks',
            image: 'https://fastly.picsum.photos/id/20/3670/2462.jpg',
            members: userIds,
            createdAt: DateTime.now(),
          ).toMap());

      final roomId = roomRef.id;
      result['roomId'] = roomId;

      // Add some test messages
      final messages = [
        {
          'sendBy': userIds[0],
          'message': 'Hello!',
          'createdAt': DateTime.now()
        },
        {
          'sendBy': userIds[1],
          'message': 'Hi there!',
          'createdAt': DateTime.now().add(const Duration(minutes: 1))
        },
        {
          'sendBy': userIds[2],
          'message': 'How is everyone?',
          'createdAt': DateTime.now().add(const Duration(minutes: 3))
        },
        {
          'sendBy': userIds[0],
          'message': 'I am fine guys',
          'createdAt': DateTime.now().add(const Duration(minutes: 5))
        },
        {
          'sendBy': FirebaseAuth.instance.currentUser?.uid,
          'message':
              "You have to make a plan for your daily activities or else you'll be so stressed, anxious and feel like you are controlled by your day.",
          'createdAt': DateTime.now().add(const Duration(minutes: 8))
        },
      ];

      for (final message in messages) {
        final ref = await firestore
            .collection('chatRooms')
            .doc(roomId)
            .collection('messages')
            .add({
          ...message,
        });

        await ref.update({'id': ref.id});
      }

      return result;
    } catch (e) {
      log('Error creating test data: $e');
      return {};
    }
  }

  static void clearAllChatRooms() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final chatRoomsSnapshot = await firestore.collection('chatRooms').get();

      for (final roomDoc in chatRoomsSnapshot.docs) {
        // Delete messages in the room
        // final messagesSnapshot =
        //     await roomDoc.reference.collection('messages').get();
        // for (final messageDoc in messagesSnapshot.docs) {
        //   await messageDoc.reference.delete();
        // }

        // Delete the chat room document
        await roomDoc.reference.delete();
      }

      log('All chat rooms and their messages have been cleared.');
    } catch (e) {
      log('Error clearing chat rooms: $e');
    }
  }

  static void clearAllEvents() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final eventSnapshot = await firestore.collection('events').get();

      for (final eventDoc in eventSnapshot.docs) {
        await eventDoc.reference.delete();
      }

      log('All events have been cleared.');
    } catch (e) {
      log('Error clearing events: $e');
    }
  }
}
