import 'package:flutter/material.dart';
import 'package:smart_retiree/ui/mp/chat_room/widgets/user_avatar.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.url,
    required this.onTap,
  });

  final String url;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      width: 125,
      child: Stack(
        children: [
          UserAvatar(
            imageUrl: url,
            radius: 125,
          ),
          Positioned(
            bottom: 2.5,
            right: 2.5,
            child: GestureDetector(
              onTap: onTap,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: context.primary,
                child: const Icon(
                  Icons.edit,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
