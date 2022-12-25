import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:eye_20_20/services/local_notification.dart';
import './screen_time_Interface.dart';
import 'package:flutter_desktop_sleep/flutter_desktop_sleep.dart';
import 'package:screen_state/screen_state.dart';

class DesktopScreenTime extends ScreenTimeInterface {
  FlutterDesktopSleep flutterDesktopSleep = FlutterDesktopSleep();

  @override
  Future init() async {
    log("started listning");
    await localNotificationService.intialize();

    flutterDesktopSleep.setWindowSleepHandler((String? s) async {
      log('Desktop Sleep State: $s');
      s != null ? onData(s) : null;
    });
    startTimer();
  }

  @override
  void startTimer() {
    startStopwatch();
    pollingSubscription = pollingStream.listen(((event) async {
      stopwatchListner.value = stopwatch.elapsed;
      if (stopwatch.elapsed >= screenOnTime) {
        await sendNotification();
        log("notification sent");
        stopwatch.reset();
      }
    }));
  }

  @override
  void stopTimer() {
    stopStopwatch();
    stopwatchListner.value = stopwatch.elapsed;
    pauseStreams();
  }

  void onData(String s) {
    log(s);
    if (!isActive.value) return;
    if (s == "woke_up") {
      startTimer();
    } else if (s == "sleep") {
      stopTimer();
    } else if (s == "terminate_app") {
      flutterDesktopSleep.terminateApp();
    }
  }

  @override
  // TODO: implement isRunning
  bool get isRunning => stopwatch.isRunning;

  @override
  void toggleTimer() {
    if (isActive.value) {
      isActive.value = false;
      pauseStreams();
    } else {
      isActive.value = true;
      resumeStreams();
    }
  }

  @override
  void pauseStreams() {
    // TODO: implement pauseStreams
    stopStopwatch();
    pollingSubscription.pause();
  }

  @override
  void resumeStreams() {
    // TODO: implement resumeStreams
    startStopwatch();
    pollingSubscription.resume();
  }
}
