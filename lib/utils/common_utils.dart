import 'dart:io';

import 'package:cron/cron.dart';
import 'package:eye_20_20/services/android_screen_state.dart';
import 'package:eye_20_20/services/android_screen_time.dart';
import 'package:eye_20_20/services/desktop_screen_state.dart';
import 'package:eye_20_20/services/desktop_screen_time.dart';
import 'package:eye_20_20/services/ios_screen_state.dart';
import 'package:eye_20_20/services/ios_screen_time.dart';
import 'package:eye_20_20/services/screen_state_interface.dart';
import 'package:eye_20_20/services/screen_time_Interface.dart';
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

  static Schedule cronStringFromTime(TimeOfDay time) {
    return Schedule.parse('0 m h * * *'
        .replaceFirst("h", time.hour.toString())
        .replaceFirst("m", time.minute.toString()));
  }
}
