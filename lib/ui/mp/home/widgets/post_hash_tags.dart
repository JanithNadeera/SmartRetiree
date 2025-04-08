import 'package:flutter/material.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class PostHashtags extends StatelessWidget {
  const PostHashtags({super.key});

  @override
  Widget build(BuildContext context) {
    const tags = [
      "reliable",
      "resourceful",
      "workAnniversary",
      "teamWork",
      "workPlace",
      "thankYou"
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 8,
          children: tags
              .map(
                (tag) => Text(
                  "#$tag",
                  style: context.bodyMedium.copyWith(color: Colors.blue),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
