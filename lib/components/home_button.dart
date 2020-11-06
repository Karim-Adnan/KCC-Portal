import 'package:demo/app_theme.dart';
import 'package:demo/components/round_icon.dart';
import 'package:demo/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final IconData icon;

  const HomeButton(
      {@required this.title, @required this.onPressed, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundIcon(
          colour: kPrimaryDarkColor.withOpacity(0.89),
          iconData: icon,
          onPressed: onPressed,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        Text(
          title,
          style: GoogleFonts.nunito(
            fontSize: MediaQuery.of(context).size.width * 0.037,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
