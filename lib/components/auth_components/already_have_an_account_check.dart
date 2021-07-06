import 'package:KCC_Portal/constants.dart';
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
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: press,
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              login ? "Don’t have an Account ? " : "Already have an Account ? ",
              style: GoogleFonts.nunito(
                fontSize: 15,
                color: kPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              login ? "Sign Up" : "LogIn",
              style: GoogleFonts.nunito(
                fontSize: 15,
                color: kPrimaryColor,
                fontWeight: FontWeight.w800,
              ),
            )
          ],
        ),
      ),
    );
  }
}
