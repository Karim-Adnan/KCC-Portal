import 'package:KCC_Portal/components/placement_updates_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class PlacementUpdatesScreen extends StatefulWidget {
  @override
  _PlacementUpdatesScreenState createState() => _PlacementUpdatesScreenState();
}

class _PlacementUpdatesScreenState extends State<PlacementUpdatesScreen> {
  bool isLoading;
  List<Map<String, String>> _placementsData = [];

  void getData() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.Client().get(Uri.parse(
        'https://www.kccitm.edu.in/training-placement/placement-updates'));

    if (response.statusCode == 200) {
      var document = parse(response.body);
      var length = document
          .getElementById('aspnetForm')
          .getElementsByClassName('inner_section pt-3')[0]
          .getElementsByClassName("container pb-5")[0]
          .getElementsByClassName('row waterfall')[0]
          .getElementsByClassName('card')
          .length;

      print('length=$length');

      var placementCardData = document
          .getElementById('aspnetForm')
          .getElementsByClassName('inner_section pt-3')[0]
          .getElementsByClassName("container pb-5")[0];

      setState(() {
        for (var i = 0; i < length; i++) {
          var image = 'https://www.kccitm.edu.in' +
              placementCardData
                  .getElementsByClassName('card')[i]
                  .getElementsByTagName('a')[0]
                  .getElementsByTagName('img')[0]
                  .attributes['src']
                  .toString();

          var date = placementCardData
              .getElementsByClassName('card')[i]
              .getElementsByTagName('a')[0]
              .getElementsByClassName('card-body')[0]
              .getElementsByClassName('card-date')[0]
              .text
              .toString();

          var title = placementCardData
              .getElementsByClassName('card')[i]
              .getElementsByTagName('a')[0]
              .getElementsByClassName('card-body')[0]
              .getElementsByClassName('card-title')[0]
              .text
              .toString();

          _placementsData.add({'image': image, 'date': date, 'title': title});
        }

        // data.trimLeft();
      });

      print('data=$_placementsData');
    } else {
      throw Exception();
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Container(
              color: kPrimaryColor,
              child:
                  SpinKitWave(itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                );
              }),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.04),
                  Row(
                    children: [
                      IconButton(
                          padding: EdgeInsets.only(left: 20),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 25,
                          ),
                          onPressed: () => Navigator.pop(context)),
                      SizedBox(width: size.width * 0.06),
                      Text(
                        "Placement Updates",
                        maxLines: 2,
                        style: GoogleFonts.nunito(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  Container(
                      child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => PlacementUpdatesCard(
                      image: _placementsData[index]['image'],
                      date: _placementsData[index]['date'],
                      title: _placementsData[index]['title'],
                    ),
                    itemCount: _placementsData.length,
                  )),
                ],
              ),
            ),
    );
  }
}
