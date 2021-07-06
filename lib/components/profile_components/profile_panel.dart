import 'dart:ui';
import 'package:flutter/material.dart';

class ProfilePanel extends StatelessWidget {
  final List<Widget> children;

  const ProfilePanel({
    @required this.children,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DraggableScrollableSheet(
      initialChildSize: 0.15,
      minChildSize: 0.15,
      maxChildSize: 0.5,
      expand: true,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(size.width * 0.075),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 25,
              sigmaY: 25,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(size.width * 0.075),
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.15),
                  width: size.width * 0.00375,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: size.width * 0.05,
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
