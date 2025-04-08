import 'package:flutter/material.dart';
import 'package:smart_retiree/ui/mp/home/widgets/comment_input_field.dart';
import 'package:smart_retiree/ui/mp/home/widgets/comment_tile.dart';
import 'package:smart_retiree/ui/mp/home/widgets/comments_empty.dart';
import 'package:smart_retiree/ui/mp/home/widgets/sheet_handler.dart';

class CommentsBottomSheet extends StatefulWidget {
  const CommentsBottomSheet({super.key});

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final List<CommentModel> comments = [
    CommentModel(
        name: "Jordan Silva",
        message: "Happy work anniversary!!! 🎉",
        pic: "Avatar.png"),
    CommentModel(
        name: "Jamie Anderson",
        message: "Happy work anniversary Deepak Anderson",
        pic: "Avatar2.png"),
    CommentModel(
        name: "Bessie Cooper",
        message:
            "It is very much joyful to work with you all these years. Happy Work Anniversary!!!",
        pic: "Avatar3.png"),
  ];

  final TextEditingController _controller = TextEditingController();

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
              if (comments.isNotEmpty)
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    itemCount: comments.length,
                    itemBuilder: (_, i) => CommentTile(comment: comments[i]),
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                  ),
                )
              else
                const CommentsEmpty(),
              const Divider(color: Color(0xFFDFE2E6), thickness: 1),
              CommentInputField(
                  controller: _controller,
                  onSend: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      setState(() {
                        comments.add(CommentModel(
                            name: "You", message: text, pic: "Avatar.png"));
                      });
                      _controller.clear();
                    }
                  }),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentModel {
  final String name;
  final String message;
  final String pic;

  CommentModel({required this.name, required this.message, required this.pic});
}
