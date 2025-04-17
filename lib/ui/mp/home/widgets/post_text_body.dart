import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class PostTextBody extends StatelessWidget {
  final String text;
  const PostTextBody({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final urlRegExp = RegExp(
        r'((https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)');

    final spans = <TextSpan>[];

    text.splitMapJoin(
      urlRegExp,
      onMatch: (m) {
        final url = m.group(0)!;
        spans.add(
          TextSpan(
            text: url,
            style: context.bodyMedium.copyWith(color: Colors.blue),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        );
        return '';
      },
      onNonMatch: (nonMatch) {
        spans.add(TextSpan(text: nonMatch, style: context.bodyMedium));
        return '';
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SelectableText.rich(TextSpan(children: spans)),
      ),
    );
  }
}
