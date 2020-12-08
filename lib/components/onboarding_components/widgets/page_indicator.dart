import 'package:KCC_Portal/components/onboarding_components/provider/index_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageIndicator extends StatelessWidget {
  _indicator(bool isActive) {
    return Container(
      width: 10,
      height: 10,
      margin: EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.black : Colors.transparent,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = Provider.of<IndexNotifier>(context).index;

    List<Widget> _buildIndicator() {
      List<Widget> indicators = List();
      for (int i = 0; i < 3 /* NUMBER OF ONBOARDING SCREENS */; i++) {
        indicators.add(
          i == currentIndex ? _indicator(true) : _indicator(false),
        );
      }
      return indicators;
    }

    return Padding(
      padding: EdgeInsets.only(left: 18),
      child: Row(
        children: _buildIndicator(),
      ),
    );
  }
}
