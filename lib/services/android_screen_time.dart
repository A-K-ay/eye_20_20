import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:eye_20_20/services/local_notification.dart';
import 'package:flutter/foundation.dart';
import './screen_time_Interface.dart';
import 'package:screen_state/screen_state.dart';

class AndroidScreenTime extends ScreenTimeInterface {
  late Screen _screen;
  late LocalNotificationService localNotificationService;
  @override
  void init() {
    log("started listning");
    _screen = Screen();
    try {
      _screen.screenStateStream!.listen(onData);
    } on ScreenStateException catch (exception) {
      print(exception);
    }
    startTimer();
  }

  @override
  void startTimer() {
    stopwatch.reset();
    stopwatch.start();
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
    stopwatch.reset();
    stopwatch.stop();
  }

  void onData(ScreenStateEvent event) {
    if(!isActive.value) return;
    log(event.name);
    if (event == ScreenStateEvent.SCREEN_OFF) {
      stopTimer();
    } else if (event == ScreenStateEvent.SCREEN_ON ||
        event == ScreenStateEvent.SCREEN_UNLOCKED) {
      startTimer();
    }
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
  void pauseStreams() {
    // TODO: implement pauseStreams
    pollingSubscription.pause();
  }
  
  @override
  void resumeStreams() {
    // TODO: implement resumeStreams
    pollingSubscription.resume();
  }
}
