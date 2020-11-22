import 'package:demo/components/auth_components/already_have_an_account_check.dart';
import 'package:demo/components/auth_components/bottom_left_clipper.dart';
import 'package:demo/components/auth_components/bottom_left_clipper_bottom.dart';
import 'package:demo/components/auth_components/clip_shadow_path.dart';
import 'package:demo/components/auth_components/rounded_input_field.dart';
import 'package:demo/components/auth_components/rounded_password_field.dart';
import 'package:demo/components/auth_components/top_right_clipper.dart';
import 'package:demo/components/auth_components/top_right_clipper_bottom.dart';
import 'package:demo/components/rounded_button.dart';

import 'package:demo/constants.dart';
import 'package:demo/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool showSpinner = false;

  signIn() async {
    setState(() {
      showSpinner = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text.trim(),
          password: passwordController.text.trim());
      Navigator.pop(context);
      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          showSpinner = false;
        });
        SnackBar snackbar =
            SnackBar(content: Text('No user found for that email.'));
        scaffoldKey.currentState.showSnackBar(snackbar);
      } else if (e.code == 'wrong-password') {
        setState(() {
          showSpinner = false;
        });
        SnackBar snackbar = SnackBar(content: Text('Incorrect password'));
        scaffoldKey.currentState.showSnackBar(snackbar);
      }
    }
  }

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

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: scaffoldKey,
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Container(
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
                  Align(
                    alignment: Alignment(0, -1.5),
                    child: SizedBox(
                      width: width * 0.8,
                      height: height * 0.8,
                      child: Lottie.asset('assets/lottie/loginScreenAnim.json'),
                      // Image.asset('assets/illustrations/welcomeImage.png')
                    ),
                  ),
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
                      padding: EdgeInsets.only(top: height * 0.1),
                      child: Text(
                        'Login',
                        style: GoogleFonts.nunito(
                          color: kPrimaryDarkColor,
                          fontSize: width * 0.09,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RoundedInputField(
                          controller: usernameController,
                          hintText: "Email",
                          inputType: TextInputType.emailAddress,
                          onChanged: (value) {},
                        ),
                        RoundedPasswordField(
                          hintText: "Password",
                          controller: passwordController,
                          onChanged: (value) {},
                        ),
                        RoundedButton(
                          text: "LOGIN",
                          press: () {
                            if (usernameController.text.isEmpty) {
                              SnackBar snackbar = SnackBar(
                                  content: Text("The username cannot be null"));
                              scaffoldKey.currentState.showSnackBar(snackbar);
                            } else if (passwordController.text.isEmpty) {
                              SnackBar snackbar = SnackBar(
                                  content: Text("The password cannot be null"));
                              scaffoldKey.currentState.showSnackBar(snackbar);
                            } else {
                              signIn();
                            }
                          },
                        ),
                        SizedBox(height: height * 0.03),
                        AlreadyHaveAnAccountCheck(
                          press: () {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: SignUpScreen(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: height * 0.03,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
