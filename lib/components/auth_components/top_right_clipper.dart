import 'package:flutter/material.dart';

/// Neumorphic clipper that is placed the top most on the top right
class TopRightNeuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 375;
    final double _yScaling = size.height / 812;
    path.lineTo(136.51 * _xScaling,130.692 * _yScaling);
    path.cubicTo(161.223 * _xScaling,123.881 * _yScaling,183.649 * _xScaling,105.945 * _yScaling,209.304 * _xScaling,108.701 * _yScaling,);
    path.cubicTo(234.975 * _xScaling,111.458 * _yScaling,255.049 * _xScaling,131.942 * _yScaling,277.164 * _xScaling,145.801 * _yScaling,);
    path.cubicTo(298.889 * _xScaling,159.415 * _yScaling,324.989 * _xScaling,168.512 * _yScaling,339.15 * _xScaling,190.07 * _yScaling,);
    path.cubicTo(353.261 * _xScaling,211.552 * _yScaling,351.513 * _xScaling,239.13 * _yScaling,355.137 * _xScaling,264.503 * _yScaling,);
    path.cubicTo(358.568 * _xScaling,288.531 * _yScaling,362.669 * _xScaling,312.259 * _yScaling,360.028 * _xScaling,336.262 * _yScaling,);
    path.cubicTo(357.261 * _xScaling,361.424 * _yScaling,353.969 * _xScaling,387.859 * _yScaling,339.337 * _xScaling,408.142 * _yScaling,);
    path.cubicTo(324.715 * _xScaling,428.411 * _yScaling,298.947 * _xScaling,435.798 * _yScaling,278.254 * _xScaling,449.616 * _yScaling,);
    path.cubicTo(256.348 * _xScaling,464.245 * _yScaling,239.286 * _xScaling,490.341 * _yScaling,212.941 * _xScaling,492.547 * _yScaling,);
    path.cubicTo(186.563 * _xScaling,494.755 * _yScaling,164.294 * _xScaling,472.393 * _yScaling,139.963 * _xScaling,461.192 * _yScaling,);
    path.cubicTo(117.649 * _xScaling,450.921 * _yScaling,94.8022 * _xScaling,442.982 * _yScaling,74.584 * _xScaling,428.857 * _yScaling,);
    path.cubicTo(52.6904 * _xScaling,413.562 * _yScaling,27.0774 * _xScaling,399.43 * _yScaling,16.3405 * _xScaling,374.829 * _yScaling,);
    path.cubicTo(5.60333 * _xScaling,350.228 * _yScaling,15.6099 * _xScaling,322.284 * _yScaling,16.4323 * _xScaling,295.618 * _yScaling,);
    path.cubicTo(17.2283 * _xScaling,269.81 * _yScaling,13.7849 * _xScaling,243.784 * _yScaling,21.1406 * _xScaling,219.2 * _yScaling,);
    path.cubicTo(28.864 * _xScaling,193.387 * _yScaling,38.9202 * _xScaling,166.049 * _yScaling,60.0494 * _xScaling,149.84 * _yScaling,);
    path.cubicTo(81.1091 * _xScaling,133.683 * _yScaling,110.908 * _xScaling,137.749 * _yScaling,136.51 * _xScaling,130.692 * _yScaling,);
    path.cubicTo(136.51 * _xScaling,130.692 * _yScaling,136.51 * _xScaling,130.692 * _yScaling,136.51 * _xScaling,130.692 * _yScaling,);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}