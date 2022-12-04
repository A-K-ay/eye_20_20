import 'package:eye_20_20/screens/home_page/widgets/homePageDrawer.dart';
import 'package:eye_20_20/services/screen_time_Interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../utils/common_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScreenTimeInterface _screenTime;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

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
      key: _globalKey,
      drawer: HomePageDrawer(
        screenTime: _screenTime,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Take Care of Your Eyes",
                    style: GoogleFonts.oswald(
                        fontSize: 28, fontWeight: FontWeight.w500),
                  ),
                  ElevatedContainer(
                      padding: 0,
                      child: IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            _globalKey.currentState?.openDrawer();
                          })),
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
                        backgroundColor: Theme.of(context).bottomAppBarColor,
                        progressColor: Theme.of(context).primaryColor,
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
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 24)),
                              TextSpan(
                                text: "\nMinutes ",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              TextSpan(
                                text: ": Seconds",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            ])),
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
                        leading: Text(
                          "Timer",
                          style: TextStyle(fontSize: 20),
                        ),
                        trailing: CupertinoSwitch(
                            value: _screenTime.isActive.value,
                            activeColor: Theme.of(context)
                                .buttonTheme
                                .colorScheme!
                                .background,
                            trackColor: Theme.of(context).disabledColor,
                            thumbColor: Theme.of(context).primaryColor,
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
  final double padding;

  const ElevatedContainer(
      {Key? key,
      required this.child,
      this.height,
      this.width,
      this.padding = 16.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).highlightColor,
        ),
        child: Padding(padding: EdgeInsets.all(padding), child: child),
      ),
    );
  }
}
