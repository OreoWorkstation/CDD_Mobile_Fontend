import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class CddImageUtil {
  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static ImageProvider getAssetImage(String name, {String format = 'png'}) {
    return AssetImage(getImagePath(name, format: format));
  }

  static ImageProvider getImageProvider(String imageUrl, {String holderImage = "none"}) {
    if (TextUtil.isEmpty(imageUrl)) {
      return AssetImage(getImagePath(holderImage));
    }
    return CachedNetworkImageProvider(imageUrl);
  }
}