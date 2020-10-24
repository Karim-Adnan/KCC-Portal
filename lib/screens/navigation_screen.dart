import 'package:demo/screens/sign_up_screen.dart';
import 'package:demo/screens/navigation_home_screen.dart';
import 'package:demo/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:demo/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  bool isSigned = false;
  int initScreen;
  @override
  void initState() {
    super.initState();
    // setPreference();
    auth.FirebaseAuth.instance
        .authStateChanges()
        .listen((auth.User user) {
      if (user != null) {
        setState(() {
          isSigned = true;
          print(user.uid);
        });
      } else {
        setState(() {
          isSigned = false;
        });
      }
    });
  }

  // setPreference() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   initScreen = await prefs.getInt("initScreen");
  // }
  @override
  Widget build(BuildContext context) {
    print(isSigned);
    print("111111111111111111111111");
    return Scaffold(
      body: isSigned ? NavigationHomeScreen() : WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_bottom.png",
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "WELCOME TO KCC Portal",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Image.asset(
                      "assets/images/welcome_pic.png",
                      height: MediaQuery.of(context).size.height * 0.45,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    RoundedButton(
                      text: "LOGIN",
                      color: kPrimaryColor,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                    ),
                    RoundedButton(
                      text: "SIGN UP",
                      color: kSecondaryColor,
                      textColor: Colors.black,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}