import 'package:eye_20_20/services/screen_time_Interface.dart';
import 'package:flutter/material.dart';

class ChangeScreenOnTime extends StatefulWidget {
  final ScreenTimeInterface screenTimeInterface;
  const ChangeScreenOnTime({Key? key, required this.screenTimeInterface})
      : super(key: key);

  @override
  State<ChangeScreenOnTime> createState() => _ChangeScreenOnTimeState();
}

class _ChangeScreenOnTimeState extends State<ChangeScreenOnTime> {
  late double minutesDuration;
  @override
  void initState() {
    // TODO: implement initState
    minutesDuration = widget.screenTimeInterface.screenOnTime.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        Text("${minutesDuration.toInt().toString()} minutes",
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
        Slider(
            value: minutesDuration,
            min: 2,
            max: 200,
            onChanged: (val) {
              minutesDuration = val;
              setState(() {});
            }),
        Text(
            "Screen on time indicates the time at which the notification is sent.",
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
        SizedBox(
          height: 8,
        ),
        Visibility(
            visible: minutesDuration.toInt() !=
                widget.screenTimeInterface.screenOnTime,
            child: ElevatedButton(
                onPressed: () {
                  // Change Screen time in shared prefrences.
                  widget.screenTimeInterface
                      .setScreenOnTime(minutesDuration.toInt());
                  setState(() {});
                },
                child: Text("Save")))
      ],
    );
  }
}
