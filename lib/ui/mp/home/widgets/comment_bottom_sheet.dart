import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_retiree/models/post_comment.dart';
import 'package:smart_retiree/models/post_user.dart';
import 'package:smart_retiree/providers/user_provider.dart';
import 'package:smart_retiree/ui/mp/home/widgets/comment_input_field.dart';
import 'package:smart_retiree/ui/mp/home/widgets/comment_tile.dart';
import 'package:smart_retiree/ui/mp/home/widgets/comments_empty.dart';
import 'package:smart_retiree/ui/mp/home/widgets/sheet_handler.dart';
import 'package:smart_retiree/utils/core_utils.dart';
import 'package:smart_retiree/utils/loader.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class CommentsBottomSheet extends ConsumerStatefulWidget {
  final String postId;
  const CommentsBottomSheet({
    super.key,
    required this.postId,
  });

  @override
  ConsumerState<CommentsBottomSheet> createState() =>
      _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends ConsumerState<CommentsBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Stream<List<PostComment>> _postCommentStream() {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .collection('comments')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PostComment.fromMap(doc.data()))
            .toList());
  }

  _addComment() async {
    if (_controller.text.isNotEmpty) {
      try {
        Loader.show(true);
        final user = ref.read(userProvider)!;

        final newComment = PostComment(
          id: '',
          comment: _controller.text,
          createdAt: DateTime.now(),
          createdBy: PostUser(
            id: user.uid,
            fullName: user.fullName,
            occupation: user.occupation,
            profilePhoto: user.profilePhoto,
          ),
        );

        final postRef =
            FirebaseFirestore.instance.collection('posts').doc(widget.postId);

        await postRef.collection('comments').add(newComment.toMap());

        await postRef.update({
          'commentsCount': FieldValue.increment(1),
        });

        _controller.clear();
      } catch (e) {
        log('Error adding comment: $e');
        CoreUtils.showToast(
          type: ToastType.error,
          message: "Error: ${e.toString()}",
        );
      } finally {
        Loader.show(false);
      }
    } else {
      CoreUtils.showToast(
        type: ToastType.error,
        message: "Please provide something for comment",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SheetHandler(),
              Expanded(
                child: StreamBuilder<List<PostComment>>(
                  stream: _postCommentStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Loader.indicator(color: context.primary);
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const CommentsEmpty();
                    }

                    final comments = snapshot.data ?? [];
                    return ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      itemCount: comments.length,
                      itemBuilder: (_, i) => CommentTile(comment: comments[i]),
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                    );
                  },
                ),
              ),
              const Divider(color: Color(0xFFDFE2E6), thickness: 1),
              CommentInputField(
                controller: _controller,
                onSend: _addComment,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
