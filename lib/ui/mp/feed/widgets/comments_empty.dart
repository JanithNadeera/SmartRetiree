import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentsEmpty extends StatelessWidget {
  const CommentsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        SvgPicture.asset(
          "assets/icons/no_comments.svg",
          width: 90,
          height: 90,
        ),
        const SizedBox(height: 10),
        const Text(
          "No comments Yet.",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF505F79),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 5),
        const Text(
          "Be the first one to comment on this",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF7A8699),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
