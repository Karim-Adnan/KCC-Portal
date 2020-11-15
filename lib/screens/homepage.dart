import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo/components/home_button.dart';
import 'package:demo/components/my_clipper.dart';
import 'package:demo/components/reusable_cards.dart';
import 'package:demo/components/slider_item.dart';
import 'package:demo/constants.dart';
import 'package:demo/database.dart';
import 'file:///D:/AndroidProjects/KCC-Portal/lib/screens/Forum/forum_screen.dart';
import 'file:///D:/AndroidProjects/KCC-Portal/lib/screens/StudyMaterial/study_material.dart';
import 'package:demo/screens/time_table.dart';
import 'package:demo/screens/user_profile.dart';
import 'package:demo/util/home_button_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream myStream;
  getStream() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    setState(() {
      myStream = userCollection.doc(firebaseUser.email).snapshots();
    });
  }

  @override
  void initState() {
    super.initState();
    getStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              kPrimaryLightColor,
              kPrimaryColor,
              kPrimaryDarkColor,
            ],
          ),
        ),
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 200.0,
                floating: true,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: StreamBuilder(
                      stream: myStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        return ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: kPrimaryDarkColor,

                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: <Color>[
                                  kSecondaryColor,
                                  kPrimaryColor,
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Welcome,",
                                      style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                .08,
                                      ),
                                    ),
                                    TypewriterAnimatedTextKit(
                                      speed: Duration(milliseconds: 500),
                                      totalRepeatCount: 1,
                                      text: [snapshot.data['first name']],
                                      textStyle: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: UserProfilePage(),
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        snapshot.data['profilePic']),
                                    radius: 38.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ];
          },
          body:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(height: 15.0),
            Expanded(
              child: ListView(
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 170.0,
                      enlargeCenterPage: true,
                    ),
                    items: [
                      SliderItem(
                        url:
                            'https://organize.mlh.io/participants/events/3989-the-open-source-roadshow-kccitm',
                        linkTitle: 'HacktoberFest 2k20',
                        image: 'hacktoberfest2020.jpeg',
                      ),
                      SliderItem(
                        url:
                            'https://dsc.community.dev/kcc-institute-of-technology-management/',
                        linkTitle: 'DSC-KCCITM',
                        image: 'DSC.png',
                      ),
                      SliderItem(
                        url: 'http://kccitm.acm.org',
                        linkTitle: 'ACM-KCCITM',
                        image: 'ACM.png',
                      ),
                    ],
                  ),

                  // Navigation Buttons
                  Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(
                        6,
                        (index) => HomeButton(
                          title: homeButtonData[index][0].toString(),
                          onPressed: () => Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: homeButtonData[index][1]),
                          ),
                          icon: homeButtonData[index][2],
                        ),
                      ),
                    ),
                  ),

                  // Cards
                  ReusableCard(
                    cardChild: Card(),
                    colour: Colors.white,
                    height: 150.0,
                  ),
                  ReusableCard(
                    cardChild: Card(),
                    colour: Colors.white,
                    height: 150.0,
                  ),
                  ReusableCard(
                    cardChild: Card(),
                    colour: Colors.white,
                    height: 150.0,
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
