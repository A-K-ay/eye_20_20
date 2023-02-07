part of 'screen_state_cubit.dart';

@immutable
abstract class ScreenController {
  final ScreenControllerStateModel stateModel;
  const ScreenController(this.stateModel);
}

class ScreenStatePaused extends ScreenController {
  const ScreenStatePaused(super.stateModel);
}

class ScreenStateRunning extends ScreenController {
  const ScreenStateRunning(super.stateModel);
}
