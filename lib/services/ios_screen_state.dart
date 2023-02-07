import 'package:eye_20_20/constants/screen_state_enum.dart';
import 'package:eye_20_20/services/screen_state_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/foundation/basic_types.dart';
import 'package:is_lock_screen/is_lock_screen.dart';

class IosScreenState extends ScreenStateInterface {
  bool isLocked = true;

  @override
  ValueNotifier<ScreenStateType> screenStateChanged =
      ValueNotifier(ScreenStateType.closed);

  @override
  Future<void> init() async {
    // TODO: implement init
    Stream.periodic(const Duration(seconds: 30)).listen((event) {
      lockScreenPoll();
    });
  }

  Future lockScreenPoll() async {
    bool tempIsLocked = await isLockScreen() ?? true;
    if (isLocked == tempIsLocked) {
      return;
    }
    isLocked = tempIsLocked;
    if (isLocked) {
      screenStateChanged.value = ScreenStateType.closed;
    } else {
      screenStateChanged.value = ScreenStateType.opened;
    }
  }
}
