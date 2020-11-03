import 'package:demo/components/semester_card.dart';
import 'package:demo/util/study_material_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../constants.dart';

class QuestionPapersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            height: size.height * 0.3,
            width: size.width,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: kPrimaryColor.withOpacity(0.4),
                      offset: Offset(5, 5),
                      blurRadius: 5,
                      spreadRadius: 5)
                ]),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child:
                        Lottie.asset('assets/lottie/studyMaterialAnim.json')),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Select your Semester",
                      style: GoogleFonts.nunito(
                        fontSize: 25,
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
                (index) => SemesterCard(
                      size: size,
                      content: semesterInRoman[index],
                    )),
          )
        ],
      ),
    );
  }
}
