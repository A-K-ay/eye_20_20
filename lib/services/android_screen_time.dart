import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:eye_20_20/services/local_notification.dart';
import 'package:flutter/foundation.dart';
import './screen_time_Interface.dart';
import 'package:screen_state/screen_state.dart';

class AndroidScreenTime extends ScreenTimeInterface {
  late Screen _screen;
  late StreamSubscription ScreenStateSubcription;
  @override
  void init() {
    log("started listning");
    _screen = Screen();
    try {
      ScreenStateSubcription = _screen.screenStateStream!.listen(onData);
    } on ScreenStateException catch (exception) {
      print(exception);
    }
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

  void onData(ScreenStateEvent event) {
    if (!isActive.value) return;
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
    ScreenStateSubcription.pause();
  }

  @override
  void resumeStreams() {
    // TODO: implement resumeStreams
    startStopwatch();
    pollingSubscription.resume();
    ScreenStateSubcription.resume();
  }
}
