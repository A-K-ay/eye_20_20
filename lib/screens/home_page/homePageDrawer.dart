import 'package:eye_20_20/services/screen_time_Interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePageDrawer extends StatelessWidget {
  ScreenTimeInterface screenTime;
  HomePageDrawer({super.key, required this.screenTime});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          // padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                "Settings",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 16,
              ),
              ListTile(
                leading: Icon(Icons.timelapse),
                title: Text("Screen On Time"),
                isThreeLine: true,
                trailing:
                    Text(screenTime.screenOnTime.toString().substring(0, 4)),
                subtitle: Text(
                  "Screen on time indicates the time at which the notification is sent.",
                  style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
