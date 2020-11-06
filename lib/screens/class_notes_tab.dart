import 'package:demo/components/notes_card.dart';
import 'package:demo/constants.dart';
import 'package:flutter/material.dart';

class ClassNotesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ListView(
        physics: ScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: List.generate(
          6,
          (index) => NotesCard(index: index),
        ),
      ),
    );
  }
}

// ListView.builder(itemCount: 6, itemBuilder: (context, index) => NotesCard(index: index), physics: ScrollPhysics(parent: BouncingScrollPhysics(),),),
