import 'package:flutter/material.dart';

abstract class ScreenTimeInterface{
  late Stopwatch stopwatch;
  late Duration screenOnTime;
  void init();
  void startTimer();
  void sendNotification();
  void stopTimer();
  void dispose();
  bool get isRunning;
  void toggleTimer();
  void setRefreshUiCallback(VoidCallback uiCallback);

}