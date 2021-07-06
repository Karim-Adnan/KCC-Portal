import 'package:KCC_Portal/components/triangle_painter.dart';
import 'package:KCC_Portal/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableCard extends StatelessWidget {
  final Color colour;
  final Function onPress;
  final double height;
  final String title;
  final String trianglePainterTitle;
  ReusableCard(
      {@required this.colour,
      this.onPress,
      @required this.height,
      this.title,
      this.trianglePainterTitle});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPress,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: height,
              width: size.width,
              decoration: BoxDecoration(
                color: colour,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[500],
                      spreadRadius: 1,
                      offset: Offset(0, 0),
                      blurRadius: 5)
                ],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 2),
                image: DecorationImage(
                  image: AssetImage('assets/images/KCCLogo.png'),
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.dstATop),
                ),
              ),
              child: Center(
                child: Text(
                  title,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              margin: EdgeInsets.all(15.0),
            ),
          ),
          Positioned(
            left: size.width * 0.6,
            top: size.height * 0.007,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 8.0,
                  width: 10,
                  child: CustomPaint(
                    painter: TrianglePainter(),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6.0),
                          bottomLeft: Radius.circular(6.0))),
                  width: size.width * 0.35,
                  height: 30.0,
                  child: Center(
                    child: Text(
                      trianglePainterTitle,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
