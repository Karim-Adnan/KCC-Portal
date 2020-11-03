
import 'package:demo/screens/YearSelectionQuestionPaper.dart';
import 'package:demo/screens/subject_selection_question_paper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class SemesterCard extends StatelessWidget {

  final Size size;
  final content;

  const SemesterCard({
    Key key,
    @required this.size, this.content,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>SubjectSelectionQuestionPaper(sem: content)));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>YearSelectionQuestionPaper(sem: content)));
      },
      child: Container(
        height: size.height * 0.2,
        width: size.width * 0.4,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: kPrimaryColor.withOpacity(0.4),
                offset: Offset(5,5),
                blurRadius: 5,
                spreadRadius: 5
            )
          ],
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                content,
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.white24,
                      offset: Offset(1.5,0.5),
                      blurRadius: 5,
                    )
                  ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}