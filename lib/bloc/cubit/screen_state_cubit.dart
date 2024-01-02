import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cron/cron.dart';
import 'package:eyecareplus/constants/screen_state_enum.dart';
import 'package:eyecareplus/models/Screen_controller_state_model.dart';
import 'package:eyecareplus/services/local_notification.dart';
import 'package:eyecareplus/services/screen_state_interface.dart';
import 'package:eyecareplus/utils/common_utils.dart';
import 'package:eyecareplus/utils/shared_prefrences_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:time_range_picker/time_range_picker.dart';

part 'screen_state_state.dart';

class ScreenControllerCubit extends Cubit<ScreenControllerState> {
  ScreenControllerCubit(this.screenStateInterface)
      : super(ScreenStatePaused(ScreenControllerStateModel(
            isActive: false,
            elapsedTime: Duration.zero,
            screenOnTime: 20,
            isPaused: true,
            scheduleRange: null,
            isScheduleActive: false,
            screenOnTimesSliderValue: 20)));

  ScreenStateInterface screenStateInterface;
  Stopwatch stopwatch = Stopwatch();
  final Stream pollingStream = Stream.periodic(const Duration(seconds: 1));

  Cron cron = Cron();

  late StreamSubscription pollingSubscription;
  SharedPreferencesUtils sharedPreferencesUtils = SharedPreferencesUtils();
  late LocalNotificationService localNotificationService =
      LocalNotificationService();

  Duration get screenOnTimeAsDuration =>
      Duration(minutes: state.stateModel.screenOnTime);
  bool get isStopwatchRunning => stopwatch.isRunning;

  bool get isActive => state.stateModel.isActive;
  Future init() async {
    log("started listening");
    await readSharedPreferences();
    await localNotificationService.initialize();
    if (state.stateModel.isScheduleActive) {
      await activateSchedule();
    }
    setScreenStateListener();
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

  void emitUpdatedState([ScreenControllerStateModel? model]) {
    if (model != null) {
      emit(ScreenStateRunning(model));
    } else {
      emit(ScreenStateRunning(
          state.stateModel.copyWith(elapsedTime: stopwatch.elapsed)));
    }
  }

  readSharedPreferences() async {
    await sharedPreferencesUtils.init();
    emitUpdatedState(ScreenControllerStateModel(
        elapsedTime: stopwatch.elapsed,
        isActive: sharedPreferencesUtils.isTimerActive,
        screenOnTime: sharedPreferencesUtils.screenOnTime,
        isPaused: state.stateModel.isPaused,
        scheduleRange: sharedPreferencesUtils.schedule,
        isScheduleActive: sharedPreferencesUtils.isScheduleActivated,
        screenOnTimesSliderValue:
            sharedPreferencesUtils.screenOnTime.toDouble()));
  }

  Future initSchedule() async {
    if (state.stateModel.scheduleRange != null &&
        state.stateModel.isScheduleActive) {
      cron = Cron();
      cron.schedule(
          CommonUtils.cronStringFromTime(
              state.stateModel.scheduleRange!.startTime), () async {
        await activate();
      });
      cron.schedule(
          CommonUtils.cronStringFromTime(
              state.stateModel.scheduleRange!.endTime), () async {
        await deactivate();
      });
    }
  }

  Future deactivateSchedule() async {
    emitUpdatedState(state.stateModel.copyWith(isScheduleActive: false));
    await sharedPreferencesUtils.setIsScheduleActivated(false);
    cron.close();
  }

  Future activateSchedule() async {
    emitUpdatedState(state.stateModel.copyWith(isScheduleActive: true));
    await sharedPreferencesUtils.setIsScheduleActivated(true);
    await initSchedule();
  }

  Future setSchedule(TimeRange timeRange) async {
    emitUpdatedState(state.stateModel.copyWith(scheduleRange: timeRange));
    await sharedPreferencesUtils.setSchedule(timeRange);
    initSchedule();
  }

  Future setScreenOnTime(int minutes) async {
    emitUpdatedState(state.stateModel.copyWith(screenOnTime: minutes));
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
    stopwatch.stop();
    stopwatch.reset();
    emitUpdatedState();
  }

  void startStopwatch() {
    stopwatch.start();
    emitUpdatedState();
  }

  Future deactivate() async {
    emitUpdatedState(state.stateModel.copyWith(isActive: false));
    pause();
    await sharedPreferencesUtils.setIsTimerActive(false);
  }

  Future activate() async {
    emitUpdatedState(state.stateModel.copyWith(isActive: true));
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
    emitUpdatedState(state.stateModel.copyWith(isPaused: true));
  }

  void resume() {
    startStopwatch();
    pollingSubscription.resume();
    emitUpdatedState(state.stateModel.copyWith(isPaused: false));
  }

  void updateScreenOnTimerSliderValue(double val) {
    emitUpdatedState(state.stateModel.copyWith(screenOnTimesSliderValue: val));
  }

  Future<void> saveNotificationContent(String title, String description) async {
    await sharedPreferencesUtils.setNotificationTitle(title);
    await sharedPreferencesUtils.setNotificationDescription(description);
    sendNotification();
  }
}
