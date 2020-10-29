import 'package:demo/screens/navigation_home_screen.dart';
import 'package:demo/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: isSigned ? NavigationHomeScreen() : WelcomeScreen(),
    );
  }
}

