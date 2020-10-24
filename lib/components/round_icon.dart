import 'package:flutter/material.dart';

class RoundIcon extends StatelessWidget {
  final Color colour;
  final IconData iconData;
  final Function onPressed;
  RoundIcon({this.colour, this.iconData, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white54,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[600],
              offset: Offset(1.5, 1.5),
              blurRadius: 8.0,
              spreadRadius: 0.1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-3.0, -3.0),
              blurRadius: 8.0,
              spreadRadius: 0.1,
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