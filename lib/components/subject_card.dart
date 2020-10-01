import 'package:demo/util/time_table_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'line_gen.dart';


class SubjectCard extends StatelessWidget {

  final index;
  final daySelected;

  SubjectCard({this.index, this.daySelected});

  bool isWeekend(){
    return (daySelected==5 || daySelected==6);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                subjectTimings[index].substring(0,6),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              LineGen(
                lines: [20.0, 30.0, 40.0, 10.0],
              ),
            ],
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Container(
            width: 100.0,
            height: 150.0,
            decoration: BoxDecoration(
              // color: Color(0xfffcf9f5),
                color: isWeekend() ? Color(0xff1dc4d8) : (daysList[daySelected][index]=="Lunch" ? Colors.red : Color(0xff1dc4d8)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                )
            ),
            child: Container(
              margin: EdgeInsets.only(left: 4.0),
              padding: EdgeInsets.only(left: 16.0, top: 8.0),
              color: Color(0xfffcf9f5),
              child: isWeekend() ? Image.asset("assets/images/saturday_image.png") : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 21.0,
                    child: Row(
                      children: [
                        Text(
                          isWeekend() ? "" : subjectTimings[index],
                        ),
                        VerticalDivider(),
                        Text(
                          isWeekend() ? "" : teachersList[daysList[daySelected][index]],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      isWeekend() ? "" : daysList[daySelected][index],
                      style: TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}