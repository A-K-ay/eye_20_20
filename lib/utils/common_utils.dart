import 'dart:io';

import 'package:cron/cron.dart';
import 'package:eye_20_20/services/android_screen_time.dart';
import 'package:eye_20_20/services/desktop_screen_time.dart';
import 'package:eye_20_20/services/ios_screen_time.dart';
import 'package:eye_20_20/services/screen_time_Interface.dart';
import 'package:flutter/material.dart';

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

  static Schedule cronStringFromTime(TimeOfDay time) {
    return Schedule.parse('0 m h * * *'
        .replaceFirst("h", time.hour.toString())
        .replaceFirst("m", time.minute.toString()));
  }
}
