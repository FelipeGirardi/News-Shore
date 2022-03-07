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
      print(imageUrl +
          '\nWIDTH:' +
          info.image.width.toString() +
          '\nHEIGHT:' +
          info.image.height.toString() +
          '\n----------');
      if (info.image.width <= 100 || info.image.height <= 100) {
        return false;
      }
      return true;
    }
    return false;
  }
}
