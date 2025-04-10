import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:smart_retiree/shared_widgets/shader_mask_wrapper.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class EventAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onPressed;
  const EventAppBar({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: context.surface,
      title: Align(
        alignment: Alignment.centerLeft,
        child: ShaderMaskWrapper(
          child: Text(
            "Upcoming Events",
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
            onPressed?.call();

            print("UPLOAD EVENT");
          },
          icon: const ShaderMaskWrapper(
            child: Icon(
              MingCuteIcons.mgc_add_circle_line,
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
