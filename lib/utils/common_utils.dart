import 'dart:io';

import 'package:eye_20_20/services/android_screen_time.dart';
import 'package:eye_20_20/services/desktop_screen_time.dart';
import 'package:eye_20_20/services/ios_screen_time.dart';
import 'package:eye_20_20/services/screen_time_Interface.dart';

class CommonUtils {
 static ScreenTimeInterface getScreenTime() {
    if (Platform.isAndroid) {
      return AndroidScreenTime();
    } else if (Platform.isIOS) {
      return IosScreenTime();
    } else {
      return DesktopScreenTime();
    }
  }
}
