import 'package:eye_20_20/services/screen_time_Interface.dart';
import 'package:flutter/cupertino.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Take Care of Your Eyes",
                    style: GoogleFonts.oswald(
                        fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  ElevatedContainer(child: Icon(Icons.menu))
                ],
              ),
              SizedBox(
                height: 16,
              ),
              AnimatedBuilder(
                  animation: _screenTime.stopwatchListner,
                  builder: ((context, child) {
                    return Center(
                      child: CircularPercentIndicator(
                        // radius: _screenTime.screenOnTime.inSeconds.toDouble(),
                        radius: 160,
                        lineWidth: 30.0,
                        rotateLinearGradient: true,
                        backgroundColor: Color.fromARGB(255, 216, 238, 217),
                        percent: _screenTime.stopwatchListner.value.inSeconds /
                            _screenTime.screenOnTime.inSeconds,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      "${_screenTime.stopwatchListner.value.inMinutes.remainder(60)}:${(_screenTime.stopwatchListner.value.inSeconds.remainder(60))}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24)),
                              TextSpan(
                                  text: "\nMinutes ",
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                  text: ": Seconds",
                                  style: TextStyle(color: Colors.black))
                            ])),
                        progressColor: Colors.green,
                      ),
                    );
                  })),
              SizedBox(
                height: 16,
              ),
              AnimatedBuilder(
                animation: _screenTime.isActive,
                builder: ((context, child) => ElevatedContainer(
                      child: ListTile(
                        leading: Text("Timer"),
                        trailing: CupertinoSwitch(
                            value: _screenTime.isActive.value,
                            onChanged: (val) {
                              _screenTime.toggleTimer();
                            }),
                      ),
                    )),
              ),
              Divider(),
              SizedBox(
                height: 8,
              ),
              Text(
                  "If you find yourself gazing at screens all day, your eye doctor may have mentioned this rule to you. Basically, every 20 minutes spent using a screen, you should try to look away at something that is 20 feet away from you for a total of 20 seconds."),
            ],
          ),
        ),
      ),
    );
  }
}

class ElevatedContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;

  const ElevatedContainer(
      {Key? key, required this.child, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              new BoxShadow(
                offset: Offset(1, 1),
                color: Colors.black12,
                blurRadius: 5.0,
              ),
            ]),
        child: Padding(padding: const EdgeInsets.all(16.0), child: child),
      ),
    );
  }
}
