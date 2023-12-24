import 'dart:math' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:eyecareplus/bloc/cubit/screen_state_cubit.dart';
import 'package:eyecareplus/screens/home_page/widgets/homePageDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../utils/common_utils.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ScreenControllerCubit(CommonUtils.getScreenTime())..init(),
      child: BlocBuilder<ScreenControllerCubit, ScreenControllerState>(
        builder: (context, state) {
          return Scaffold(
            key: _globalKey,
            drawer: HomePageDrawer(),
            body: SafeArea(
              child: LayoutBuilder(builder: (context, constraints) {
                final height = constraints.maxHeight;
                final width = constraints.maxWidth;

                return SizedBox(
                  height: height,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * 0.7,
                                child: AutoSizeText(
                                  "Take Care of Your Eyes",
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.oswald(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500),
                                ),
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
                            height: height * 0.05,
                          ),
                          Center(
                            child: CircularPercentIndicator(
                              // radius: _screenTime.screenOnTime.inSeconds.toDouble(),
                              radius: math.min((width * 0.4), (height * 0.2)),
                              lineWidth: 30.0,
                              rotateLinearGradient: true,
                              backgroundColor:
                                  Theme.of(context).bottomAppBarColor,
                              progressColor: Theme.of(context).primaryColor,
                              percent:
                                  state.stateModel?.screenTimePercentage ?? 0,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text:
                                            "${state.stateModel?.elapsedTime.inMinutes.remainder(60)}:${(state.stateModel?.elapsedTime.inSeconds.remainder(60))}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Theme.of(context).primaryColor,
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
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          ElevatedContainer(
                            child: ListTile(
                              leading: AutoSizeText(
                                "Timer",
                                style: TextStyle(fontSize: 20),
                              ),
                              trailing: CupertinoSwitch(
                                  value: state.stateModel?.isActive ?? false,
                                  activeColor: Theme.of(context)
                                      .buttonTheme
                                      .colorScheme!
                                      .background,
                                  trackColor: Theme.of(context).disabledColor,
                                  thumbColor: Theme.of(context).primaryColor,
                                  onChanged: (val) async {
                                    await BlocProvider.of<
                                            ScreenControllerCubit>(context)
                                        .toggleTimer();
                                  }),
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          AutoSizeText(
                            "If you find yourself gazing at screens all day, your eye doctor may have mentioned this rule to you. Basically, every 20 minutes spent using a screen, you should try to look away at something that is 20 feet away from you for a total of 20 seconds.",
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        },
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
