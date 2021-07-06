import 'package:KCC_Portal/components/study_hub_components/notes_card.dart';
import 'package:KCC_Portal/constants.dart';
import 'package:KCC_Portal/database.dart';
import 'package:KCC_Portal/screens/StudyMaterial/class_notes_units.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

class ClassNotesTab extends StatefulWidget {
  @override
  _ClassNotesTabState createState() => _ClassNotesTabState();
}

class _ClassNotesTabState extends State<ClassNotesTab> {
  List _subjectsList = [];
  bool isLoading = false;

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var firebaseUser = await FirebaseAuth.instance.currentUser;
      DocumentSnapshot userDocument =
          await userCollection.doc(firebaseUser.email).get();
      var sem = userDocument.get('semester');

      DocumentSnapshot subjectDocument =
          await subjectNamesCollection.doc(sem).get();
      _subjectsList = subjectDocument.get('subjectNames');
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _subjectsList.clear();
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return isLoading
        ? SpinKitWave(itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            );
          })
        : Scaffold(
            backgroundColor: kPrimaryColor,
            body: ListView(
              physics: ScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              children: List.generate(
                _subjectsList.length,
                (index) => NotesCard(
                  index: index,
                  title: _subjectsList[index],
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: ClassNotesUnits(subject: _subjectsList[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
  }
}
