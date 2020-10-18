import 'package:demo/constants.dart';
import 'package:demo/screens/webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  void mail() async {
    final url = 'mailto:admissions@kccitm.edu.in';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: size.height * .4,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: size.height * .25,
                        width: size.width * .25,
                        child: Image.asset('assets/images/college_logo.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "KCC Institute of Technology and Management",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * .6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
              ),
              child: ListView(
                children: [
                  AboutCard(
                    iconData: Icons.location_on,
                    title: "2B-2C, Knowledge Park-III, Greater Noida, Uttar Pradesh 201306 · ~24.1 km",
                    head: "Visit us at",
                    onTap: () => openMap(28.469929,77.493657),
                  ),
                  SizedBox(height: 5.0,),
                  AboutCard(iconData: Icons.phone,
                    title: "092100 65555",
                    head: "Contact us at",
                    onTap: () =>  _makePhoneCall('tel:092100 65555'),
                  ),
                  SizedBox(height: 5.0,),
                  AboutCard(iconData: FontAwesomeIcons.globe,
                    title: "https://www.kccitm.edu.in/",
                    head: "Know us more",
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => WebViewContainer("https://www.kccitm.edu.in/", "KCCITM")
                    )),
                  ),
                  SizedBox(height: 5.0,),
                  AboutCard(iconData: Icons.mail,
                    head: "Mail us at",
                    title: " admissions@kccitm.edu.in",
                    onTap: () => mail(),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AboutIcon(iconData: FontAwesomeIcons.twitter, url: "https://twitter.com/KCCinstitutes", linkTitle: "Twitter",),
                          AboutIcon(iconData: FontAwesomeIcons.facebookF, url: "https://www.facebook.com/KCCinstitutes/", linkTitle: "Facebook",),
                          AboutIcon(iconData: FontAwesomeIcons.instagram, url: "https://www.instagram.com/kccinstitutes/", linkTitle: "Instagram",),
                          AboutIcon(iconData: FontAwesomeIcons.linkedinIn, url: "https://www.linkedin.com/school/kcc-institute-of-technology-and-management", linkTitle: "Linkedin",),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),


        ],

      ),
    );
  }
}

class AboutIcon extends StatelessWidget {

  final IconData iconData;
  final String url;
  final String linkTitle;

  const AboutIcon({
    Key key,
    this.iconData,
    this.url,
    this.linkTitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) => WebViewContainer(url, linkTitle)
      )),
      child: CircleAvatar(
        child: Icon(iconData, size: 25.0, color: Colors.white),
        backgroundColor: kPrimaryColor,
        radius: 25.0,),
    );
  }
}

class AboutCard extends StatelessWidget {

  final IconData iconData;
  final String title;
  final Function onTap;
  final String head;

  const AboutCard({
    Key key,
    this.iconData,
    this.title,
    this.onTap,
    this.head
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                head,
                style: TextStyle(fontSize: 20.0, color: Colors.grey[600]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(iconData, color: kPrimaryColor, size: 32.0,),
                SizedBox(width: 20.0,),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 3,
                    style: TextStyle(fontSize: 20.0, color: kPrimaryColor),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
