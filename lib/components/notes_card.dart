import 'package:demo/util/study_material_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesCard extends StatelessWidget {

  final index;

  const NotesCard({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: size.width,
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: colorGradients[index],
        ),
        boxShadow: [
          BoxShadow(
            color: colorGradients[index][1],
            offset: Offset(-5,0),
            spreadRadius: 2,
            blurRadius: 10,
           )
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image(
            height: 100,
            image: AssetImage('assets/illustrations/study_material.png'),
          ),
          Text(
            subjects[index],
            style: GoogleFonts.fondamento(
              fontSize: 32,
              color: Colors.white
            ),
          )
        ],
      ),
    );
  }
}

