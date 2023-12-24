import 'package:eyecareplus/screens/home_page/widgets/add_daily_duration.dart';
import 'package:eyecareplus/screens/home_page/widgets/notifiaction_content_editor.dart';
import 'package:flutter/material.dart';

import 'change_screen_on_time.dart';

class HomePageDrawer extends StatelessWidget {
  HomePageDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          // padding: EdgeInsets.all(8),
          child: const SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Settings",
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                  height: 16,
                ),
                ChangeScreenOnTime(),
                AddDailyDuration(),
                NotificationContentEditor()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
