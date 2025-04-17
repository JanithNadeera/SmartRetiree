import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: imageUrl,
        width: radius,
        height: radius,
        placeholder: (context, url) => Loader.indicator(size: 10),
        errorWidget: (context, url, error) => const ShaderMaskWrapper(
          child: Icon(
            Icons.broken_image_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
