import 'package:flutter/material.dart';

class LineGen extends StatelessWidget {
  final lines;
  LineGen({this.lines});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(4,
              (index) => Container(
            height: 2.0,
            width: lines[index],
            color: Color(0xffd0d2d8),
            margin: EdgeInsets.symmetric(vertical: 14.0),
          )
      ),
    );
  }
}