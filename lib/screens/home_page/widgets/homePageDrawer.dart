import 'package:eye_20_20/screens/home_page/widgets/add_daily_duration.dart';
import 'package:eye_20_20/screens/home_page/widgets/notifiaction_content_editor.dart';
import 'package:eye_20_20/services/screen_time_Interface.dart';
import 'package:flutter/material.dart';

import 'change_screen_on_time.dart';

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
              ChangeScreenOnTime(
                screenTimeInterface: screenTime,
              ),
              AddDailyDuration(screenTimeInterface: screenTime),
              NotificationContentEditor(screenTimeInterface: screenTime)
            ],
          ),
        ),
      ),
    );
  }
}
