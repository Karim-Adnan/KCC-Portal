import 'package:demo/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Don’t have an Account ? " : "Already have an Account ? ",
            style: GoogleFonts.nunito(
              fontSize: 15,
              color: kPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "LogIn",
            style: GoogleFonts.nunito(
              fontSize: 15,
              color: kPrimaryColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        )
      ],
    );
  }
}
