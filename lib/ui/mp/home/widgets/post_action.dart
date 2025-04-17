import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:smart_retiree/providers/user_provider.dart';
import 'package:smart_retiree/ui/mp/home/widgets/action_button.dart';
import 'package:smart_retiree/ui/mp/home/widgets/comment_bottom_sheet.dart';
import 'package:smart_retiree/utils/core_utils.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class PostActions extends ConsumerStatefulWidget {
  final String postId;
  final List<String> likes;
  const PostActions({
    super.key,
    required this.postId,
    required this.likes,
  });

  @override
  ConsumerState<PostActions> createState() => _PostActionsState();
}

class _PostActionsState extends ConsumerState<PostActions> {
  final isLike = ValueNotifier<bool>(false);
  @override
  void initState() {
    isLike.value =
        (widget.likes.any((userId) => userId == ref.read(userProvider)!.uid));
    super.initState();
  }

  _postLike() async {
    try {
      final userId = ref.read(userProvider)!.uid;
      final updatedLikes = [...widget.likes, userId];

      await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .update({
        'likes': updatedLikes,
      });

      isLike.value = true;
    } catch (e) {
      log('Error liking post: $e');
    }
  }

  _postUnlike() async {
    try {
      final userId = ref.read(userProvider)!.uid;
      final updatedLikes = widget.likes.where((id) => id != userId).toList();

      await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .update({
        'likes': updatedLikes,
      });

      isLike.value = false;
    } catch (e) {
      log('Error unliking post: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: isLike,
              builder: (context, value, _) {
                return ActionButton(
                  icon: value
                      ? MingCuteIcons.mgc_heart_fill
                      : MingCuteIcons.mgc_heart_line,
                  label: "Like",
                  color: value ? context.primary : null,
                  onTap: () {
                    if (value) {
                      _postUnlike();
                    } else {
                      _postLike();
                    }
                  },
                );
              },
            ),
          ),
          Expanded(
            child: ActionButton(
              icon: MingCuteIcons.mgc_comment_2_line,
              label: "Comment",
              onTap: () {
                CoreUtils.showBottomSheet(
                  CommentsBottomSheet(postId: widget.postId),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
