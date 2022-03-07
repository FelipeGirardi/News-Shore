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
    if (imageUrl != null && imageUrl.isNotEmpty) {
      Image image = Image.network(imageUrl);
      ImageInfo info = await getImageInfo(image);
      if (info.image.width <= 150 || info.image.height <= 150) {
        return false;
      }
      return true;
    }
    return false;
  }
}
