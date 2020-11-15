import 'file:///D:/AndroidProjects/KCC-Portal/lib/components/time_table_components/subject_card.dart';
import 'file:///D:/AndroidProjects/KCC-Portal/lib/components/time_table_components/date_widget.dart';
import 'file:///D:/AndroidProjects/KCC-Portal/lib/components/time_table_components/time_table_header.dart';
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
                            daySelected: daySelected,
                        ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: List.generate(8, (index) =>
                  SubjectCard(index: index, daySelected: daySelected,)),
            ),
          )
        ],
      ),
    );
  }
}



