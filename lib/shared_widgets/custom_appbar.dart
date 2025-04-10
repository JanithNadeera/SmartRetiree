import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_retiree/shared_widgets/shader_mask_wrapper.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.withShader = false,
    this.actions,
  });

  final String title;
  final List<Widget>? actions;
  final bool withShader;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: context.surface,
      centerTitle: !withShader,
      title: withShader
          ? Align(
              alignment: Alignment.centerLeft,
              child: ShaderMaskWrapper(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: 1.2,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Text(
              title,
              style: context.headlineMedium,
            ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
