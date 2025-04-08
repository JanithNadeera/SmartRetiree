import 'package:flutter/material.dart';

class PostImage extends StatelessWidget {
  const PostImage({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: Image.asset(
        "assets/images/profile.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}
