import 'package:eye_20_20/screens/home_page/home_page.dart';
import 'package:eye_20_20/screens/onboarding_screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    checkOnboardingFlag();
    super.initState();
  }

  void checkOnboardingFlag() async {
    final prefs = await SharedPreferences.getInstance();
    bool onboardingShown = prefs.getBool("onboarding_Sceen") ?? false;
    if (onboardingShown) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomePage()));
    } else {
      prefs.setBool("onboarding_Sceen", true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Onboarding()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: Expanded(
        //   child: SvgPicture.asset(
        //     "assets/images/screen_time.svg",
        //   ),
        // ),
        );
  }
}
