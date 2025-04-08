import 'package:flutter/material.dart';
import 'package:smart_retiree/ui/mp/home/widgets/post_action.dart';
import 'package:smart_retiree/ui/mp/home/widgets/post_hash_tags.dart';
import 'package:smart_retiree/ui/mp/home/widgets/post_header.dart';
import 'package:smart_retiree/ui/mp/home/widgets/post_image.dart';
import 'package:smart_retiree/ui/mp/home/widgets/post_stats.dart';
import 'package:smart_retiree/ui/mp/home/widgets/post_text_body.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      color: context.primaryContainer,
      width: double.infinity,
      child: const Column(
        children: [
          PostHeader(),
          PostTextBody(
            text:
                "Great job jump in to help with Penn state charter when you arrived. Appreciated your support 👍",
          ),
          PostHashtags(),
          PostImage(),
          PostStats(),
          PostActions(),
        ],
      ),
    );
  }
}
