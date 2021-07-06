
import 'package:KCC_Portal/constants.dart';
import 'package:flutter/material.dart';

class RoundIcon extends StatelessWidget {
  final Color colour;
  final String imageData;
  final Function onPressed;
  RoundIcon({this.colour, this.imageData, this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: size.width * 0.14,
        width: size.width * 0.14,
        decoration: BoxDecoration(
          color: kSecondaryLightColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(size.width * 0.065),
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
        child: Image.asset(
          imageData,
          color: colour,
        ),
        padding: EdgeInsets.all(10.0),
      ),
    );
  }
}