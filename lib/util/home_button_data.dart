import 'package:KCC_Portal/screens/Forum/forum_screen.dart';
import 'package:KCC_Portal/screens/KYC/know_your_college.dart';
import 'package:KCC_Portal/screens/StudyMaterial/study_hub.dart';
import 'package:KCC_Portal/screens/NoticeBoard/notice_board_screen.dart';
import 'package:KCC_Portal/screens/placement_updates_screen.dart';
import 'package:KCC_Portal/screens/schedule_screen.dart';

List<dynamic> homeButtonData = [
  ["Schedule", ScheduleScreen(), "assets/icons/homeButtons/timeTable.png"],
  ["StudyHub", StudyHub(),  "assets/icons/homeButtons/studyHub.png"],
  ["Forum", ForumPage(), "assets/icons/homeButtons/forum.png"],
  ["College", KnowYourCollege(), "assets/icons/homeButtons/KYC.png"],
  ["Placements", PlacementUpdatesScreen(), "assets/icons/homeButtons/placement.png"],
  ["Notice Board", NoticeBoardScreen(), "assets/icons/homeButtons/placement.png"],
];