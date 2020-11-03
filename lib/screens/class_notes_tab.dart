import 'package:demo/components/notes_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClassNotesTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(itemCount: 6, itemBuilder: (context, index) => NotesCard(index: index,), physics: ScrollPhysics(parent: BouncingScrollPhysics()),),
    );
  }
}