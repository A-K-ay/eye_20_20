import 'package:eye_20_20/bloc/cubit/screen_state_cubit.dart';
import 'package:eye_20_20/screens/home_page/widgets/homePageDrawer.dart';
import 'package:eye_20_20/services/screen_time_Interface.dart';
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
      child: BlocBuilder<ScreenControllerCubit, ScreenController>(
        builder: (context, state) {
          return Scaffold(
            key: _globalKey,
            // drawer: HomePageDrawer(
            //   screenTime: _screenTime,
            // ),
            body: SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
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
                              overflow: TextOverflow.fade,
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
                        Center(
                          child: CircularPercentIndicator(
                            // radius: _screenTime.screenOnTime.inSeconds.toDouble(),
                            radius: 160,
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
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedContainer(
                          child: ListTile(
                            leading: Text(
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
                                  await BlocProvider.of<ScreenControllerCubit>(
                                          context)
                                      .toggleTimer();
                                }),
                          ),
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
              ),
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
