import 'package:flutter/material.dart';

class DateWidget extends StatelessWidget {
  final index;
  final selectedCallback;
  final daySelected;
  final  dayList=["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun",];
  DateWidget({this.index, this.selectedCallback, this.daySelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectedCallback(index);
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: daySelected!=index
            ? null
            : BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Text(
              dayList[index],
              style: TextStyle(
                color: daySelected!=index ? Colors.lightBlue[100] : Color(0xff1dc4d8) ,
                fontWeight: daySelected!=index ? FontWeight.normal : FontWeight.bold,
              ),
            ),
            Text(
              "${index + 1}",
              style: TextStyle(
                color: daySelected!=index ? Colors.lightBlue[100] : Color(0xff1dc4d8) ,
                fontWeight: daySelected!=index ? FontWeight.normal : FontWeight.bold,
              ),
            ),
            Container(
              width: 4.0,
              height: 4.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: daySelected!=index ? Colors.lightBlue[100] : Color(0xff1dc4d8) ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
