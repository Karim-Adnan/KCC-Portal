import 'package:demo/screens/drawer_screen.dart';

import 'screens/homepage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: MainScreen(),
));


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          Home(),
        ],
      ),
    );
  }
}