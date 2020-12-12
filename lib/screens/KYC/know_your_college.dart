import 'package:KCC_Portal/components/kyc_components/kyc_appbar.dart';
import 'package:KCC_Portal/components/kyc_components/kyc_card.dart';
import 'package:KCC_Portal/constants.dart';
import 'package:flutter/material.dart';
import 'package:KCC_Portal/util/kyc_data.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class KnowYourCollege extends StatefulWidget {
  @override
  _KnowYourCollegeState createState() => _KnowYourCollegeState();
}

class _KnowYourCollegeState extends State<KnowYourCollege> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xF2DFFFFF),
      appBar: KYCAppBar(
        appbarBG: Color(0xF2DFFFFF),
        elevation: 0,
        iconSize: size.width * 0.1,
        iconColor: kPrimaryDarkColor,
        title: 'Know Your College',
        appbarHeight: size.width * 0.3,
        paddingHorizontal: size.width * 0.14,
        paddingVertical: null,
        titleColor: kPrimaryColor,
        titleSize: size.width * 0.09,
        titleWeight: FontWeight.w800,
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.width * 0.02,
            horizontal: size.width * 0.025,
          ),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            itemCount: imageList.length,
            itemBuilder: (context, index) => KYCImageCard(
              imageData: imageList[index],
            ),
            staggeredTileBuilder: (index) => StaggeredTile.count(
                (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
        ),
      ),
    );
  }
}
