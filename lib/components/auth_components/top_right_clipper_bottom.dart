import 'package:flutter/material.dart';

/// Neumorphic clipper that is placed the bottom most on the top right
/// Btm just stands for the bottom most
class TopRightNeuClipperBtm extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 375;
    final double _yScaling = size.height / 812;
    path.lineTo(132.31 * _xScaling,101.946 * _yScaling);
    path.cubicTo(153.384 * _xScaling,97.0805 * _yScaling,171.702 * _xScaling,81.3422 * _yScaling,194.255 * _xScaling,85.7576 * _yScaling,);
    path.cubicTo(216.821 * _xScaling,90.1755 * _yScaling,235.725 * _xScaling,111.285 * _yScaling,255.955 * _xScaling,126.153 * _yScaling,);
    path.cubicTo(275.827 * _xScaling,140.758 * _yScaling,299.202 * _xScaling,151.312 * _yScaling,313.026 * _xScaling,173.051 * _yScaling,);
    path.cubicTo(326.801 * _xScaling,194.712 * _yScaling,327.17 * _xScaling,221.158 * _yScaling,332.07 * _xScaling,245.849 * _yScaling,);
    path.cubicTo(336.71 * _xScaling,269.23 * _yScaling,341.913 * _xScaling,292.368 * _yScaling,341.259 * _xScaling,315.309 * _yScaling,);
    path.cubicTo(340.574 * _xScaling,339.357 * _yScaling,339.519 * _xScaling,364.596 * _yScaling,328.156 * _xScaling,383.13 * _yScaling,);
    path.cubicTo(316.801 * _xScaling,401.651 * _yScaling,294.845 * _xScaling,406.999 * _yScaling,277.756 * _xScaling,418.889 * _yScaling,);
    path.cubicTo(259.664 * _xScaling,431.477 * _yScaling,246.582 * _xScaling,455.445 * _yScaling,223.769 * _xScaling,455.761 * _yScaling,);
    path.cubicTo(200.926 * _xScaling,456.078 * _yScaling,179.98 * _xScaling,433.008 * _yScaling,158.001 * _xScaling,420.549 * _yScaling,);
    path.cubicTo(137.845 * _xScaling,409.123 * _yScaling,117.385 * _xScaling,399.908 * _yScaling,98.7912 * _xScaling,384.915 * _yScaling,);
    path.cubicTo(78.6568 * _xScaling,368.679 * _yScaling,55.3599 * _xScaling,353.307 * _yScaling,44.3122 * _xScaling,328.873 * _yScaling,);
    path.cubicTo(33.2642 * _xScaling,304.438 * _yScaling,40.0691 * _xScaling,278.206 * _yScaling,38.956 * _xScaling,252.576 * _yScaling,);
    path.cubicTo(37.8786 * _xScaling,227.77 * _yScaling,33.0909 * _xScaling,202.463 * _yScaling,37.8156 * _xScaling,179.287 * _yScaling,);
    path.cubicTo(42.7765 * _xScaling,154.951 * _yScaling,49.6664 * _xScaling,129.307 * _yScaling,66.9723 * _xScaling,115.143 * _yScaling,);
    path.cubicTo(84.2213 * _xScaling,101.025 * _yScaling,110.476 * _xScaling,106.987 * _yScaling,132.31 * _xScaling,101.946 * _yScaling,);
    path.cubicTo(132.31 * _xScaling,101.946 * _yScaling,132.31 * _xScaling,101.946 * _yScaling,132.31 * _xScaling,101.946 * _yScaling,);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}