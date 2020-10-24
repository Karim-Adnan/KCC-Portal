import 'package:flutter/material.dart';

const kPrimaryColor= Color(0xff22aed1);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kSecondaryColor = Color(0x4422aed1);
const size = 100.0;
const kAboutIconSize = 22.0;
const kPrimaryDarkColor = Color(0xff2081F7);

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