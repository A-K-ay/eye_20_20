// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:time_range_picker/time_range_picker.dart';

class ScreenControllerStateModel {
  final bool isActive;
  final Duration elapsedTime;
  final int screenOnTime;
  final bool isPaused;
  final TimeRange? scheduleRange;
  final bool isScheduleActive;
  final double screenOnTimesSliderValue;
  ScreenControllerStateModel({
    required this.isActive,
    required this.elapsedTime,
    required this.screenOnTime,
    required this.isPaused,
    required this.scheduleRange,
    required this.isScheduleActive,
    required this.screenOnTimesSliderValue,
  });

  ScreenControllerStateModel copyWith(
      {bool? isActive,
      Duration? elapsedTime,
      int? screenOnTime,
      bool? isPaused,
      TimeRange? scheduleRange,
      bool? isScheduleActive,
      double? screenOnTimesSliderValue}) {
    return ScreenControllerStateModel(
      isActive: isActive ?? this.isActive,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      screenOnTime: screenOnTime ?? this.screenOnTime,
      isPaused: isPaused ?? this.isPaused,
      scheduleRange: scheduleRange ?? this.scheduleRange,
      isScheduleActive: isScheduleActive ?? this.isScheduleActive,
      screenOnTimesSliderValue:
          screenOnTimesSliderValue ?? this.screenOnTimesSliderValue,
    );
  }

  double get screenTimePercentage =>
      elapsedTime.inSeconds / Duration(minutes: screenOnTime).inSeconds;

  bool get showScreenTimeSliderSaveButton =>
      screenOnTimesSliderValue.toInt() != screenOnTime;

  @override
  bool operator ==(covariant ScreenControllerStateModel other) {
    if (identical(this, other)) return true;

    return other.isActive == isActive &&
        other.elapsedTime == elapsedTime &&
        other.screenOnTime == screenOnTime &&
        other.isPaused == isPaused &&
        other.scheduleRange == scheduleRange &&
        other.isScheduleActive == isScheduleActive;
  }

  @override
  int get hashCode {
    return isActive.hashCode ^
        elapsedTime.hashCode ^
        screenOnTime.hashCode ^
        isPaused.hashCode ^
        scheduleRange.hashCode ^
        isScheduleActive.hashCode ^
        screenOnTimesSliderValue.hashCode;
  }
}
