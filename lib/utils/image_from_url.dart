import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smart_retiree/widgets/shader_mask_wrapper.dart';
import 'package:smart_retiree/utils/loader.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class ImageFromUrl {
  static Widget show(String url,
      {double radius = 16, double iconSize = 40, double ratio = 1.4}) {
    return AspectRatio(
      aspectRatio: ratio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: url,
          width: radius,
          height: radius,
          placeholder: (context, url) => Loader.indicator(
            color: context.primary,
            size: iconSize,
          ),
          errorWidget: (context, url, error) => ShaderMaskWrapper(
            child: Icon(
              Icons.broken_image_outlined,
              size: iconSize,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
