import 'dart:async';
import 'dart:developer';
import 'dart:io' show Platform;

import 'package:eye_20_20/services/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop_sleep/flutter_desktop_sleep.dart';
import 'package:screen_state/screen_state.dart';


class ScreenLockHandler {
  late LocalNotificationService localNotificationService;
  late Stopwatch stopwatch = Stopwatch();
  FlutterDesktopSleep flutterDesktopSleep = FlutterDesktopSleep();
  late  Screen _screen;
  late StreamSubscription _subscription;
  Duration screenOnTime = Duration(seconds: 5);

  init() {
    if (Platform.isAndroid) {
      handleAndroid();
    } else if (Platform.isIOS) {
      handleIos();
    } else {
      handleDesktop();
    }
  }

  handleIos() {

  }
  handleDesktop() {
          flutterDesktopSleep.setWindowSleepHandler((String? s) async {
      log('dsfsadf $s');
    });
  }
  handleAndroid() {
    startListeningAndroid();
  }


  void startTimer(){
  stopwatch.reset();
  stopwatch.start();
  Timer.periodic(Duration(seconds: 1), (timer)async{
    if(stopwatch.elapsed>= screenOnTime){
      await LocalNotificationService().showNotification(title: "Please Close Your Eyes",id: DateTime.now().second,body: "Close Your Eyes!!");
      log("notification sent");
      stopwatch.reset();
    }
  });
}
void stopTimer(){
  stopwatch.reset();
  stopwatch.stop();
}
void onData(ScreenStateEvent event) {
    log(event.name);
    if(event == ScreenStateEvent.SCREEN_OFF){
      stopTimer();
    }else if (event == ScreenStateEvent.SCREEN_ON || event == ScreenStateEvent.SCREEN_UNLOCKED ){
      startTimer();
    }
}

void startListeningAndroid(){
  print("started listning");
    _screen = new Screen();
    try {
      _subscription = _screen.screenStateStream!.listen(onData);
    } on ScreenStateException catch (exception) {
      print(exception);
    }
}

}
