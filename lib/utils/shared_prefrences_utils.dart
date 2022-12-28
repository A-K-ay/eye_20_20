import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_range_picker/time_range_picker.dart';

class SharedPrefrencesUtils {
  late SharedPreferences _prefs;
  String prefsKeyIsTimerActivated = "eye2020/isTimerActivated";
  String prefsKeyIsScheduleActivated = "eye2020/isTimerActivated";
  String prefsKeySchedule = "eye2020/schedule";

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
}
