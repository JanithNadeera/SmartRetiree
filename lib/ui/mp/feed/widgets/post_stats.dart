import 'package:flutter/material.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class PostStats extends StatelessWidget {
  final List<String> likes;
  final int commentsCount;
  const PostStats(
      {super.key, required this.likes, required this.commentsCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          Text("${likes.length} Likes", style: context.labelMedium),
          const SizedBox(width: 24),
          Text("$commentsCount Comments", style: context.labelMedium),
        ],
      ),
    );
  }
}
