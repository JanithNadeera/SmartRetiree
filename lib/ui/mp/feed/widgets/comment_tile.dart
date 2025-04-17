import 'package:flutter/material.dart';
import 'package:smart_retiree/models/post_comment.dart';
import 'package:smart_retiree/ui/mp/chat/widgets/user_avatar.dart';

class CommentTile extends StatelessWidget {
  final PostComment comment;

  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0, right: 8),
          child: UserAvatar(
            imageUrl: comment.createdBy.profilePhoto,
            radius: 30,
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6F7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.createdBy.fullName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF15294B),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  comment.comment,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF505F79),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
