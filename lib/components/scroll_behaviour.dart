import 'package:flutter/cupertino.dart';

class MyScrollBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirect) {
    return child;
  }
}
