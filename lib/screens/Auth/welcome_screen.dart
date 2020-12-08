
import 'package:KCC_Portal/components/rounded_button.dart';
import 'package:KCC_Portal/constants.dart';
import 'package:KCC_Portal/screens/Auth/login_screen.dart';
import 'package:KCC_Portal/screens/Auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

final kHomeImage =
    'https://user-images.githubusercontent.com/31005114/78748465-b5327d00-799e-11ea-9f40-38d322a9531a.png';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // final boxShadow = BoxShadow(
    //   color: kPrimaryDarkColor,
    //   offset: Offset(0, 0),
    //   blurRadius: 5,
    //   spreadRadius: 10,
    // );
    //
    // // Neumorphic colored container with 99% app width
    // final widthNeuContainer = Container(
    //   width: size.width * 0.99,
    //   color: kSecondaryColor,
    // );
    //
    // // Neumorphic colored container with 99% app height
    // final heightNeuContainer = Container(
    //   height: size.height * 0.99,
    //   color: kSecondaryColor,
    // );

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/AuthBG.png'),
            fit: BoxFit.cover,
          ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.24),
              child: Text(
                'Welcome User',
                style: GoogleFonts.nunito(
                  color: kPrimaryDarkColor,
                  fontSize: size.width * 0.1,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Spacer(),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Hero(
                    tag: 1,
                    child: RoundedButton(
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
                  ),
                  Hero(
                    tag: 2,
                    child: RoundedButton(
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
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  )
                ],
              ),
            ),
          ],
        ),
        // Stack(
        //   children: <Widget>[
        //     // Align(
        //     //   alignment: Alignment(75, -45),
        //     //   child: SizedBox(
        //     //     width: width * 0.99,
        //     //     height: height * 0.99,
        //     //     child: ClipShadowPath(
        //     //       shadow: boxShadow,
        //     //       clipper: TopRightNeuClipperBtm(),
        //     //       child: widthNeuContainer,
        //     //     ),
        //     //   ),
        //     // ),
        //     // Align(
        //     //   alignment: Alignment(110, -75),
        //     //   child: SizedBox(
        //     //     width: width * 0.99,
        //     //     height: height * 0.99,
        //     //     child: ClipShadowPath(
        //     //       shadow: boxShadow,
        //     //       clipper: TopRightNeuClipper(),
        //     //       child: widthNeuContainer,
        //     //     ),
        //     //   ),
        //     // ),
        //     // Align(
        //     //   alignment: Alignment(0, 30.5),
        //     //   child: ClipShadowPath(
        //     //     shadow: boxShadow,
        //     //     clipper: BottomLeftNeuClipperBtm(),
        //     //     child: heightNeuContainer,
        //     //   ),
        //     // ),
        //     // Align(
        //     //   alignment: Alignment(-60, 110),
        //     //   child: SizedBox(
        //     //     width: width * 0.99,
        //     //     height: height * 0.99,
        //     //     child: ClipShadowPath(
        //     //       shadow: boxShadow,
        //     //       clipper: BottomLeftNeuClipper(),
        //     //       child: heightNeuContainer,
        //     //     ),
        //     //   ),
        //     // ),
        //
        //   ],
        // ),
      ),
    );
  }
}
