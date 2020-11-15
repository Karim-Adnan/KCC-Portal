import 'package:demo/components/rounded_button.dart';
import 'file:///D:/AndroidProjects/KCC-Portal/lib/components/auth_components/bottom_left_clipper.dart';
import 'file:///D:/AndroidProjects/KCC-Portal/lib/components/auth_components/bottom_left_clipper_bottom.dart';
import 'file:///D:/AndroidProjects/KCC-Portal/lib/components/auth_components/clip_shadow_path.dart';
import 'file:///D:/AndroidProjects/KCC-Portal/lib/components/auth_components/top_right_clipper.dart';
import 'file:///D:/AndroidProjects/KCC-Portal/lib/components/auth_components/top_right_clipper_bottom.dart';
import 'package:demo/constants.dart';
import 'package:demo/screens/login_screen.dart';
import 'package:demo/screens/sign_up_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

final kHomeImage =
    'https://user-images.githubusercontent.com/31005114/78748465-b5327d00-799e-11ea-9f40-38d322a9531a.png';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final boxShadow = BoxShadow(
      color: kPrimaryDarkColor,
      offset: Offset(0, 0),
      blurRadius: 5,
      spreadRadius: 10,
    );

    // Neumorphic colored container with 99% app width
    final widthNeuContainer = Container(
      width: width * 0.99,
      color: kSecondaryColor,
    );

    // Neumorphic colored container with 99% app height
    final heightNeuContainer = Container(
      height: height * 0.99,
      color: kSecondaryColor,
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              kSecondaryColor,
              kPrimaryLightColor,
              kPrimaryColor,
            ],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(75, -45),
              child: SizedBox(
                width: width * 0.99,
                height: height * 0.99,
                child: ClipShadowPath(
                  shadow: boxShadow,
                  clipper: TopRightNeuClipperBtm(),
                  child: widthNeuContainer,
                ),
              ),
            ),
            Align(
              alignment: Alignment(110, -75),
              child: SizedBox(
                width: width * 0.99,
                height: height * 0.99,
                child: ClipShadowPath(
                  shadow: boxShadow,
                  clipper: TopRightNeuClipper(),
                  child: widthNeuContainer,
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, 30.5),
              child: ClipShadowPath(
                shadow: boxShadow,
                clipper: BottomLeftNeuClipperBtm(),
                child: heightNeuContainer,
              ),
            ),
            // Align(
            //   alignment: Alignment(0, -8),
            //   child: SizedBox(
            //       width: width * 0.99,
            //       height: height * 0.99,
            //       child: Image.asset('assets/illustrations/welcomeImage.png')),
            // ),
            Align(
              alignment: Alignment(-60, 110),
              child: SizedBox(
                width: width * 0.99,
                height: height * 0.99,
                child: ClipShadowPath(
                  shadow: boxShadow,
                  clipper: BottomLeftNeuClipper(),
                  child: heightNeuContainer,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.24),
                child: Text(
                  'Welcome User',
                  style: GoogleFonts.nunito(
                    color: kPrimaryDarkColor,
                    fontSize: width * 0.1,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, 0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RoundedButton(
                      text: "LOGIN",
                      color: kPrimaryDarkColor,
                      press: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: LoginScreen(),
                          ),
                        );
                      },
                    ),
                    RoundedButton(
                      text: "SIGN UP",
                      color: kPrimaryLightColor,
                      textColor: Colors.white,
                      press: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: SignUpScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: height * 0.1,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
