import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Color colour;
  final Widget cardChild;
  final Function onPress;
  final double height;
  ReusableCard({@required this.colour,@required this.cardChild, this.onPress,@required this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height,
        child: Card(
          elevation: 8.0,
          shadowColor: Colors.grey[500],
          color: colour,
        ),
        margin: EdgeInsets.all(15.0),
      ),
    );
  }
}