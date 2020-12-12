import 'package:KCC_Portal/constants.dart';
import 'package:KCC_Portal/util/kyc_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KYCImageCard extends StatelessWidget {
  final ImageData imageData;
  const KYCImageCard({
    @required this.imageData,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(25),
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
              color: kPrimaryLightColor,
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
              child: Container(
                // height: size.width * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      size.width * 0.025,
                    ),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      kPrimaryColor,
                      kPrimaryColor,
                      kPrimaryLightColor.withOpacity(0.6),
                      kPrimaryLightColor.withOpacity(0.1),
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
                          color: Colors.white,
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w600,
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
          ],
        ),
      ),
    );
  }
}