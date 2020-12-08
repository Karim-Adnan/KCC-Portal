
import 'package:KCC_Portal/components/study_material_components/notes_card.dart';
import 'package:KCC_Portal/constants.dart';
import 'package:flutter/material.dart';

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
