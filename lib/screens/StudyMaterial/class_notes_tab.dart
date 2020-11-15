import 'file:///D:/AndroidProjects/KCC-Portal/lib/components/study_material_components/notes_card.dart';
import 'package:demo/components/study_material_components/study_material_cards.dart';
import 'package:demo/constants.dart';
import 'package:demo/util/study_material_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClassNotesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ListView(
        physics: ScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: List.generate(
          6,
          (index) => NotesCard(index: index),
          // (index) => StudyMaterialCard(
          //   content: subjectsData[index],
          //   setPreference: () {},
          //   onTap: () { },
          //   image: "class_notes.png",
          //   textStyle: GoogleFonts.nunito(
          //     fontSize: size.width * 0.1,
          //     fontWeight: FontWeight.w600,
          //     letterSpacing: 4,
          //   ),
          // ),
        ),
      ),
    );
  }
}

// ListView.builder(itemCount: 6, itemBuilder: (context, index) => NotesCard(index: index), physics: ScrollPhysics(parent: BouncingScrollPhysics(),),),
