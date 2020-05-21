import 'package:cdd_mobile_frontend/common/util/image.dart';
import 'package:flutter/material.dart';

class LoadAssetImage extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final int cacheWidth;
  final int cacheHeight;
  final BoxFit fit;
  final String format;
  final Color color;

  const LoadAssetImage(
    this.image, {
    Key key,
    this.width,
    this.height,
    this.cacheWidth,
    this.cacheHeight,
    this.fit,
    this.format = 'png',
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      CddImageUtil.getImagePath(image, format: format),
      height: height,
      width: width,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      fit: fit,
      color: color,
    );
  }
}
