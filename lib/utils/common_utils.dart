import 'dart:io';

import 'package:cron/cron.dart';
import 'package:eyecareplus/services/android_screen_state.dart';
import 'package:eyecareplus/services/desktop_screen_state.dart';
import 'package:eyecareplus/services/ios_screen_state.dart';
import 'package:eyecareplus/services/screen_state_interface.dart';
import 'package:flutter/material.dart';

class CommonUtils {
  static ScreenStateInterface getScreenTime() {
    if (Platform.isAndroid) {
      return AndroidScreenState();
    } else if (Platform.isIOS) {
      return IosScreenState();
    } else {
      return DesktopScreenState();
    }
  }

  static isWindows() {
    if (Platform.isWindows) {
      return true;
    }
  }

  static Schedule cronStringFromTime(TimeOfDay time) {
    return Schedule.parse('0 m h * * *'
        .replaceFirst("h", time.hour.toString())
        .replaceFirst("m", time.minute.toString()));
  }
}
