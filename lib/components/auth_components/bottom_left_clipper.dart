import 'package:flutter/material.dart';

/// Neumorphic clipper that is placed the top most on the bottom left
class BottomLeftNeuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 375;
    final double _yScaling = size.height / 812;
    path.lineTo(118.858 * _xScaling,55.2926 * _yScaling);
    path.cubicTo(144.477 * _xScaling,49.2012 * _yScaling,166.897 * _xScaling,30.1522 * _yScaling,194.186 * _xScaling,35.1326 * _yScaling,);
    path.cubicTo(221.492 * _xScaling,40.1159 * _yScaling,244.138 * _xScaling,65.0949 * _yScaling,268.473 * _xScaling,82.5974 * _yScaling,);
    path.cubicTo(292.378 * _xScaling,99.7909 * _yScaling,320.584 * _xScaling,112.096 * _yScaling,337.061 * _xScaling,137.894 * _yScaling,);
    path.cubicTo(353.48 * _xScaling,163.6 * _yScaling,353.58 * _xScaling,195.2 * _yScaling,359.198 * _xScaling,224.642 * _yScaling,);
    path.cubicTo(364.518 * _xScaling,252.524 * _yScaling,370.523 * _xScaling,280.107 * _yScaling,369.428 * _xScaling,307.532 * _yScaling,);
    path.cubicTo(368.281 * _xScaling,336.28 * _yScaling,366.67 * _xScaling,366.456 * _yScaling,352.648 * _xScaling,388.754 * _yScaling,);
    path.cubicTo(338.635 * _xScaling,411.038 * _yScaling,311.942 * _xScaling,417.717 * _yScaling,291.063 * _xScaling,432.152 * _yScaling,);
    path.cubicTo(268.959 * _xScaling,447.433 * _yScaling,252.781 * _xScaling,476.248 * _yScaling,225.114 * _xScaling,476.925 * _yScaling,);
    path.cubicTo(197.41 * _xScaling,477.604 * _yScaling,172.314 * _xScaling,450.31 * _yScaling,145.826 * _xScaling,435.709 * _yScaling,);
    path.cubicTo(121.535 * _xScaling,422.319 * _yScaling,96.846 * _xScaling,411.575 * _yScaling,74.4963 * _xScaling,393.901 * _yScaling,);
    path.cubicTo(50.2945 * _xScaling,374.762 * _yScaling,22.2466 * _xScaling,356.698 * _yScaling,9.17116 * _xScaling,327.643 * _yScaling,);
    path.cubicTo(-3.90472 * _xScaling,298.586 * _yScaling,4.69159 * _xScaling,267.148 * _yScaling,3.67849 * _xScaling,236.532 * _yScaling,);
    path.cubicTo(2.69799 * _xScaling,206.902 * _yScaling,-2.77519 * _xScaling,176.722 * _yScaling,3.25847 * _xScaling,148.962 * _yScaling,);
    path.cubicTo(9.59385 * _xScaling,119.814 * _yScaling,18.2854 * _xScaling,89.077 * _yScaling,39.4567 * _xScaling,71.9221 * _yScaling,);
    path.cubicTo(60.5583 * _xScaling,54.8237 * _yScaling,92.3164 * _xScaling,61.6033 * _yScaling,118.858 * _xScaling,55.2926 * _yScaling,);
    path.cubicTo(118.858 * _xScaling,55.2926 * _yScaling,118.858 * _xScaling,55.2926 * _yScaling,118.858 * _xScaling,55.2926 * _yScaling,);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}