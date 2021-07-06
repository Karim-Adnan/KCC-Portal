import 'package:KCC_Portal/components/study_hub_components/notes_card_units.dart';
import 'package:KCC_Portal/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ClassNotesUnits extends StatefulWidget {
  final subject;

  const ClassNotesUnits({Key key, this.subject}) : super(key: key);
  @override
  _ClassNotesUnitsState createState() => _ClassNotesUnitsState();
}

class _ClassNotesUnitsState extends State<ClassNotesUnits> {
  List unitList=[
    'Unit 1',
    'Unit 2',
    'Unit 3',
    'Unit 4',
    'Unit 5'
  ];
  @override
  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        title: Text(
          widget.subject,
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
                      'assets/lottie/classNotesAnim.json'),
                ),
                Align(
                  alignment: Alignment(0, 1.5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Select Unit",
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
          Column(
              children: List.generate(
                unitList.length,
                (index) => NotesCardUnits(title: unitList[index], subject: widget.subject),
              ),
            ),
        ],
      ),
    );
  }
}