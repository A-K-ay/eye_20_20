import 'dart:async';
import 'dart:developer';

import 'package:eye_20_20/constants/screen_state_enum.dart';
import 'package:eye_20_20/services/screen_state_interface.dart';
import 'package:flutter/src/foundation/basic_types.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:screen_state/screen_state.dart';

class AndroidScreenState implements ScreenStateInterface {
  late Screen _screen;
  late StreamSubscription screenStateSubscription;
  @override
  ValueNotifier<ScreenStateType> screenStateChanged =
      ValueNotifier(ScreenStateType.closed);
  @override
  Future init() async {
    log("started listening");
    _screen = Screen();
    try {
      screenStateSubscription = _screen.screenStateStream!.listen(onData);
    } on ScreenStateException catch (exception) {
      print(exception);
    }
  }

  void onData(ScreenStateEvent event) {
    log(event.name);
    if (event == ScreenStateEvent.SCREEN_OFF) {
      screenStateChanged.value = ScreenStateType.closed;
    } else if (event == ScreenStateEvent.SCREEN_ON ||
        event == ScreenStateEvent.SCREEN_UNLOCKED) {
      screenStateChanged.value = ScreenStateType.opened;
    }
  }
}
