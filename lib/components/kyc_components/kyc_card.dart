import 'dart:ui';
import 'package:KCC_Portal/screens/KYC/know_your_college_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KCC_Portal/constants.dart';
import 'package:KCC_Portal/util/kyc_data.dart';
import 'package:page_transition/page_transition.dart';

class KYCImageCard extends StatelessWidget {
  final ImageData imageData;
  const KYCImageCard({
    @required this.imageData,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => Navigator.push(
        context,
        PageTransition(
          child: KYCDetailPage(
            title: imageData.imageTitle,
            image: imageData.imageAddress,
            description: imageData.imageDescription,
          ),
          type: PageTransitionType.fade,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueAccent,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(size.width * 0.0625),
          ),
          image: DecorationImage(
            image: AssetImage(
              imageData.imageAddress,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Divider(
              color: kSecondaryColor,
              thickness: 3,
              indent: size.width * 0.025,
              endIndent: size.width * 0.25,
              height: 0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.025,
                vertical: size.width * 0.025,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    size.width * 0.025,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 4.0,
                    sigmaY: 4.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          size.width * 0.025,
                        ),
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xffFFBE01),
                          Color(0xffFFBE01).withOpacity(0.6),
                          Color(0xffFFBE01).withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: size.width * 0.02,
                          ),
                          child: Text(
                            imageData.imageTitle,
                            style: GoogleFonts.nunito(
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    blurRadius: 12,
                                    offset: Offset(2, 2)),
                              ],
                              color: Colors.white,
                              fontSize: size.width * 0.036,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.white,
                          size: size.width * 0.1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
