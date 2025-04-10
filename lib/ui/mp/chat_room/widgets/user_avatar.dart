import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 16,
  });

  final String imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: Colors.red[300],
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}
