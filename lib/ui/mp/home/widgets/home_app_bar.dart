import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:smart_retiree/shared_widgets/shader_mask_wrapper.dart';
import 'package:smart_retiree/ui/mp/home/create_post_screen.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: context.surface,
      title: Align(
        alignment: Alignment.centerLeft,
        child: ShaderMaskWrapper(
          child: Text(
            "Smart Retiree",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const CreatePostScreen()));
          },
          icon: const ShaderMaskWrapper(
            child: Icon(
              MingCuteIcons.mgc_add_circle_line,
              size: 25,
              color: Colors.white,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const ShaderMaskWrapper(
            child: Icon(
              MingCuteIcons.mgc_search_3_line,
              size: 25,
              color: Colors.white,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const ShaderMaskWrapper(
            child: Icon(
              MingCuteIcons.mgc_notification_line,
              size: 25,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
