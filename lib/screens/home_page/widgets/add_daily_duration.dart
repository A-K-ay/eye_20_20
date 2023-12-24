import 'package:eyecareplus/bloc/cubit/screen_state_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_range_picker/time_range_picker.dart';

class AddDailyDuration extends StatelessWidget {
  const AddDailyDuration({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScreenControllerCubit, ScreenControllerState>(
      builder: (context, state) {
        return ExpansionTile(
          leading: const Icon(
            Icons.calendar_month_rounded,
          ),
          title: Text(
            "Daily Schedule",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          childrenPadding: const EdgeInsets.all(16),
          children: [
            ListTile(
              leading: const Text(
                "Schedule",
                style: TextStyle(fontSize: 20),
              ),
              trailing: CupertinoSwitch(
                  value: state.stateModel.isScheduleActive,
                  activeColor:
                      Theme.of(context).buttonTheme.colorScheme!.background,
                  trackColor: Theme.of(context).disabledColor,
                  thumbColor: Theme.of(context).primaryColor,
                  onChanged: (val) async {
                    if (val) {
                      await context
                          .read<ScreenControllerCubit>()
                          .activateSchedule();
                    } else {
                      await context
                          .read<ScreenControllerCubit>()
                          .deactivateSchedule();
                    }
                  }),
            ),
            Column(
              children: [
                Text(
                    state.stateModel.scheduleRange == null
                        ? "Please Select a Time Range"
                        : "${state.stateModel.scheduleRange!.startTime.format(context)} : ${state.stateModel.scheduleRange!.endTime.format(context)}",
                    style: const TextStyle(
                        fontSize: 12, fontStyle: FontStyle.italic)),
              ],
            ),
            const Text(
              "You can set a schedule for the timer to run automatically.",
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await showTimeRangePicker(
                  context: context,
                );
                if (result is TimeRange) {
                  await context
                      .read<ScreenControllerCubit>()
                      .setSchedule(result);
                }
              },
              child: const Text("Pick Time Range"),
            )
          ],
        );
      },
    );
  }
}
