import 'package:flutter/material.dart';

class DetailsImageScrim extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.center,
          begin: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0.4),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
