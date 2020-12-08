import 'package:KCC_Portal/constants.dart';
import 'package:KCC_Portal/screens/view_pdf_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';


class QuestionPaperSubjectCard extends StatefulWidget {
  final subject;

  const QuestionPaperSubjectCard({this.subject});

  @override
  _QuestionPaperSubjectCardState createState() =>
      _QuestionPaperSubjectCardState();
}

class _QuestionPaperSubjectCardState extends State<QuestionPaperSubjectCard> {



  void setPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("SelectedSubject", widget.subject);
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
              child: ViewPdfScreen(),
            ),
          );
        },
        child: Card(
          color: Colors.white.withOpacity(0.9),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image(
                    height: 50,
                    image: AssetImage('assets/icons/class_notes.png'),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: Text(
                      widget.subject,
                      style: GoogleFonts.nunito(
                        fontSize: size.width * 0.038,
                        fontWeight: FontWeight.w700,
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