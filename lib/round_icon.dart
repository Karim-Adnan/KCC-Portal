import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundIcon extends StatelessWidget {

  RoundIcon({this.colour, this.iconData});

  final Color colour;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {},
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