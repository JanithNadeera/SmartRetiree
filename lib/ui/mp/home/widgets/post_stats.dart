import 'package:flutter/material.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class PostStats extends StatelessWidget {
  const PostStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          Text("4 Likes", style: context.labelMedium),
          const SizedBox(width: 24),
          Text("10 Comments", style: context.labelMedium),
        ],
      ),
    );
  }
}
