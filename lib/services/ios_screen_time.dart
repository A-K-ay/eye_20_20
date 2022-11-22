import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:eye_20_20/services/local_notification.dart';
import './screen_time_Interface.dart';
import 'package:is_lock_screen/is_lock_screen.dart';
import 'package:screen_state/screen_state.dart';

class IosScreenTime extends ScreenTimeInterface {
  late StreamSubscription _subscription;
  late Stream _stream = Stream.periodic(Duration(seconds: 1));
  late LocalNotificationService localNotificationService;
  late VoidCallback uiUpdateCallback;
  bool isLocked = true;
  @override
  void init() {
    log("started listning");
    lockScreenPoll();
  }

  @override
  Future sendNotification() async {
    await LocalNotificationService().showNotification(
        title: "Please Close Your Eyes",
        id: DateTime.now().second,
        body: "Close Your Eyes!!");
  }

  @override
  void startTimer() async {
    stopwatch.reset();
    stopwatch.start();
    uiUpdateCallback();
    _subscription = _stream.listen(((event) async {
      await lockScreenPoll();
      uiUpdateCallback();
      if (stopwatch.elapsed >= screenOnTime) {
        await sendNotification();
        log("notification sent");
        stopwatch.reset();
      }
    }));
  }

  Future lockScreenPoll() async {
    isLocked = await isLockScreen() ?? true;
    if (isLocked) {
      stopTimer();
    } else {
      startTimer();
    }
  }

  @override
  void stopTimer() {
    stopwatch.reset();
    stopwatch.stop();
    uiUpdateCallback();
  }

  void onData(ScreenStateEvent event) {
    log(event.name);
    if (event == ScreenStateEvent.SCREEN_OFF) {
      stopTimer();
    } else if (event == ScreenStateEvent.SCREEN_ON ||
        event == ScreenStateEvent.SCREEN_UNLOCKED) {
      startTimer();
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
  
  @override
  void pauseStreams() {
    // TODO: implement pauseStreams
  }
  
  @override
  void resumeStreams() {
    // TODO: implement resumeStreams
  }
}
