import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'local_notification.dart';

abstract class ScreenTimeInterface {
  Stopwatch stopwatch = Stopwatch();
  late ValueNotifier<Duration> stopwatchListner = ValueNotifier(Duration.zero);
  var screenOnTime = Duration(seconds: 120);
  Stream pollingStream = Stream.periodic(Duration(seconds: 1));
  late StreamSubscription pollingSubscription;
  late LocalNotificationService localNotificationService;
  ValueNotifier<bool> isActive = ValueNotifier(true);

  Future sendNotification() async {
    await LocalNotificationService().showNotification(
        title: "Please Close Your Eyes",
        id: DateTime.now().second,
        body: "Close Your Eyes!!");
    stopwatch.reset();
  }

  void stopStopwatch() {
    stopwatch.reset();
    stopwatch.stop();
    stopwatchListner.value = stopwatch.elapsed;
  }

  void startStopwatch() {
    stopwatch.start();
    stopwatchListner.value = stopwatch.elapsed;
  }

  bool get isStopwatchRunning => stopwatch.isRunning;
  deactivate() {
    isActive.value = false;
    stopStopwatch();
    pauseStreams();
  }

  void activate() {
    isActive.value = true;
    startTimer();
    resumeStreams();
  }

  void resumeStreams();
  void init();
  void startTimer();
  void stopTimer();
  void pauseStreams();
  void toggleTimer();
}
