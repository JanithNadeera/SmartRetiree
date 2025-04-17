import 'package:flutter/material.dart';
import 'package:smart_retiree/utils/image_from_url.dart';

class PostImage extends StatelessWidget {
  final String url;
  const PostImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return ImageFromUrl.show(url, radius: 0, ratio: 1.4);
  }
}
