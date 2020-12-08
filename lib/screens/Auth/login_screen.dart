import 'package:KCC_Portal/components/auth_components/already_have_an_account_check.dart';
import 'package:KCC_Portal/components/auth_components/rounded_input_field.dart';
import 'package:KCC_Portal/components/auth_components/rounded_password_field.dart';
import 'package:KCC_Portal/components/rounded_button.dart';
import 'package:KCC_Portal/constants.dart';
import 'package:KCC_Portal/screens/Auth/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/AuthBG.png'),
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  kSecondaryLightColor,
                  kSecondaryColor,
                  kPrimaryLightColor,
                  kPrimaryColor,
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: size.height,
                    width: size.width,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: size.height * 0.15),
                            child: Text(
                              'Login',
                              style: GoogleFonts.nunito(
                                color: kPrimaryDarkColor,
                                fontSize: size.width * 0.09,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment(0, -0.3),
                          child: Container(
                            height: size.width * 0.8,
                            width: size.width,
                            child: Lottie.asset(
                                'assets/lottie/loginScreenAnim.json'),
                          ),
                        ),
                        Column(
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
                            Hero(
                              tag: 1,
                              child: RoundedButton(
                                text: "LOGIN",
                                press: () {
                                  if (usernameController.text.isEmpty) {
                                    SnackBar snackbar = SnackBar(
                                        content: Text(
                                            "The username cannot be null"));
                                    scaffoldKey.currentState
                                        .showSnackBar(snackbar);
                                  } else if (passwordController.text.isEmpty) {
                                    SnackBar snackbar = SnackBar(
                                        content: Text(
                                            "The password cannot be null"));
                                    scaffoldKey.currentState
                                        .showSnackBar(snackbar);
                                  } else {
                                    signIn();
                                  }
                                },
                              ),
                            ),
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
                              height: size.height * 0.03,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
