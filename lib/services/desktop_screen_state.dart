import 'dart:developer';

import 'package:eye_20_20/constants/screen_state_enum.dart';
import 'package:eye_20_20/services/screen_state_interface.dart';
import 'package:eye_20_20/services/screen_time_Interface.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:flutter_desktop_sleep/flutter_desktop_sleep.dart';

class DesktopScreenState implements ScreenStateInterface {
  FlutterDesktopSleep flutterDesktopSleep = FlutterDesktopSleep();

  @override
  ValueNotifier<ScreenStateType> screenStateChanged =
      ValueNotifier(ScreenStateType.closed);

  @override
  Future<void> init() async {
    flutterDesktopSleep.setWindowSleepHandler((String? s) async {
      log('Desktop Sleep State: $s');
      s != null ? onData(s) : null;
    });
  }

  void onData(String s) {
    log(s);
    if (s == "woke_up") {
      screenStateChanged.value = ScreenStateType.opened;
    } else if (s == "sleep") {
      screenStateChanged.value = ScreenStateType.closed;
    } else if (s == "terminate_app") {
      flutterDesktopSleep.terminateApp();
    }
  }
}
