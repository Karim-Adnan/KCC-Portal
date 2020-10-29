import 'package:demo/screens/navigation_screen.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  final pageList = [
    PageModel(
        color: const Color(0xFF678FB4),
        heroImagePath: 'assets/images/onboarding_image1.png',
        title: Text('College',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text('All hotels and hostels are sorted by hospitality rating',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconImagePath: 'assets/icons/onboarding_icon1.png'),
    PageModel(
        color: const Color(0xFF65B0B4),
        heroImagePath: 'assets/images/onboarding_image2.png',
        title: Text('Notice',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text('Keep track of all the important notices',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconImagePath: 'assets/icons/onboarding_icon2.png'),
    PageModel(
        color: const Color(0xFF9B90BC),
        heroImagePath: 'assets/images/onboarding_image3.png',
        title: Text('Success',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text('Run for your success',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconImagePath: 'assets/icons/onboarding_icon3.png'),
    PageModel(
        color: const Color(0xFFb86ad9),
        heroImagePath: 'assets/images/onboarding_image4.png',
        title: Text('Connections',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text('All local stores are categorized for your convenience',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconImagePath: 'assets/icons/onboarding_icon4.png'),
    PageModel(
        color: const Color(0xFFc6c910),
        heroImagePath: 'assets/images/onboarding_image5.png',
        title: Text('Achieve',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text('All local stores are categorized for your convenience',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconImagePath: 'assets/icons/onboarding_icon1.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FancyOnBoarding(
        doneButtonText: "Done",
        skipButtonText: "Skip",
        pageList: pageList,
        onDoneButtonPressed: () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => NavigationScreen())),
        onSkipButtonPressed: () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => NavigationScreen())),
      ),
    );
  }
}
