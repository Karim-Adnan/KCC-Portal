import 'package:demo/screens/subject_selection_question_paper.dart';
import 'package:demo/util/study_material_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YearSelectionQuestionPaper extends StatelessWidget {
  final sem;

  const YearSelectionQuestionPaper({Key key, this.sem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          semesterMap[sem.toString()],
          style: GoogleFonts.nunito(
              color: Color(0xffAFA5EF), fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffAFA5EF),
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
                  // image: DecorationImage(
                  //     image: AssetImage(
                  //         'assets/illustrations/study_material_year_selection.jpg'),
                  //     fit: BoxFit.fitHeight),
                  color: Color(0xffAFA5EF).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xffAFA5EF).withOpacity(0.5),
                        offset: Offset(5, 5),
                        blurRadius: 5,
                        spreadRadius: 5)
                  ]),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child:
                        Lottie.asset('assets/lottie/studyMaterialAnim3.json'),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Select your Year",
                        style: GoogleFonts.nunito(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: year.length,
              itemBuilder: (context, index) => QuestionPaperYearCard(
                    year: year[index],
                  ))
        ],
      ),
    );
  }
}

class QuestionPaperYearCard extends StatefulWidget {
  final year;

  const QuestionPaperYearCard({
    Key key,
    this.year,
  }) : super(key: key);

  @override
  _QuestionPaperYearCardState createState() => _QuestionPaperYearCardState();
}

class _QuestionPaperYearCardState extends State<QuestionPaperYearCard> {

  void setPreference() async{
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
    return GestureDetector(
      onTap: () {
        setPreference();
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: SubjectSelectionQuestionPaper(year: widget.year)));
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
                  color: Color(0xffAFA5EF).withOpacity(0.8),
                  offset: Offset(5, 5),
                  blurRadius: 5,
                  spreadRadius: 5)
            ]),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/icons/calendar.png'),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.year,
                  style: GoogleFonts.nunito(
                      fontSize: 20,
                      color: Color(0xffAFA5EF),
                      fontWeight: FontWeight.w800),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//#5F466E

//#FF6489
//#AFA5EF
