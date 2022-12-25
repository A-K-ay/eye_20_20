import 'package:eye_20_20/services/screen_time_Interface.dart';
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
              widget.screenTimeInterface.scheduleRange = result;
              setState(() {});
            },
            child: Text("Pick Time Range"))
      ],
    );
  }
}
