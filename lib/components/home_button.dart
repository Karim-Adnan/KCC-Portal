import 'package:KCC_Portal/components/round_icon.dart';
import 'package:KCC_Portal/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final String image;

  const HomeButton(
      {@required this.title, @required this.onPressed, @required this.image});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.025,
        ),
        RoundIcon(
          colour: kPrimaryDarkColor.withOpacity(0.9),
          imageData: image,
          onPressed: onPressed,
        ),
        SizedBox(
          height: size.height * 0.015,
        ),
        Text(
          title,
          softWrap: true,
          maxLines: 2,
          style: GoogleFonts.nunito(
            fontSize: size.width * 0.037,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.white.withOpacity(0.3),
                offset: Offset(1,1),
                blurRadius: size.width * 0.03,
              ),
            ]
          ),
        ),
      ],
    );
  }
}
