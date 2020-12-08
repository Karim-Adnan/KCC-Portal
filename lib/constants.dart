import 'package:flutter/material.dart';

const kPrimaryDarkColor = Color(0xFF0F2F8C);
const kPrimaryColor = Color(0xFF1438A6);
const kPrimaryLightColor= Color(0xFF0B7ABF);
const kSecondaryColor = Color(0xFF0B9ED9);
const kSecondaryLightColor = Color(0xFF07B2D9);

// const kPrimaryDarkColor = Color(0xFF0319FA);
// const kPrimaryColor = Color(0xFF0250DE);
// const kPrimaryLightColor= Color(0xFF099BF5);
// const kSecondaryColor = Color(0xFF02C3DE);
// const kSecondaryLightColor = Color(0xFF03FAD4);

const size = 100.0;
const kAboutIconSize = 22.0;

const kTextFieldDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

class Global {
  static const List<Color> palette = [Colors.white,Colors.blue];
  static const double scale = 1;
  static const double radius = 88.0;
  static const double bottomPadding = 75.0;
}