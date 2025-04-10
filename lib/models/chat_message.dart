import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String id;
  final String message;
  final DateTime createdAt;
  final String sendBy;
  final String messageType;

  ChatMessage({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.sendBy,
    this.messageType = 'text',
  });

  factory ChatMessage.fromMap(String id, Map<String, dynamic> map) {
    return ChatMessage(
      id: id,
      message: map['message'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      sendBy: map['sendBy'] ?? '',
      messageType: map['messageType'] ?? 'text',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'createdAt': Timestamp.fromDate(createdAt),
      'sendBy': sendBy,
      'messageType': messageType,
    };
  }
}
