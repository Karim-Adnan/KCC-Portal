import 'package:demo/constants.dart';
import 'package:demo/screens/navigation_screen.dart';
import 'package:demo/screens/onboarding_screen.dart';
import 'package:demo/screens/role_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/feedback_screen.dart';

int initScreen;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: kPrimaryColor,
  // ));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: initScreen == 0 || initScreen == null ? OnBoardingScreen() : initScreen == 2 ? RoleSelection() : NavigationScreen(),
    theme: ThemeData(
      scaffoldBackgroundColor: kPrimaryColor,
    ),
    )
  );
}
