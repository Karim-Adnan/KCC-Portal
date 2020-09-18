
import 'package:flutter/cupertino.dart';

class MyClipper extends CustomClipper<Path>{

  @override
  Path getClip(Size size) {
    var path= new Path();
    path.lineTo(0, size.height-100);
    var controllPoints=Offset(50,size.height);
    var endPoint=Offset(size.width/2, size.height);
    path.quadraticBezierTo(controllPoints.dx, controllPoints.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}