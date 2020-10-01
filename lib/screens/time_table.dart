import 'package:demo/components/subject_card.dart';
import 'package:demo/components/time_table_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeTable extends StatefulWidget {
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {

  int daySelected=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(height: 50.0, color: Color(0xff1dc4d8)),
          Container(
            color: Color(0xff1dc4d8),
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TimeTableHeader(),
                Padding(
                  padding: const EdgeInsets.only(top: 26.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (index) =>
                        DateWidget(
                            index: index,
                            selectedCallback: (selectedDay) => setState(() => daySelected=selectedDay),
                            daySelected: daySelected
                      ),
                    ),
                    ),
                  ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              children: List.generate(8, (index) => SubjectCard(index: index, daySelected: daySelected,)),
            ),
          )
        ],
      ),
    );
  }
}






class DateWidget extends StatelessWidget {

  final index;
  final selectedCallback;
  final daySelected;

  DateWidget({this.index, this.selectedCallback, this.daySelected});

  final  dayList=["Mo", "Tu", "We", "Th", "Fr", "Sat", "Sun",];

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



