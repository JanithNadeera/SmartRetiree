import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:smart_retiree/ui/mp/home/widgets/action_button.dart';
import 'package:smart_retiree/ui/mp/home/widgets/comment_bottom_sheet.dart';
import 'package:smart_retiree/utils/core_utils.dart';

class PostActions extends StatelessWidget {
  const PostActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: ActionButton(
              icon: MingCuteIcons.mgc_heart_line,
              label: "Like",
              onTap: () {},
            ),
          ),
          Expanded(
            child: ActionButton(
              icon: MingCuteIcons.mgc_comment_2_line,
              label: "Comment",
              onTap: () {
                CoreUtils.showBottomSheet(const CommentsBottomSheet());
              },
            ),
          ),
        ],
      ),
    );
  }
}
