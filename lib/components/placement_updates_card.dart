import 'package:KCC_Portal/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlacementUpdatesCard extends StatelessWidget {
  final image, date, title;

  const PlacementUpdatesCard({Key key, this.image, this.date, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            spreadRadius: 5,
            offset: Offset(5, 5)),
      ], borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(
        child: Column(
          children: [
            Container(
              height: size.height * 0.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.fill)),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.03,
                    width: double.infinity,
                    color: kPrimaryColor,
                    child: FittedBox(
                      child: Text(
                        date,
                        style: GoogleFonts.nunito(color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(title,
                              softWrap: true,
                              maxLines: 10,
                              style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
