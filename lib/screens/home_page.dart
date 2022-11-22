import 'package:eye_20_20/services/screen_time_Interface.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../utils/common_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScreenTimeInterface _screenTime;

  @override
  void initState() {
    _screenTime = CommonUtils.getScreenTime();
    _screenTime.init();
    super.initState();
  }

  void updateUI() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 255, 238),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 36,
            ),
            Text(
              "Take Care of Your Eyes",
              style:
                  GoogleFonts.aladin(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedContainer(child: Text(
            "If you find yourself gazing at screens all day, your eye doctor may have mentioned this rule to you. Basically, every 20 minutes spent using a screen, you should try to look away at something that is 20 feet away from you for a total of 20 seconds."),),
         
            // IconButton(
            //     onPressed: () {
            //       _screenTime.startTimer();
            //     },
            //     icon: Icon(_screenTime.isRunning
            //         ? Icons.pause
            //         : Icons.remove_red_eye_sharp)),
            AnimatedBuilder(animation: _screenTime.stopwatchListner, builder: ((context, child) {
            //   return   ElevatedContainer(child: 
            // RichText(text: TextSpan(children: [
            //   TextSpan(text:"Screen on Time: ${_screenTime.screenOnTime.inMinutes} \n",style: TextStyle(color: Colors.black)),
            //   TextSpan(text:"Timer: ${_screenTime.stopwatchListner.value.inSeconds}",style: TextStyle(color: Colors.black)),
            // ])));
            return CircularPercentIndicator(
                  radius: _screenTime.screenOnTime.inSeconds.toDouble(),
                  lineWidth: 5.0,
                  percent: _screenTime.stopwatchListner.value.inSeconds/_screenTime.screenOnTime.inSeconds,
                  center: Text("${_screenTime.stopwatchListner.value.inSeconds}",style: TextStyle(color: Colors.black)),
                  progressColor: Colors.green,
                );

            })),

            AnimatedBuilder(animation: _screenTime.isActive, builder: ((context, child) =>  Switch(
                value: _screenTime.isActive.value,
                onChanged: (val) {
                  _screenTime.toggleTimer();
                })))
          
          ],
        ),
      ),
    );
  }
}

class ElevatedContainer extends StatelessWidget {
  Widget child;
  ElevatedContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: Container(
        // width: 300,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),          color: Colors.white,boxShadow: [new BoxShadow(
          offset: Offset(1,1),
      color: Colors.black12,
      blurRadius: 5.0,
            ),]),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child
        ),
      ),
    );
  }
}
