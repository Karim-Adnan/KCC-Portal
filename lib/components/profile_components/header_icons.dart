import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HeaderButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final Function onTap;

  const HeaderButton({
    @required this.icon,
    @required this.iconColor,
    @required this.iconSize,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(
            size.width * 0.019,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 8.0,
            sigmaY: 8.0,
          ),
          child: Container(
            height: size.width * 0.09,
            width: size.width * 0.13,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  size.width * 0.019,
                ),
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(1.0),
              child: Icon(
                icon,
                color: iconColor,
                size: iconSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
