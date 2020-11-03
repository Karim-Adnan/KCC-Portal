import 'package:demo/screens/view_pdf_screen.dart';
import 'package:demo/util/study_material_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../constants.dart';

class SubjectSelectionQuestionPaper extends StatelessWidget {
  final year;

  const SubjectSelectionQuestionPaper({Key key, this.year}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          year,
          style: GoogleFonts.nunito(color: Color(0xff5f8286), fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xff5f8286)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: size.height * 0.3,
            width: size.width,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/illustrations/study_material_subject_selection.jpg'),
                    fit: BoxFit.fitHeight),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xff5f8286).withOpacity(0.8),
                      offset: Offset(5, 5),
                      blurRadius: 5,
                      spreadRadius: 5)
                ]),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Select your Subject",
                  style: GoogleFonts.nunito(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: subjects.length,
              itemBuilder: (context, index) => QuestionPaperSubjectCard(subject: subjects[index],))
        ],
      ),
    );
  }
}

class QuestionPaperSubjectCard extends StatelessWidget {

  final subject;

  const QuestionPaperSubjectCard({
    Key key, this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPdfScreen()));
      },
      child: Container(
        height: 100,
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            // color: Color(0xff006c5f),
          color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Color(0xff5f8286).withOpacity(0.8),
                  offset: Offset(5, 5),
                  blurRadius: 5,
                  spreadRadius: 5)
            ]),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/icons/subject_book.png'),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  subject,
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    color: Color(0xff5f8286),
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//#5f8286
