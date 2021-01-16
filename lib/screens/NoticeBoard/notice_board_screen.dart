import 'package:KCC_Portal/screens/NoticeBoard/college_events_tab.dart';
import 'package:KCC_Portal/screens/NoticeBoard/college_notices_tab.dart';
import 'package:KCC_Portal/screens/NoticeBoard/university_notices_tab.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';

class NoticeBoardScreen extends StatefulWidget {
  @override
  _NoticeBoardScreenState createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return [
            SliverAppBar(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              backgroundColor: kPrimaryColor,
              title: Text('Notice Board'),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.white,
                tabs: <Widget>[
                  Tab(
                    text: "University Notice",
                    icon: Icon(FontAwesomeIcons.bookReader),
                  ),
                  Tab(
                    text: "College Notice",
                    icon: Icon(FontAwesomeIcons.book),
                  ),
                  Tab(
                    text: "College Events",
                    icon: Icon(FontAwesomeIcons.book),
                  )
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          children: [
            UniversityNoticesTab(),
            CollegeNoticesTab(),
            CollegeEventsTab()
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
