import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:smart_retiree/shared_widgets/shader_mask_wrapper.dart';
import 'package:smart_retiree/utils/loader.dart';

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
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => Loader.indicator(size: 10),
        errorWidget: (context, url, error) => const ShaderMaskWrapper(
          child: Icon(
            MingCuteIcons.mgc_file_forbid_line,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
