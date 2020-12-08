
import 'package:KCC_Portal/components/about_card.dart';
import 'package:KCC_Portal/constants.dart';
import 'package:KCC_Portal/screens/webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:page_transition/page_transition.dart';

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

  Future<void> openMap(double latitude, double longitude) async {
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
      backgroundColor: kPrimaryDarkColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: size.height * .4,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: size.height * 0.4,
                          width: size.width * 0.8,
                          child: Lottie.asset('assets/lottie/aboutScreenAnim.json'),
                          // Image.asset('assets/illustrations/about_us.png'),
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
                padding: EdgeInsets.zero,
                children: [
                  AboutCard(
                    iconData: Icons.location_on,
                    title: "2B-2C, Knowledge Park-III, Greater Noida, Uttar Pradesh 201306",
                    head: "Visit us at:",
                    onTap: () => openMap(28.469929,77.493657),
                  ),
                  SizedBox(height: 5.0,),
                  AboutCard(iconData: Icons.phone,
                    title: "+91 92100 65555",
                    head: "Contact us at:",
                    onTap: () =>  _makePhoneCall('tel:092100 65555'),
                  ),
                  SizedBox(height: 5.0,),
                  AboutCard(iconData: FontAwesomeIcons.globe,
                    title: "kccitm.edu.in",
                    head: "Know us more:",
                    onTap: () => Navigator.push(context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: WebViewContainer("https://www.kccitm.edu.in/", "KCCITM"),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  AboutCard(iconData: Icons.mail,
                    head: "Mail us at",
                    title: "admissions@kccitm.edu.in",
                    onTap: () => mail(),
                  ),

                  Divider(
                    height: 20.0,
                    thickness: 0.8,
                    color: Colors.grey[500],
                    indent: 25.0,
                    endIndent: 25.0,
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
  AboutIcon({
    Key key,
    this.iconData,
    this.url,
    this.linkTitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, CupertinoPageRoute(
          builder: (context) => WebViewContainer(url, linkTitle)
      )),
      child: CircleAvatar(
        child: Icon(iconData, size: kAboutIconSize, color: Colors.white),
        backgroundColor: kPrimaryDarkColor,
        radius: kAboutIconSize,),
    );
  }
}



class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}