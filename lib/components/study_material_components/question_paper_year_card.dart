import 'package:demo/constants.dart';
import 'package:demo/screens/StudyMaterial/subject_selection_question_paper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionPaperYearCard extends StatefulWidget {
  final year;

  const QuestionPaperYearCard({this.year});

  @override
  _QuestionPaperYearCardState createState() => _QuestionPaperYearCardState();
}

class _QuestionPaperYearCardState extends State<QuestionPaperYearCard> {
  void setPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("SelectedYear", widget.year);
  }

  @override
  void initState() {
    super.initState();
    setPreference();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: size.height * 0.15,
      width: size.width * 0.1,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kPrimaryLightColor,
            offset: Offset(-5, -5),
            blurRadius: 10,
            spreadRadius: 5,
          ),
          BoxShadow(
            color: kPrimaryDarkColor,
            offset: Offset(5, 5),
            blurRadius: 10,
            spreadRadius: 10,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          setPreference();
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: SubjectSelectionQuestionPaper(year: widget.year),
            ),
          );
        },
        child: Card(
          color: Colors.white.withOpacity(0.9),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    flex: 1,
                    child: Image(
                      height: 50,
                      image: AssetImage('assets/icons/calendar.png'),
                    )),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      widget.year,
                      style: GoogleFonts.nunito(
                        fontSize: size.width * 0.08,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}