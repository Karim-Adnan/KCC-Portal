import 'package:KCC_Portal/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../database.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<Meeting> meetings;
  bool isLoading = false;
  Map<String, dynamic> _timetableList;
  List<String> _daysList = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday'
  ];
  List<Color> _randomColors = [
    Colors.cyan[400],
    Colors.teal[300],
    Colors.indigo,
    Colors.purple,
    Colors.pink,
    Colors.green[800],
    Colors.grey[600],
    Colors.brown[500],
    Colors.amber,
  ];

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            color: kPrimaryColor,
            child: SpinKitWave(itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              );
            }),
          )
        : Scaffold(
            body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: kPrimaryColor,
                  pinned: true,
                  expandedHeight: 200,
                  floating: false,
                  flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                    "Schedule",
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                    ),
                  )),
                ),
              ];
            },
            body: SfCalendar(
              view: CalendarView.day,
              allowedViews: <CalendarView>[
                CalendarView.day,
                CalendarView.workWeek,
                CalendarView.month
              ],
              dataSource: MeetingDataSource(_getDataSource()),
              todayHighlightColor: kPrimaryColor,
              timeSlotViewSettings: TimeSlotViewSettings(
                startHour: 8,
                timeIntervalHeight: 70,
              ),
              monthViewSettings:
                  MonthViewSettings(showAgenda: true, agendaItemHeight: 70),
            ),
          ));
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var firebaseUser = await FirebaseAuth.instance.currentUser;
      DocumentSnapshot userDocument =
          await userCollection.doc(firebaseUser.email).get();
      var sem = userDocument.get('semester');

      DocumentSnapshot timetableDocument =
          await timeTableCollection.doc(sem).get();
      setState(() {
        _timetableList = timetableDocument.data();
      });

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  List<DateTime> getCurrentWeekDates() {
    final now = DateTime.now();
    final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return List.generate(7, (index) => index)
        .map((value) => firstDayOfWeek.add(Duration(days: value)))
        .toList();
  }

  Map<String, dynamic> getSubjectTime(currentDay, index) {
    List<Map<String, dynamic>> timings = [
      {
        'startTime': DateTime(
            currentDay.year, currentDay.month, currentDay.day, 9, 10, 0),
        'endTime': DateTime(
            currentDay.year, currentDay.month, currentDay.day, 10, 10, 0)
      },
      {
        'startTime': DateTime(
            currentDay.year, currentDay.month, currentDay.day, 10, 10, 0),
        'endTime': DateTime(
            currentDay.year, currentDay.month, currentDay.day, 11, 10, 0)
      },
      {
        'startTime': DateTime(
            currentDay.year, currentDay.month, currentDay.day, 11, 10, 0),
        'endTime': DateTime(
            currentDay.year, currentDay.month, currentDay.day, 12, 10, 0)
      },
      {
        'startTime': DateTime(
            currentDay.year, currentDay.month, currentDay.day, 12, 10, 0),
        'endTime': DateTime(
            currentDay.year, currentDay.month, currentDay.day, 13, 10, 0)
      },
      {
        'startTime': DateTime(
            currentDay.year, currentDay.month, currentDay.day, 13, 10, 0),
        'endTime': DateTime(
            currentDay.year, currentDay.month, currentDay.day, 13, 50, 0)
      },
      {
        'startTime': DateTime(
            currentDay.year, currentDay.month, currentDay.day, 13, 50, 0),
        'endTime': DateTime(
            currentDay.year, currentDay.month, currentDay.day, 14, 50, 0)
      },
      {
        'startTime': DateTime(
            currentDay.year, currentDay.month, currentDay.day, 14, 50, 0),
        'endTime': DateTime(
            currentDay.year, currentDay.month, currentDay.day, 15, 50, 0)
      },
      {
        'startTime': DateTime(
            currentDay.year, currentDay.month, currentDay.day, 15, 50, 0),
        'endTime': DateTime(
            currentDay.year, currentDay.month, currentDay.day, 16, 50, 0)
      },
    ];

    return timings[index];
  }


  List<Meeting> _getDataSource() {
    List<DateTime> currentWeekDates = getCurrentWeekDates();
    
    print('length=${_timetableList.length}');
    meetings = [];
    for (int i = 0; i < _daysList.length; i++) {
      for (int j = 0; j < 8; j++) {
        meetings.add(Meeting(
            eventName: _timetableList[_daysList[i]][j],
            from: getSubjectTime(currentWeekDates[i], j)['startTime'],
            to: getSubjectTime(currentWeekDates[i], j)['endTime'],
            background: _randomColors[j],
            isAllDay: false));
      }
    }
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting({this.eventName, this.from, this.to, this.background, this.isAllDay});

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}

