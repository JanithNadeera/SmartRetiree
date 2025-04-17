import 'package:flutter/material.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class PostHashtags extends StatelessWidget {
  final List<String> tags;
  const PostHashtags({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
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
