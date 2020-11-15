import 'package:flutter/material.dart';

class TimeTableHeader extends StatelessWidget {
  TimeTableHeader({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Text("Time",
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8.0,),
            Text("Table",
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue[100],
              ),
            ),
          ],
        ),
      ],
    );
  }
}