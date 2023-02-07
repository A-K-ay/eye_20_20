// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:time_range_picker/time_range_picker.dart';

class ScreenControllerStateModel {
  final bool isActive;
  final Duration elapsedTime;
  final int screenOnTime;
  bool isPaused = false;
  TimeRange? scheduleRange;
  ScreenControllerStateModel({
    required this.isActive,
    required this.elapsedTime,
    required this.screenOnTime,
    required this.isPaused,
    this.scheduleRange,
  });

  ScreenControllerStateModel copyWith({
    bool? isActive,
    Duration? elapsedTime,
    int? screenOnTime,
    bool? isPaused,
    TimeRange? scheduleRange,
  }) {
    return ScreenControllerStateModel(
      isActive: isActive ?? this.isActive,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      screenOnTime: screenOnTime ?? this.screenOnTime,
      isPaused: isPaused ?? this.isPaused,
      scheduleRange: scheduleRange ?? this.scheduleRange,
    );
  }

  @override
  String toString() {
    return 'ScreenControllerStateModel(isActive: $isActive, elapsedTime: $elapsedTime, screenOnTime: $screenOnTime, isPaused: $isPaused, scheduleRange: $scheduleRange)';
  }

  double get screenTimePercentage =>
      elapsedTime.inSeconds / Duration(minutes: screenOnTime).inSeconds;
  @override
  bool operator ==(covariant ScreenControllerStateModel other) {
    if (identical(this, other)) return true;

    return other.isActive == isActive &&
        other.elapsedTime == elapsedTime &&
        other.screenOnTime == screenOnTime &&
        other.isPaused == isPaused &&
        other.scheduleRange == scheduleRange;
  }

  @override
  int get hashCode {
    return isActive.hashCode ^
        elapsedTime.hashCode ^
        screenOnTime.hashCode ^
        isPaused.hashCode ^
        scheduleRange.hashCode;
  }
}
