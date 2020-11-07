import 'package:demo/screens/YearSelectionQuestionPaper.dart';
import 'package:demo/util/study_material_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:demo/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SemesterCard extends StatefulWidget {
  final Size size;
  final content;

  const SemesterCard({@required this.size, this.content});

  @override
  _SemesterCardState createState() => _SemesterCardState();
}

class _SemesterCardState extends State<SemesterCard> {

  void setPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("SelectedSem", semesterInNumber[widget.content]);
  }

  @override
  void initState() {
    super.initState();
    setPreference();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>SubjectSelectionQuestionPaper(sem: content)));
        setPreference();
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: YearSelectionQuestionPaper(sem: widget.content)
          )
        );
      },
      child: Container(
        height: widget.size.height * 0.2,
        width: widget.size.width * 0.4,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: kPrimaryLightColor,
              offset: Offset(-0.5, -0.5),
              blurRadius: 10,
              spreadRadius: 5,
            ),
            BoxShadow(
              color: kPrimaryDarkColor,
              offset: Offset(10, 10),
              blurRadius: 10,
              spreadRadius: 10,
            ),
          ],
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                widget.content,
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.white24,
                      offset: Offset(1.5, 0.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
