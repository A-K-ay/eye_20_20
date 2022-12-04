import 'dart:async';

import 'package:eye_20_20/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../home_page/home_page.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late PageController _pageController;
  late StreamSubscription _autoScrollSubscription;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  void autoScroll() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingModelList.length,
                  itemBuilder: (context, index) {
                    return OnboardingWidget(
                      imagePath: onboardingModelList[index].imagePath,
                      title: onboardingModelList[index].title,
                      description: onboardingModelList[index].description,
                    );
                  }),
            ),
            SmoothPageIndicator(
                controller: _pageController, // PageController
                count: 3,
                effect: ExpandingDotsEffect(), // your preferred effect
                onDotClicked: (index) {
                  _pageController.animateToPage(index,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeOut);
                }),
            SizedBox(
              height: 32,
            ),
            BottomBar(pageController: _pageController)
          ],
        ),
      )),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => HomePage()));
            },
            child: Text("Skip")),
        AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) => ElevatedButton(
            onPressed: () {
              if (_pageController.page!.ceil() == 2) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomePage()));
              } else {
                _pageController.nextPage(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeOut);
              }
            },
            child: Icon(Icons.arrow_right_alt, size: 50),
          ),
        ),
      ],
    );
  }
}

class OnboardingWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingWidget({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 3,
          child: SvgPicture.asset(
            imagePath,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const Spacer(),
      ],
    );
  }
}
