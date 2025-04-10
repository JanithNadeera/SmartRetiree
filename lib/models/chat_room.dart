import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String id;
  final String name;
  final String image;
  final List<String> members;
  final DateTime createdAt;

  ChatRoom({
    required this.id,
    required this.name,
    required this.image,
    required this.members,
    required this.createdAt,
  });

  factory ChatRoom.fromMap(String id, Map<String, dynamic> map) {
    return ChatRoom(
      id: id,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      members: List<String>.from(map['members'] ?? []),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'members': members,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  ChatRoom copyWith({
    String? id,
    String? name,
    String? image,
    List<String>? members,
    DateTime? createdAt,
  }) {
    return ChatRoom(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      members: members ?? this.members,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
