import 'package:demo/screens/YearSelectionQuestionPaper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:demo/constants.dart';

class SemesterCard extends StatelessWidget {
  final Size size;
  final content;

  const SemesterCard({@required this.size, this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>SubjectSelectionQuestionPaper(sem: content)));
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => YearSelectionQuestionPaper(sem: content)),
        );
      },
      child: Container(
        height: size.height * 0.2,
        width: size.width * 0.4,
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
                content,
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
