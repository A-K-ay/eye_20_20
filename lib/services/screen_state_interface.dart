import 'dart:async';

import 'package:eye_20_20/constants/screen_state_enum.dart';
import 'package:flutter/material.dart';

abstract class ScreenStateInterface {
  ValueNotifier<ScreenStateType> screenStateChanged =
      ValueNotifier(ScreenStateType.closed);
  Future<void> init();
}
