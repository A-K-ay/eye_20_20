import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:eye_20_20/services/local_notification.dart';
import './screen_time_Interface.dart';
import 'package:is_lock_screen/is_lock_screen.dart';
import 'package:screen_state/screen_state.dart';

class IosScreenTime extends ScreenTimeInterface {
  bool isLocked = true;
  @override
  Future init() async {
    log("started listning");
    await localNotificationService.intialize();
    startTimer();
  }

  @override
  void startTimer() async {
    stopwatch.reset();
    stopwatch.start();
    pollingSubscription = pollingStream.listen(((event) async {
      await lockScreenPoll();
      stopwatchListner.value = stopwatch.elapsed;
      if (stopwatch.elapsed >= screenOnTime) {
        await sendNotification();
      }
    }));
  }

  Future lockScreenPoll() async {
    if (!isActive.value) return;
    isLocked = await isLockScreen() ?? true;
    if (isLocked) {
      pauseStreams();
    } else if (isLocked && !isRunning) {
      resumeStreams();
    }
  }

  @override
  void stopTimer() {
    stopStopwatch();
    stopwatchListner.value = stopwatch.elapsed;
    pauseStreams();
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
