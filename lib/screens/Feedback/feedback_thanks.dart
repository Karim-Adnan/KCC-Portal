import 'package:KCC_Portal/screens/navigation_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class FeedbackThanks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Container(
                  height: MediaQuery.of(context).size.height * .5,
                  child: Image.asset('assets/illustrations/feedback_thanks.jpg'),
                ),
                Text(
                  "Thanks for your \nfeedback",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.satisfy(
                      fontSize: 30,
                      color: Colors.teal
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 35),
              child: InkWell(
                onTap: () => Navigator.pushReplacement(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: NavigationHomeScreen(),
                  ),
                ),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Go to home",
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.teal,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
