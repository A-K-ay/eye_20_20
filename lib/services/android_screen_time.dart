// import 'dart:async';
// import 'dart:developer';
// import 'dart:ui';

// import 'package:eye_20_20/services/local_notification.dart';
// import 'package:flutter/foundation.dart';
// import './screen_time_Interface.dart';
// import 'package:screen_state/screen_state.dart';

// class AndroidScreenTime extends ScreenTimeInterface {
//   late Screen _screen;
//   late StreamSubscription screenStateSubcription;
//   @override
//   Future init() async {
//     log("started listning");
//     await commonInit();
//     _screen = Screen();
//     try {
//       screenStateSubcription = _screen.screenStateStream!.listen(onData);
//     } on ScreenStateException catch (exception) {
//       print(exception);
//     }
//   }

//   @override
//   void startTimer() {
//     startStopwatch();
//     pollingSubscription = pollingStream.listen(((event) async {
//       stopwatchListener.value = stopwatch.elapsed;

//       if (stopwatch.elapsed >= screenOnTimeAsDuration) {
//         await sendNotification();
//         log("notification sent");
//         stopwatch.reset();
//       }
//     }));
//   }

//   @override
//   void stopTimer() {
//     stopStopwatch();
//     stopwatchListener.value = stopwatch.elapsed;
//     pauseStreams();
//   }

//   void onData(ScreenStateEvent event) {
//     if (!isActive.value) return;
//     log(event.name);
//     if (event == ScreenStateEvent.SCREEN_OFF) {
//       stopTimer();
//     } else if (event == ScreenStateEvent.SCREEN_ON ||
//         event == ScreenStateEvent.SCREEN_UNLOCKED) {
//       startTimer();
//     }
//   }

//   @override
//   // TODO: implement isRunning
//   bool get isRunning => stopwatch.isRunning;

//   @override
//   void pauseStreams() {
//     // TODO: implement pauseStreams
//     stopStopwatch();
//     pollingSubscription.pause();
//     screenStateSubcription.pause();
//   }

//   @override
//   void resumeStreams() {
//     // TODO: implement resumeStreams
//     startStopwatch();
//     pollingSubscription.resume();
//     screenStateSubcription.resume();
//   }
// }
