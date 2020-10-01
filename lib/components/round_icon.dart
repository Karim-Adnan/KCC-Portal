import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundIcon extends StatelessWidget {

  RoundIcon({this.colour, this.iconData, this.onPressed});

  final Color colour;
  final IconData iconData;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: Colors.grey[100],
      child: Icon(
        iconData,
        size: 35.0,
        color: colour,
      ),
      padding: EdgeInsets.all(10.0),
      shape: CircleBorder(),
    );
  }
}