import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:KCC_Portal/components/onboarding_components/provider/index_notifier.dart';
import 'package:KCC_Portal/constants.dart';
import 'package:KCC_Portal/screens/Onboarding/onboarding_screen.dart';
import 'package:KCC_Portal/screens/navigation_screen.dart';
import 'package:KCC_Portal/screens/role_selection_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;

void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: initScreen == 0 || initScreen == null
        ? ChangeNotifierProvider(
            create: (context) => IndexNotifier(),
            child: OnBoardingScreen(),
          )
        : initScreen == 2
            ? RoleSelection()
            : NavigationScreen(),
    theme: ThemeData(
      scaffoldBackgroundColor: kPrimaryColor,
    ),
  ));
}
