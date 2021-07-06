import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescEndFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Text(
      "•",
      style: GoogleFonts.robotoSlab(
        fontSize: size.width * 0.065,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
