import 'package:KCC_Portal/components/study_hub_components/notes_card.dart';
import 'package:KCC_Portal/constants.dart';
import 'package:KCC_Portal/screens/view_pdf_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class ClassNotesSubject extends StatefulWidget {
  final subjectList;
  final title;

  const ClassNotesSubject({Key key, this.subjectList, this.title})
      : super(key: key);
  @override
  _ClassNotesSubjectState createState() => _ClassNotesSubjectState();
}

class _ClassNotesSubjectState extends State<ClassNotesSubject> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        title: Text(
          widget.title,
          style: GoogleFonts.nunito(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: 4,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
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
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: kPrimaryDarkColor,
                  offset: Offset(0, 0),
                  blurRadius: 10,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Lottie.asset(
                      'assets/lottie/subject_select_question_paper.json'),
                ),
                Align(
                  alignment: Alignment(0, 1.5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Select PDF",
                      style: GoogleFonts.nunito(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Column(
            children: List.generate(
              widget.subjectList.length,
              (index) => NotesCard(
                title: widget.subjectList[index]['subject'],
                isPDF: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: ViewPdfScreen(
                          url: widget.subjectList[index]['path'].toString(),
                          appBarTitle: widget.subjectList[index]['subject'].toString()),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
