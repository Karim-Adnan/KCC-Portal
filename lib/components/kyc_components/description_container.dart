import 'package:flutter/material.dart';

class DescContainer extends StatelessWidget {
  final Widget child;

  const DescContainer({this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFFEEEEEE),
            offset: Offset(0, -0.2),
            blurRadius: size.width * 0.0625,
            spreadRadius: size.width * 0.0875,
          ),
        ],
        color: Color(0xFFEEEEEE),
      ),
      child: child,
    );
  }
}
