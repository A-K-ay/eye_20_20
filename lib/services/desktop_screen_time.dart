import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:eye_20_20/services/local_notification.dart';
import 'package:eye_20_20/services/screen_time_Interface.dart';
import 'package:flutter_desktop_sleep/flutter_desktop_sleep.dart';
import 'package:screen_state/screen_state.dart';

class DesktopScreenTime implements ScreenTimeInterface {
  @override
  late Stopwatch stopwatch = Stopwatch();
  late StreamSubscription _subscription;
  late LocalNotificationService localNotificationService;
  FlutterDesktopSleep flutterDesktopSleep = FlutterDesktopSleep();
  @override
  Duration screenOnTime = const Duration(minutes: 1);
  late Stream _stream = Stream.periodic(Duration(seconds: 1));
  late VoidCallback uiUpdateCallback;

  @override
  void init() {
    log("started listning");
    flutterDesktopSleep.setWindowSleepHandler((String? s) async {
      log('Desktop Sleep State: $s');
      s != null ? onData(s) : null;
    });
  }

  @override
  Future sendNotification() async {
    await LocalNotificationService().showNotification(
        title: "Please Close Your Eyes",
        id: DateTime.now().second,
        body: "Close Your Eyes!!");
  }

  @override
  void startTimer() {
    stopwatch.reset();
    stopwatch.start();
  
    _subscription = _stream.listen(((event) async {
        uiUpdateCallback();
      if (stopwatch.elapsed >= screenOnTime) {
        await sendNotification();
        log("notification sent");
        stopwatch.reset();
      }
    }));
  }

  @override
  void stopTimer() {
    stopwatch.reset();
    stopwatch.stop();
    uiUpdateCallback();
  }

  void onData(String s) {
    log(s);
    if (s == "woke_up") {
      startTimer();
    } else if (s == "sleep") {
      stopTimer();
    } else if (s == "terminate_app") {
      flutterDesktopSleep.terminateApp();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _subscription.cancel();
  }

  @override
  // TODO: implement isRunning
  bool get isRunning => stopwatch.isRunning;

  @override
  void toggleTimer() {
    if (isRunning) {
      stopTimer();
    } else {
      startTimer();
    }
  }

  @override
  void setRefreshUiCallback(VoidCallback uiCallback) {
    // TODO: implement refreshUiCallback
    uiUpdateCallback = uiCallback;
  }
}
