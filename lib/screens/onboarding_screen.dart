import 'package:KCC_Portal/components/onboarding_components/Onboarding_KYC.dart';
import 'package:KCC_Portal/components/onboarding_components/Onboarding_forum.dart';
import 'package:KCC_Portal/components/onboarding_components/Onboarding_study_hub.dart';
import 'package:KCC_Portal/components/onboarding_components/provider/offset_notifier.dart';
import 'package:KCC_Portal/components/onboarding_components/widgets/page_indicator.dart';
import 'package:KCC_Portal/screens/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KCC_Portal/components/onboarding_components/provider/index_notifier.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (context) => OffsetNotifier(_pageController),
      child: Scaffold(
        backgroundColor: Color(0xFCF2F2F2),
        body: Container(
          margin: EdgeInsets.only(top: size.height * 0.075),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "KCC Portal",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w900,
                          fontSize: size.width * 0.055,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: Offset(3, 3),
                              blurRadius: 14.0,
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int index) {
                    Provider.of<IndexNotifier>(context, listen: false).index =
                        index;
                  },
                  children: [
                    OnboardingForumPage(),
                    OnboardingStudyHub(),
                    OnboardingKYC(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PageIndicator(),
                  Padding(
                    padding: EdgeInsets.only(right: 45),
                    child: GestureDetector(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                          "assets/icons/arrowForward.png",
                        ),
                      ),
                      onTap: () => Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: NavigationScreen(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );

    //   Scaffold(
    //   body: FancyOnBoarding(
    //     doneButtonText: "Done",
    //     skipButtonText: "Skip",
    //     pageList: pageList,
    //     onDoneButtonPressed: () => Navigator.pushReplacement(context,
    //         MaterialPageRoute(builder: (context) => NavigationScreen())),
    //     onSkipButtonPressed: () => Navigator.pushReplacement(context,
    //         MaterialPageRoute(builder: (context) => NavigationScreen())),
    //   ),
    // );
  }
}

// final pageList = [
//   PageModel(
//       color: const Color(0xFF678FB4),
//       heroImagePath: 'assets/images/onboarding_image1.png',
//       title: Text('College',
//           style: TextStyle(
//             fontWeight: FontWeight.w800,
//             color: Colors.white,
//             fontSize: 34.0,
//           )),
//       body: Text('All hotels and hostels are sorted by hospitality rating',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18.0,
//           )),
//       iconImagePath: 'assets/icons/onboarding_icon1.png'),
//   PageModel(
//       color: const Color(0xFF65B0B4),
//       heroImagePath: 'assets/images/onboarding_image2.png',
//       title: Text('Notice',
//           style: TextStyle(
//             fontWeight: FontWeight.w800,
//             color: Colors.white,
//             fontSize: 34.0,
//           )),
//       body: Text('Keep track of all the important notices',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18.0,
//           )),
//       iconImagePath: 'assets/icons/onboarding_icon2.png'),
//   PageModel(
//       color: const Color(0xFF9B90BC),
//       heroImagePath: 'assets/images/onboarding_image3.png',
//       title: Text('Success',
//           style: TextStyle(
//             fontWeight: FontWeight.w800,
//             color: Colors.white,
//             fontSize: 34.0,
//           )),
//       body: Text('Run for your success',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18.0,
//           )),
//       iconImagePath: 'assets/icons/onboarding_icon3.png'),
//   PageModel(
//       color: const Color(0xFFb86ad9),
//       heroImagePath: 'assets/images/onboarding_image4.png',
//       title: Text('Connections',
//           style: TextStyle(
//             fontWeight: FontWeight.w800,
//             color: Colors.white,
//             fontSize: 34.0,
//           )),
//       body: Text('All local stores are categorized for your convenience',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18.0,
//           )),
//       iconImagePath: 'assets/icons/onboarding_icon4.png'),
//   PageModel(
//       color: const Color(0xFFc6c910),
//       heroImagePath: 'assets/images/onboarding_image5.png',
//       title: Text('Achieve',
//           style: TextStyle(
//             fontWeight: FontWeight.w800,
//             color: Colors.white,
//             fontSize: 34.0,
//           )),
//       body: Text('All local stores are categorized for your convenience',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18.0,
//           )),
//       iconImagePath: 'assets/icons/onboarding_icon1.png'),
// ];
