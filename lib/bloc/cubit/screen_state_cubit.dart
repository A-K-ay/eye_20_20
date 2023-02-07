import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cron/cron.dart';
import 'package:eye_20_20/constants/screen_state_enum.dart';
import 'package:eye_20_20/models/Screen_controller_state_model.dart';
import 'package:eye_20_20/services/local_notification.dart';
import 'package:eye_20_20/services/screen_state_interface.dart';
import 'package:eye_20_20/services/screen_time_interface.dart';
import 'package:eye_20_20/utils/common_utils.dart';
import 'package:eye_20_20/utils/shared_prefrences_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:time_range_picker/time_range_picker.dart';

part 'screen_state_state.dart';

class ScreenControllerCubit extends Cubit<ScreenController> {
  ScreenControllerCubit(this.screenStateInterface)
      : super(ScreenStatePaused(ScreenControllerStateModel(
            isActive: false,
            elapsedTime: Duration.zero,
            screenOnTime: 20,
            isPaused: true)));

  ScreenStateInterface screenStateInterface;
  Stopwatch stopwatch = Stopwatch();
  int screenOnTime = 20;
  final Stream pollingStream = Stream.periodic(const Duration(seconds: 1));
  late bool isScheduleActive = false;
  bool isPaused = false;
  TimeRange? scheduleRange;
  Cron cron = Cron();

  late StreamSubscription pollingSubscription;
  late bool isActive = false;
  SharedPreferencesUtils sharedPreferencesUtils = SharedPreferencesUtils();
  late LocalNotificationService localNotificationService =
      LocalNotificationService();

  Duration get screenOnTimeAsDuration => Duration(minutes: screenOnTime);
  bool get isStopwatchRunning => stopwatch.isRunning;
  Future init() async {
    log("started listening");
    await readSharedPreferences();
    await localNotificationService.initialize();
    if (isScheduleActive) {
      await activateSchedule();
    }
    initTimer();
    if (!isActive) {
      deactivate();
    }
  }

  void setScreenStateListener() async {
    await screenStateInterface.init();
    screenStateInterface.screenStateChanged.addListener(() {
      if (isActive) {
        switch (screenStateInterface.screenStateChanged.value) {
          case ScreenStateType.opened:
            resume();
            break;
          case ScreenStateType.closed:
            pause();
            break;
        }
      }
      // TODO: pause or resume based on the incomming screen state.
    });
  }

  void initTimer() {
    startStopwatch();
    pollingSubscription = pollingStream.listen(((event) async {
      emitUpdatedState();

      if (stopwatch.elapsed >= screenOnTimeAsDuration) {
        await sendNotification();
        log("notification sent");
        stopwatch.reset();
      }
    }));
  }

  void emitUpdatedState() {
    emit(ScreenStateRunning(ScreenControllerStateModel(
        isActive: isActive,
        elapsedTime: stopwatch.elapsed,
        screenOnTime: screenOnTime,
        isPaused: isPaused)));
  }

  readSharedPreferences() async {
    await sharedPreferencesUtils.init();
    isActive = sharedPreferencesUtils.isTimerActive;
    isScheduleActive = sharedPreferencesUtils.isScheduleActivated;
    scheduleRange = sharedPreferencesUtils.schedule;
    screenOnTime = sharedPreferencesUtils.screenOnTime;
  }

  Future initSchedule() async {
    if (scheduleRange != null && isScheduleActive) {
      cron = Cron();
      cron.schedule(CommonUtils.cronStringFromTime(scheduleRange!.startTime),
          () async {
        await activate();
      });
      cron.schedule(CommonUtils.cronStringFromTime(scheduleRange!.endTime),
          () async {
        await deactivate();
      });
    }
  }

  Future deactivateSchedule() async {
    isScheduleActive = false;
    await sharedPreferencesUtils.setIsScheduleActivated(false);
    cron.close();
  }

  Future activateSchedule() async {
    isScheduleActive = true;
    await sharedPreferencesUtils.setIsScheduleActivated(true);
    await initSchedule();
  }

  Future setSchedule(TimeRange timeRange) async {
    await sharedPreferencesUtils.setSchedule(timeRange);
  }

  Future setScreenOnTime(int minutes) async {
    screenOnTime = minutes;
    await sharedPreferencesUtils.setScreenOnTime(minutes);
  }

  Future sendNotification() async {
    stopwatch.reset();
    await localNotificationService.showNotification(
        title: sharedPreferencesUtils.notificationTitle,
        id: DateTime.now().second,
        body: sharedPreferencesUtils.notificationDescription);
    log("Notification Sent");
  }

  void stopStopwatch() {
    stopwatch.reset();
    stopwatch.stop();
    emitUpdatedState();
  }

  void startStopwatch() {
    stopwatch.start();
    emitUpdatedState();
  }

  Future deactivate() async {
    isActive = false;
    pause();
    await sharedPreferencesUtils.setIsTimerActive(isActive);
  }

  Future activate() async {
    isActive = true;
    resume();
    await sharedPreferencesUtils.setIsTimerActive(isActive);
  }

  Future toggleTimer() async {
    if (isActive) {
      await deactivate();
    } else {
      await activate();
    }
    await sharedPreferencesUtils.setIsTimerActive(isActive);
  }

  void pause() {
    stopStopwatch();
    pollingSubscription.pause();
    isPaused = true;
    emitUpdatedState();
  }

  void resume() {
    startStopwatch();
    pollingSubscription.resume();
    isPaused = false;
    emitUpdatedState();
  }
}
