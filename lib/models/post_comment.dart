import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_retiree/models/post_user.dart';

class PostComment {
  final String id;
  final String comment;
  final DateTime createdAt;
  final PostUser createdBy;

  PostComment({
    required this.id,
    required this.comment,
    required this.createdAt,
    required this.createdBy,
  });

  factory PostComment.fromMap(Map<String, dynamic> map) {
    return PostComment(
      id: map['id'] ?? '',
      comment: map['comment'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      createdBy: PostUser.fromMap(map['created_by']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'createdAt': Timestamp.fromDate(createdAt),
      'created_by': createdBy.toMap(),
    };
  }
}
