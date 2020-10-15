import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path= new Path();
    path.lineTo(0, size.height-60);

    path.quadraticBezierTo(size.width/2 - 60, size.height, size.width, size.height - 20.0);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}