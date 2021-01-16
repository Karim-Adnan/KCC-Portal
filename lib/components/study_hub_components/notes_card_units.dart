import 'package:KCC_Portal/constants.dart';
import 'package:KCC_Portal/database.dart';
import 'package:KCC_Portal/screens/StudyMaterial/class_notes_subjects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:page_transition/page_transition.dart';

class NotesCardUnits extends StatefulWidget {
  final title;
  final subject;

  const NotesCardUnits({Key key, this.title, this.subject}) : super(key: key);
  @override
  _NotesCardUnitsState createState() => _NotesCardUnitsState();
}

class _NotesCardUnitsState extends State<NotesCardUnits> {
  List<Map<String, dynamic>> _subjectList = [];

  loadSubjects() async {
    _subjectList.clear();
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDocument =
        await userCollection.doc(firebaseUser.email).get();
    var sem = userDocument.get('semester');

    firebase_storage.ListResult result = await firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('subjectNames')
        .child(sem)
        .child(widget.subject)
        .child(widget.title)
        .listAll();
      await Future.wait(result.items.map((firebase_storage.Reference ref) async {
          String downloadURL = await ref.getDownloadURL();
            _subjectList.add({'subject': ref.name, 'path': downloadURL});
           print('Found file: $downloadURL');
        }));
    // result.items.forEach((firebase_storage.Reference ref) async{
    //   String downloadURL = await ref.getDownloadURL();
    //   _subjectList.add({'subject': ref.name, 'path': downloadURL});
    //   print('Found file: ${ref.getDownloadURL()}');
    // });
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: ClassNotesSubject(
          subjectList: _subjectList,
          title: widget.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(left: 25, right: 25, bottom: 20),
      height: size.height * 0.15,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kPrimaryLightColor,
            offset: Offset(-0.5, -0.5),
            blurRadius: 10,
            spreadRadius: 5,
          ),
          BoxShadow(
            color: kPrimaryDarkColor,
            offset: Offset(10, 10),
            blurRadius: 10,
            spreadRadius: 10,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          loadSubjects();
          // Navigator.push(
          //   context,
          //   PageTransition(
          //     type: PageTransitionType.fade,
          //     child: ClassNotesUnits(subject: widget.title),
          //   ),
          // );
        },
        child: Card(
          color: Colors.white.withOpacity(0.9),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Image(
                    height: 50,
                    image: AssetImage('assets/icons/class_notes_units.png'),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      widget.title.toString(),
                      style: GoogleFonts.nunito(
                        fontSize: size.width * 0.1,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
