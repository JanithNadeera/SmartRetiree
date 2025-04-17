// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class AppEvent {
  final String id;
  final String name;
  final DateTime time;
  final String location;
  final String type;
  final String imageUrl;
  final String description;
  final DateTime createdAt;
  final String createdBy;
  final List<String> members;

  AppEvent({
    required this.id,
    required this.name,
    required this.time,
    required this.location,
    required this.type,
    required this.imageUrl,
    required this.description,
    required this.createdAt,
    required this.createdBy,
    required this.members,
  });

  factory AppEvent.fromMap(String uid, Map<String, dynamic> data) {
    return AppEvent(
      id: uid,
      name: data['name'] ?? '',
      time: (data['time'] as Timestamp).toDate(),
      location: data['location'] ?? '',
      type: data['type'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      createdBy: data['createdBy'] ?? '',
      members: List<String>.from(data['members'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'time': Timestamp.fromDate(time),
      'location': location,
      'type': type,
      'imageUrl': imageUrl,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
      'createdBy': createdBy,
      'members': members,
    };
  }

  AppEvent copyWith({
    String? id,
    String? name,
    DateTime? time,
    String? location,
    String? type,
    String? imageUrl,
    String? description,
    DateTime? createdAt,
    String? createdBy,
    List<String>? members,
  }) {
    return AppEvent(
      id: id ?? this.id,
      name: name ?? this.name,
      time: time ?? this.time,
      location: location ?? this.location,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      members: members ?? this.members,
    );
  }
}
