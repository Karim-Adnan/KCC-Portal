import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo/components/home_button.dart';
import 'package:demo/components/my_clipper.dart';
import 'package:demo/components/reusable_cards.dart';
import 'package:demo/components/slider_item.dart';
import 'package:demo/database.dart';
import 'package:demo/screens/time_table.dart';
import 'package:demo/screens/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream myStream;
  getStream() async{
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    setState(() {
      myStream = userCollection
          .doc(firebaseUser.email).snapshots();
    });
  }
  @override
  void initState(){
    super.initState();
    getStream();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: StreamBuilder(
                      stream: myStream,
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return CircularProgressIndicator();
                        }
                        return ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: <Color>[
                                    Color(0xFF2081F7),
                                    Color(0xff1dc4d8),
                                  ]),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Welcome,",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.of(context).size.width * .08,
                                      ),
                                    ),
                                    TypewriterAnimatedTextKit(
                                      speed: Duration(milliseconds: 500),
                                      totalRepeatCount: 1,
                                      text: [
                                        snapshot.data['first name'],
                                      ],
                                      textStyle: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.of(context).size.width * .05,
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>UserProfilePage(),),
                                  ),
                                  child: CircleAvatar(
                                    radius: 38.0,),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                ),
              ),
            ];
          },
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.0),
                Expanded(
                  child: ListView(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 170.0,
                          enlargeCenterPage: true,
                        ),
                        items: [
                          SliderItem(
                            url: 'https://organize.mlh.io/participants/events/3989-the-open-source-roadshow-kccitm',
                            linkTitle: 'HacktoberFest 2k20',
                            image: 'hacktoberfest2020.jpeg',
                          ),
                          SliderItem(
                            url: 'https://dsc.community.dev/kcc-institute-of-technology-management/',
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

                      Container(
                        margin: EdgeInsets.all(15.0),
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 0, // soften the shadow
                              spreadRadius: 1.0, //extend the shadow
                              offset: Offset(
                                5.0, // Move to right 10  horizontally
                                5.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                HomeButton(
                                    title: "Time Table",
                                    onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => TimeTable())),
                                    icon: FontAwesomeIcons.table,
                                ),
                                HomeButton(
                                  title: "Time Table",
                                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => TimeTable())),
                                  icon: FontAwesomeIcons.table,
                                ),
                                HomeButton(
                                  title: "Time Table",
                                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => TimeTable())),
                                  icon: FontAwesomeIcons.table,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                HomeButton(
                                  title: "Time Table",
                                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => TimeTable())),
                                  icon: FontAwesomeIcons.table,
                                ),
                                HomeButton(
                                  title: "Time Table",
                                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => TimeTable())),
                                  icon: FontAwesomeIcons.table,
                                ),
                                HomeButton(
                                  title: "Time Table",
                                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => TimeTable())),
                                  icon: FontAwesomeIcons.table,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      ReusableCard(
                        colour: Colors.grey[400],
                        height: 150.0,
                      ),
                      ReusableCard(
                        colour: Colors.grey[400],
                        height: 150.0,
                      ),
                      ReusableCard(
                        colour: Colors.grey[400],
                        height: 150.0,
                      ),
                    ],
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
}



