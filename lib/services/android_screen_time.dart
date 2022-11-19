import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:eye_20_20/services/local_notification.dart';
import 'package:eye_20_20/services/screen_time_Interface.dart';
import 'package:screen_state/screen_state.dart';

class AndroidScreenTime implements ScreenTimeInterface {
  late Screen _screen;
  late StreamSubscription _subscription;
  late Stream _stream = Stream.periodic(Duration(seconds: 1));
  @override
  late Stopwatch stopwatch = Stopwatch();
  late LocalNotificationService localNotificationService;
  late VoidCallback uiUpdateCallback;
  @override
  Duration screenOnTime = const Duration(minutes: 1);
  @override
  void init() {
    log("started listning");
    _screen = Screen();
    try {
      _screen.screenStateStream!.listen(onData);
    } on ScreenStateException catch (exception) {
      print(exception);
    }
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
    uiUpdateCallback();
    _subscription = _stream.listen(((event) async {
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
}
