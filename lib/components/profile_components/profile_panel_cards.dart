import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePanelCards extends StatelessWidget {
  final title;
  final overTitle;

  const ProfilePanelCards({
    @required this.overTitle,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(size.width * 0.025),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(size.width * 0.0125),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.lightBlue.withOpacity(0.35),
              borderRadius: BorderRadius.all(
                Radius.circular(size.width * 0.0125),
              ),
              border: Border.all(
                color: Colors.lightBlueAccent.withOpacity(0.1),
                width: size.width * 0.004,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.0125,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.width * 0.006,
                    ),
                    child: Text(
                      overTitle,
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.width * 0.006,
                    ),
                    child: Text(
                      title,
                      style: GoogleFonts.openSans(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
