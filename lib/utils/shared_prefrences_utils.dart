import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_range_picker/time_range_picker.dart';

class SharedPrefrencesUtils {
  late SharedPreferences _prefs;
  String prefsKeyIsTimerActivated = "eye2020/isTimerActivated";
  String prefsKeyIsScheduleActivated = "eye2020/isTimerActivated";
  String prefsKeySchedule = "eye2020/schedule";
  String prefsKeyScreenOnTime = "eye2020/screenOnTime";
  String prefsKeynotificationDescription = "eye2020/notificationDescription";
  String prefsKeynotificationTitle = "eye2020/notificationTitle";

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isTimerActive {
    return _prefs.getBool(prefsKeyIsTimerActivated) ?? false;
  }

  Future setIsTimerActive(bool data) {
    return _prefs.setBool(prefsKeyIsTimerActivated, data);
  }

  bool get isScheduleActivated {
    return _prefs.getBool(prefsKeyIsTimerActivated) ?? false;
  }

  Future setIsScheduleActivated(bool data) {
    return _prefs.setBool(prefsKeyIsScheduleActivated, data);
  }

  TimeRange? get schedule {
    List<String>? scheduleStringList = _prefs.getStringList(prefsKeySchedule);
    if (scheduleStringList?.isNotEmpty ?? false) {
      return TimeRange(
          startTime:
              TimeOfDay.fromDateTime(DateTime.parse(scheduleStringList![0])),
          endTime:
              TimeOfDay.fromDateTime(DateTime.parse(scheduleStringList[1])));
    } else
      return null;
  }

  Future setSchedule(TimeRange timeRange) {
    return _prefs.setStringList(prefsKeySchedule, [
      DateTime(2000, 1, 1, timeRange.startTime.hour, timeRange.startTime.minute)
          .toString(),
      DateTime(2000, 1, 1, timeRange.endTime.hour, timeRange.endTime.minute)
          .toString()
    ]);
  }

  Future setScreenOnTime(int data) {
    return _prefs.setInt(prefsKeyScreenOnTime, data);
  }

  int get screenOnTime {
    return _prefs.getInt(prefsKeyScreenOnTime) ?? 20;
  }

  Future setnotificationDescription(String data) {
    return _prefs.setString(prefsKeynotificationDescription, data);
  }

  String get notificationDescription {
    return _prefs.getString(prefsKeyScreenOnTime) ??
        "Give Them a rest for a bit";
  }

  Future setnotificationTitle(String data) {
    return _prefs.setString(prefsKeynotificationTitle, data);
  }

  String get notificationTitle {
    return _prefs.getString(prefsKeynotificationTitle) ??
        "Please Close Your Eyes!";
  }
}
