import 'package:KCC_Portal/components/kyc_components/description_container.dart';
import 'package:KCC_Portal/components/kyc_components/description_end_footer.dart';
import 'package:KCC_Portal/components/kyc_components/details_image_scrim.dart';
import 'package:KCC_Portal/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KYCDetailPage extends StatelessWidget {
  final image;
  final title;
  final description;

  const KYCDetailPage({this.image, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                DetailsImageScrim(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.width * 0.15,
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.robotoSlab(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Divider(
                          color: kSecondaryColor,
                          thickness: size.width * 0.0125,
                          height: size.width * 0.075,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.width * 0.12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.chevron_left_rounded,
                              color: kPrimaryColor,
                              size: size.width * 0.1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: DescContainer(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06,
                  vertical: size.width * 0.01,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        description,
                        style: GoogleFonts.montserrat(
                          fontSize: size.width * 0.034,
                          color: Colors.blueGrey[700],
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                          wordSpacing: 0.5,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DescEndFooter(),
                          DescEndFooter(),
                          DescEndFooter(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}