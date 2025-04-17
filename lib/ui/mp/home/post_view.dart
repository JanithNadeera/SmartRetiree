import 'package:flutter/material.dart';
import 'package:smart_retiree/models/app_post.dart';
import 'package:smart_retiree/ui/mp/home/widgets/post_action.dart';
import 'package:smart_retiree/ui/mp/home/widgets/post_hash_tags.dart';
import 'package:smart_retiree/ui/mp/home/widgets/post_header.dart';
import 'package:smart_retiree/ui/mp/home/widgets/post_image.dart';
import 'package:smart_retiree/ui/mp/home/widgets/post_stats.dart';
import 'package:smart_retiree/ui/mp/home/widgets/post_text_body.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class PostView extends StatelessWidget {
  final AppPost post;
  const PostView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      color: context.primaryContainer,
      width: double.infinity,
      child: Column(
        children: [
          PostHeader(createdAt: post.createdAt, user: post.createdBy),
          PostTextBody(text: post.title),
          PostHashtags(tags: post.tags),
          if (post.imageUrl != null) PostImage(url: post.imageUrl!),
          PostStats(likes: post.likes, commentsCount: post.commentsCount),
          PostActions(
            postId: post.id,
            likes: post.likes,
          ),
        ],
      ),
    );
  }
}
