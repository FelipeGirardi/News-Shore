import 'package:flutter/material.dart';
import 'dart:async';

class ImageHelper {
  static Future<ImageInfo> getImageInfo(Image img) async {
    final completer = new Completer<ImageInfo>();
    img.image
        .resolve(new ImageConfiguration())
        .addListener(new ImageStreamListener((ImageInfo imgInfo, bool _) {
      completer.complete(imgInfo);
    }));
    return completer.future;
  }

  static Future<bool> shouldShowImage(String? imageUrl) async {
    bool didLoadImage = true;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      Image image = await Image.network(
        imageUrl,
        errorBuilder: (BuildContext context, Object exception, _) {
          didLoadImage = false;
          return Image.asset('assets/images/newsshore_logo_long.png');
        },
      );
      if (didLoadImage) {
        ImageInfo info = await getImageInfo(image);
        if (info.image.width <= 150 || info.image.height <= 150) {
          return false;
        }
        return true;
      }
      return false;
    }
    return false;
  }
}
