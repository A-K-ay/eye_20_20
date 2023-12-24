import 'package:eyecareplus/bloc/cubit/screen_state_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeScreenOnTime extends StatelessWidget {
  const ChangeScreenOnTime({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScreenControllerCubit, ScreenControllerState>(
      builder: (context, state) {
        return ExpansionTile(
          leading: Icon(
            Icons.timelapse,
          ),
          title: Text(
            "Screen On Time",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          childrenPadding: EdgeInsets.all(16),
          children: [
            Text(
                "${state.stateModel.screenOnTimesSliderValue.toInt().toString()} minutes",
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
            Slider(
                value: state.stateModel.screenOnTimesSliderValue,
                min: 2,
                max: 200,
                onChanged: context
                    .read<ScreenControllerCubit>()
                    .updateScreenOnTimerSliderValue),
            Text(
                "Screen on time indicates the time at which the notification is sent.",
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
            SizedBox(
              height: 8,
            ),
            Visibility(
                visible: state.stateModel.showScreenTimeSliderSaveButton,
                child: ElevatedButton(
                    onPressed: () {
                      // Change Screen time in shared preferences.
                      context.read<ScreenControllerCubit>().setScreenOnTime(
                          state.stateModel.screenOnTimesSliderValue.toInt());
                    },
                    child: Text("Save")))
          ],
        );
      },
    );
  }
}
