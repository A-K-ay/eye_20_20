import 'package:eye_20_20/services/screen_time_Interface.dart';
import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';

class AddDailyDuration extends StatelessWidget {
  final ScreenTimeInterface screenTimeInterface;
  const AddDailyDuration({required this.screenTimeInterface});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(
        Icons.timelapse,
      ),
      title: Text(
        "Daily Schedule",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      childrenPadding: EdgeInsets.all(16),
      children: [
        Text(
            screenTimeInterface.scheduleRange == null
                ? "Please Select a Time Range"
                : "7:30 to 8:30",
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
        Text("You can set a schedule for it to run automatically.",
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
        SizedBox(
          height: 8,
        ),
        ElevatedButton(
            onPressed: () async {
              TimeRange result = await showTimeRangePicker(
                context: context,
              );
            },
            child: Text("Save"))
      ],
    );
  }
}
