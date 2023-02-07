// import 'dart:async';
// import 'dart:developer';

// import 'package:cron/cron.dart';
// import 'package:eye_20_20/utils/common_utils.dart';
// import 'package:eye_20_20/utils/shared_prefrences_utils.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:time_range_picker/time_range_picker.dart';

// import 'local_notification.dart';

// abstract class ScreenTimeInterface {
//   Stopwatch stopwatch = Stopwatch();
//   late ValueNotifier<Duration> stopwatchListener = ValueNotifier(Duration.zero);
//   int screenOnTime = 20;
//   Stream pollingStream = Stream.periodic(Duration(seconds: 1));
//   late StreamSubscription pollingSubscription;
//   late LocalNotificationService localNotificationService =
//       LocalNotificationService();
//   ValueNotifier<bool> isActive = ValueNotifier(false);
//   bool isScheduleActive = false;
//   TimeRange? scheduleRange;
//   Cron cron = Cron();
//   SharedPrefrencesUtils sharedPrefrencesUtils = SharedPrefrencesUtils();

//   Future commonInit() async {
//     log("started listning");
//     await readSharedPrefrences();
//     await localNotificationService.intialize();
//     await activateSchedule();
//     startTimer();
//     if (!isActive.value) {
//       deactivate();
//     }
//   }

//   Duration get screenOnTimeAsDuration => Duration(minutes: screenOnTime);

//   readSharedPrefrences() async {
//     await sharedPrefrencesUtils.init();
//     isActive.value = sharedPrefrencesUtils.isTimerActive;
//     isScheduleActive = sharedPrefrencesUtils.isScheduleActivated;
//     scheduleRange = sharedPrefrencesUtils.schedule;
//     screenOnTime = sharedPrefrencesUtils.screenOnTime;
//   }

//   Future initSchedule() async {
//     if (scheduleRange != null && isScheduleActive) {
//       cron = Cron();
//       cron.schedule(CommonUtils.cronStringFromTime(scheduleRange!.startTime),
//           () async {
//         await activate();
//       });
//       cron.schedule(CommonUtils.cronStringFromTime(scheduleRange!.endTime),
//           () async {
//         await deactivate();
//       });
//     }
//   }

//   Future deactivateSchedule() async {
//     isScheduleActive = false;
//     await sharedPrefrencesUtils.setIsScheduleActivated(false);
//     cron.close();
//   }

//   Future activateSchedule() async {
//     isScheduleActive = true;
//     await sharedPrefrencesUtils.setIsScheduleActivated(true);
//     await initSchedule();
//   }

//   Future setSchedule(TimeRange timeRange) async {
//     await sharedPrefrencesUtils.setSchedule(timeRange);
//   }

//   Future setScreenOnTime(int minutes) async {
//     screenOnTime = minutes;
//     await sharedPrefrencesUtils.setScreenOnTime(minutes);
//   }

//   Future sendNotification() async {
//     stopwatch.reset();
//     await localNotificationService.showNotification(
//         title: sharedPrefrencesUtils.notificationTitle,
//         id: DateTime.now().second,
//         body: sharedPrefrencesUtils.notificationDescription);
//     log("Notification Sent");
//   }

//   Future saveNotificationContent(String title, String description) async {
//     await sharedPrefrencesUtils.setNotificationTitle(title);
//     await sharedPrefrencesUtils.setNotificationDescription(description);
//   }

//   void stopStopwatch() {
//     stopwatch.reset();
//     stopwatch.stop();
//     stopwatchListener.value = stopwatch.elapsed;
//   }

//   void startStopwatch() {
//     stopwatch.start();
//     stopwatchListener.value = stopwatch.elapsed;
//   }

//   bool get isStopwatchRunning => stopwatch.isRunning;
//   Future deactivate() async {
//     isActive.value = false;
//     pauseStreams();
//     await sharedPrefrencesUtils.setIsTimerActive(isActive.value);
//   }

//   Future activate() async {
//     isActive.value = true;
//     resumeStreams();
//     await sharedPrefrencesUtils.setIsTimerActive(isActive.value);
//   }

//   Future toggleTimer() async {
//     if (isActive.value) {
//       await deactivate();
//     } else {
//       await activate();
//     }
//     await sharedPrefrencesUtils.setIsTimerActive(isActive.value);
//   }

//   void resumeStreams();
//   Future init();
//   void startTimer();
//   void stopTimer();
//   void pauseStreams();
// }
