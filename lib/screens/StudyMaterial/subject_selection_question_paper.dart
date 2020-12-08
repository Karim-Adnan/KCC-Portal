import 'package:KCC_Portal/components/study_material_components/question_paper_subject_card.dart';
import 'package:KCC_Portal/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubjectSelectionQuestionPaper extends StatefulWidget {
  final year;

  const SubjectSelectionQuestionPaper({this.year});

  @override
  _SubjectSelectionQuestionPaperState createState() =>
      _SubjectSelectionQuestionPaperState();
}

class _SubjectSelectionQuestionPaperState
    extends State<SubjectSelectionQuestionPaper> {
  List<String> subjects = [];

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var selectedSem = await prefs.getString("SelectedSem");
    var selectedYear = await prefs.getString("SelectedYear");
    print("selectedSem=$selectedSem selectedYear=$selectedYear");
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('questionPapers')
        .doc(selectedSem)
        .collection(selectedYear)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    setState(() {
      for (var document in documents) {
        subjects.add(document.reference.id);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      subjects.clear();
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        title: Text(
          widget.year,
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
                      "Select your Subject",
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
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: subjects.length,
            itemBuilder: (context, index) =>
                QuestionPaperSubjectCard(subject: subjects[index]),
          )
        ],
      ),
    );
  }
}




//#5f8286
