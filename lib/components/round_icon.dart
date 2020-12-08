
import 'package:KCC_Portal/constants.dart';
import 'package:flutter/material.dart';

class RoundIcon extends StatelessWidget {
  final Color colour;
  final IconData iconData;
  final Function onPressed;
  RoundIcon({this.colour, this.iconData, this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: kSecondaryLightColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(size.width * 0.055),
          boxShadow: [
            BoxShadow(
              color: kPrimaryDarkColor,
              offset: Offset(4, 4),
              blurRadius: 15.0,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: kPrimaryDarkColor,
              offset: Offset(4, 4),
              blurRadius: 15.0,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: kPrimaryLightColor,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1,
            ),
          ]
      ),
        child: Icon(
          iconData,
          size: 30.0,
          color: colour,
        ),
        padding: EdgeInsets.all(10.0),
      ),
    );
  }
}