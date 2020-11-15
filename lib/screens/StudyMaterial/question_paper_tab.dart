import 'file:///D:/AndroidProjects/KCC-Portal/lib/components/study_material_components/semester_card.dart';
import 'package:demo/constants.dart';
import 'package:demo/util/study_material_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class QuestionPapersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        physics: ScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: [
          // SizedBox(height: size.height),
          Container(
            height: size.height * 0.3,
            width: size.width,
            margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: kPrimaryLightColor,
                    offset: Offset(-7, -7),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                  BoxShadow(
                    color: kPrimaryDarkColor,
                    offset: Offset(10, 10),
                    blurRadius: 10,
                    spreadRadius: 10,
                  ),
                ]),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Lottie.asset('assets/lottie/studyMaterialAnim.json'),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Select the Semester",
                      style: GoogleFonts.nunito(
                        fontSize: size.width * 0.07,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(
              8,
              (index) =>
                  SemesterCard(size: size, content: semesterInRoman[index]),
            ),
          ),
        ],
      ),
    );
  }
}
