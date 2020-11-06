import 'package:demo/constants.dart';
import 'package:demo/util/study_material_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesCard extends StatelessWidget {
  final index;

  const NotesCard({this.index});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(left: 25, right: 25, bottom: 20),
      height: size.height * 0.15,
      width: size.width * 0.1,
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
                    height: 60,
                    image: AssetImage('assets/icons/class_notes.png'),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      subjects[index],
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
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: [
      //     Image(
      //       height: 50,
      //       image: AssetImage('assets/icons/class_notes.png'),
      //     ),
      //     Text(
      //       subjects[index],
      //       style: GoogleFonts.nunito(
      //         fontSize: 32,
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
