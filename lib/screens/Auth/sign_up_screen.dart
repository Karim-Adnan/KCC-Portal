

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
import 'package:demo/screens/login_screen.dart';
import 'package:demo/screens/role_selection_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool showSpinner = false;
  registerUser() async {
    setState(() {
      showSpinner = true;
    });
    try {
      print(
          "email and password=${emailController.text.trim()} and ${passwordController.text.trim()}");
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => RoleSelection(
                    currentUserPassword: passwordController.text,
                  )));
      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      if (e.code == 'weak-password') {
        SnackBar snackbar =
            SnackBar(content: Text("The password provided is too weak."));
        scaffoldKey.currentState.showSnackBar(snackbar);
        setState(() {
          showSpinner = false;
        });
      } else if (e.code == 'email-already-in-use') {
        SnackBar snackbar = SnackBar(
            content: Text("The account already exists for this username."));
        scaffoldKey.currentState.showSnackBar(snackbar);
        setState(() {
          showSpinner = false;
        });
      } else {
        SnackBar snackbar = SnackBar(content: Text(e.toString()));
        scaffoldKey.currentState.showSnackBar(snackbar);
        setState(() {
          showSpinner = false;
        });
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
                  kSecondaryLightColor,
                  kSecondaryColor,
                  kPrimaryLightColor,
                  kPrimaryColor,
                  kPrimaryDarkColor,
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
                  alignment: Alignment(0, -30),
                  child: SizedBox(
                    width: width * 0.99,
                    height: height * 0.99,
                    child: Lottie.asset('assets/lottie/signupScreenAnim.json'),
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
                      'Sign Up',
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
                        controller: emailController,
                        hintText: "Email",
                        inputType: TextInputType.emailAddress,
                        icon: Icons.email,
                        onChanged: (value) {},
                      ),
                      RoundedPasswordField(
                        controller: passwordController,
                        hintText: "Password",
                        onChanged: (value) {},
                      ),
                      RoundedPasswordField(
                        controller: confirmPasswordController,
                        hintText: "Confirm Password",
                        onChanged: (value) {},
                      ),
                      SizedBox(height: height * 0.01),
                      RoundedButton(
                        text: "SIGNUP",
                        press: () {
                          if (emailController.text.isEmpty) {
                            SnackBar snackbar = SnackBar(
                                content: Text("Email cannot be empty"));
                            scaffoldKey.currentState.showSnackBar(snackbar);
                          } else if (passwordController.text !=
                              confirmPasswordController.text) {
                            SnackBar snackbar = SnackBar(
                                content: Text("Both passwords should match"));
                            scaffoldKey.currentState.showSnackBar(snackbar);
                          } else if (passwordController.text.isEmpty ||
                              confirmPasswordController.text.isEmpty) {
                            SnackBar snackbar = SnackBar(
                                content: Text("The password cannot be empty"));
                            scaffoldKey.currentState.showSnackBar(snackbar);
                          } else if (passwordController.text.length < 6) {
                            SnackBar snackbar = SnackBar(
                                content: Text(
                                    "The password should at least be of 6 characters"));
                            scaffoldKey.currentState.showSnackBar(snackbar);
                          } else {
                            registerUser();
                          }
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      AlreadyHaveAnAccountCheck(
                        login: false,
                        press: () {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: LoginScreen(),
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
        ),
      ),
    );
  }
}
