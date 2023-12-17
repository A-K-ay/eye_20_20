part of 'screen_state_cubit.dart';

@immutable
abstract class ScreenControllerState {
  final ScreenControllerStateModel stateModel;
  const ScreenControllerState(this.stateModel);
}

class ScreenStatePaused extends ScreenControllerState {
  const ScreenStatePaused(super.stateModel);
}

class ScreenStateRunning extends ScreenControllerState {
  const ScreenStateRunning(super.stateModel);
}
