import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3670266448317627/5517922542';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3670266448317627/3396862524';
    }
    throw UnsupportedError("Unsupported platform");
  }
}
