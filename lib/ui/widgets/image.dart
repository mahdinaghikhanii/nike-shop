import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageLoadingService extends StatelessWidget {
  final String imgUrl;
  final BorderRadius? borderRadius;

  const ImageLoadingService(
      {super.key, required this.imgUrl, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
          imageUrl: imgUrl,
          fit: BoxFit.cover,
        ));
  }
}
