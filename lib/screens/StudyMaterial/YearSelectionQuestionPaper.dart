import 'package:KCC_Portal/components/study_material_components/question_paper_year_card.dart';
import 'package:KCC_Portal/constants.dart';
import 'package:KCC_Portal/util/study_material_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class YearSelectionQuestionPaper extends StatefulWidget {
  final sem;

  const YearSelectionQuestionPaper({this.sem});

  @override
  _YearSelectionQuestionPaperState createState() =>
      _YearSelectionQuestionPaperState();
}

class _YearSelectionQuestionPaperState
    extends State<YearSelectionQuestionPaper> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        title: Text(
          semesterMap[widget.sem.toString()],
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
                    child:
                        Lottie.asset('assets/lottie/studyMaterialAnim3.json'),
                  ),
                  Align(
                    alignment: Alignment(0, 1.5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Select your Year",
                        style: GoogleFonts.nunito(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: size.height * 0.03,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: year.length,
            itemBuilder: (context, index) =>
                QuestionPaperYearCard(year: year[index]),
            //     StudyMaterialCard(
            //   content: year[index],
            //   setPreference: () async {
            //      SharedPreferences prefs = await SharedPreferences.getInstance();
            //      await prefs.setString("SelectedYear", year[index]);
            //    },
            //    onTap: () async{
            //      SharedPreferences prefs = await SharedPreferences.getInstance();
            //      await prefs.setString("SelectedYear", year[index]);
            //      Navigator.push(
            //        context,
            //        PageTransition(
            //          type: PageTransitionType.fade,
            //          child: SubjectSelectionQuestionPaper(year: year[index]),
            //        ),
            //      );
            //    },
            //    image: "calendar.png",
            //    textStyle: GoogleFonts.nunito(
            //      fontSize: size.width * 0.08,
            //      fontWeight: FontWeight.w600,
            //      letterSpacing: 4,
            //   ),
            // ),
          )
        ],
      ),
    );
  }
}
