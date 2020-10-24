import 'package:demo/components/round_icon.dart';
import 'package:demo/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeButton extends StatelessWidget {

  final String title;
  final Function onPressed;
  final IconData icon;

  const HomeButton({Key key,@required this.title,@required this.onPressed,@required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundIcon(colour: kPrimaryColor,
          iconData: icon,
          onPressed: onPressed,
        ),
        SizedBox(height: 10.0),
        Text(title, style: GoogleFonts.openSans(fontWeight: FontWeight.w600),),
      ],
    );
  }
}