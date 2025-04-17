import 'package:flutter/material.dart';
import 'package:smart_retiree/models/post_user.dart';
import 'package:smart_retiree/ui/mp/chat_room/widgets/user_avatar.dart';
import 'package:smart_retiree/utils/string_extension.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class PostHeader extends StatelessWidget {
  final PostUser user;
  final DateTime createdAt;
  const PostHeader({
    super.key,
    required this.user,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserAvatar(
              imageUrl: user.profilePhoto,
              radius: 55,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    user.occupation,
                    style: context.bodySmall.copyWith(
                      color: context.bodySmall.color?.withAlpha(200),
                    ),
                  ),
                  Text(
                    createdAt.timeAgo,
                    style: context.bodySmall.copyWith(
                      color: context.bodySmall.color?.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {},
                child: const Icon(Icons.more_horiz_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
