import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KYCAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final Color appbarBG;
  final double elevation;
  final Color iconColor;
  final double iconSize;
  final String title;
  final double appbarHeight;
  final double paddingHorizontal;
  final double paddingVertical;
  final Color titleColor;
  final double titleSize;
  final FontWeight titleWeight;

  KYCAppBar({
    @required this.appbarHeight,
    @required this.paddingHorizontal,
    @required this.paddingVertical,
    @required this.titleColor,
    @required this.titleSize,
    @required this.titleWeight,
    @required this.title,
    @required this.elevation,
    @required this.appbarBG,
    @required this.iconColor,
    @required this.iconSize,
  }) : preferredSize = Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AppBar(
      flexibleSpace: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.width * 0.1,
            ),
            Text(
              title,
              style: GoogleFonts.robotoMono(
                color: titleColor,
                fontSize: titleSize,
                fontWeight: titleWeight,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: appbarBG,
      automaticallyImplyLeading: true,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.chevron_left_rounded,
          color: iconColor,
          size: iconSize,
        ),
      ),
      elevation: elevation,
    );
  }
}
