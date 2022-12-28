import 'package:eye_20_20/services/screen_time_Interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';

class AddDailyDuration extends StatefulWidget {
  final ScreenTimeInterface screenTimeInterface;
  const AddDailyDuration({super.key, required this.screenTimeInterface});

  @override
  State<AddDailyDuration> createState() => _AddDailyDurationState();
}

class _AddDailyDurationState extends State<AddDailyDuration> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(
        Icons.calendar_month_rounded,
      ),
      title: Text(
        "Daily Schedule",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      childrenPadding: EdgeInsets.all(16),
      children: [
        ListTile(
          leading: Text(
            "Schedule",
            style: TextStyle(fontSize: 20),
          ),
          trailing: CupertinoSwitch(
              value: widget.screenTimeInterface.isScheduleActive,
              activeColor:
                  Theme.of(context).buttonTheme.colorScheme!.background,
              trackColor: Theme.of(context).disabledColor,
              thumbColor: Theme.of(context).primaryColor,
              onChanged: (val) async {
                if (val) {
                  await widget.screenTimeInterface.activateSchedule();
                } else {
                  await widget.screenTimeInterface.deactivateSchedule();
                }
                setState(() {});
              }),
        ),
        Text(
            widget.screenTimeInterface.scheduleRange == null
                ? "Please Select a Time Range"
                : "${widget.screenTimeInterface.scheduleRange!.startTime.format(context)} : ${widget.screenTimeInterface.scheduleRange!.endTime.format(context)}",
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
        Text("You can set a schedule for the timer to run automatically.",
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
        SizedBox(
          height: 8,
        ),
        ElevatedButton(
            onPressed: () async {
              TimeRange result = await showTimeRangePicker(
                context: context,
              );
              await widget.screenTimeInterface.setSchedule(result);
              setState(() {});
            },
            child: Text("Pick Time Range"))
      ],
    );
  }
}
