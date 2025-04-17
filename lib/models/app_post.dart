import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_retiree/models/post_user.dart';

class AppPost {
  final String id;
  final String title;
  final String? imageUrl;
  final DateTime createdAt;
  final PostUser createdBy;
  final List<String> tags;
  final List<String> likes;
  final int commentsCount;

  AppPost({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.createdAt,
    required this.createdBy,
    required this.tags,
    required this.likes,
    required this.commentsCount,
  });

  factory AppPost.fromMap(String uid, Map<String, dynamic> data) {
    return AppPost(
      id: uid,
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      createdBy: PostUser.fromMap(data['createdBy']),
      tags: List<String>.from(data['tags'] ?? []),
      likes: List<String>.from(data['likes']),
      commentsCount: data['commentsCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'createdBy': createdBy.toMap(),
      'tags': tags,
      'likes': likes,
    };
  }
}
