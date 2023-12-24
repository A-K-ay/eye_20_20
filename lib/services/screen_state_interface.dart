import 'dart:async';

import 'package:eyecareplus/constants/screen_state_enum.dart';
import 'package:flutter/material.dart';

abstract class ScreenStateInterface {
  ValueNotifier<ScreenStateType> screenStateChanged =
      ValueNotifier(ScreenStateType.closed);
  Future<void> init();
}
