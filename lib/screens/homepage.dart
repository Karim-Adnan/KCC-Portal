import 'package:KCC_Portal/components/home_button.dart';
import 'package:KCC_Portal/components/my_clipper.dart';
import 'package:KCC_Portal/components/reusable_cards.dart';
import 'package:KCC_Portal/components/slider_item.dart';
import 'package:KCC_Portal/constants.dart';
import 'package:KCC_Portal/database.dart';
import 'package:KCC_Portal/screens/user_profile.dart';
import 'package:KCC_Portal/screens/view_pdf_screen.dart';
import 'package:KCC_Portal/util/home_button_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream myStream;
  var isLoading = false;
  List<Map<String, dynamic>> _notices = [];

  getStream() async {
    setState(() {
      isLoading = true;
    });
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    setState(() {
      myStream = userCollection.doc(firebaseUser.email).snapshots();
    });

    setState(() {
      isLoading = false;
    });
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    final DocumentSnapshot documents =
        await noticeCollection.doc('UniversityNotices').get();

    setState(() {
      documents.data().forEach((key, value) {
        _notices.add({
          'notice': key.toString(),
          'link': value['link'].toString(),
          'date': value['date'].toString()
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    getStream();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return isLoading
        ? SpinKitWave(itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            );
          })
        : Scaffold(
            backgroundColor: Colors.white,
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
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      expandedHeight: size.width * 0.6,
                      floating: true,
                      pinned: false,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: ClipPath(
                          clipper: MyClipper(),
                          child: StreamBuilder(
                              stream: myStream,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                }
                                return Container(
                                  decoration: BoxDecoration(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Welcome,",
                                            style: GoogleFonts.openSans(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.width * 0.08,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data['first name'],
                                            style: GoogleFonts.openSans(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.width * 0.05,
                                            ),
                                          )
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
                                          radius: size.width * 0.1,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  ];
                },
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView(
                        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: size.width * 0.41,
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
                            margin: EdgeInsets.all(size.width * 0.025),
                            padding: EdgeInsets.all(size.width * 0.025),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.05),
                            ),
                            child: StaggeredGridView.countBuilder(
                              crossAxisCount: 3,
                              crossAxisSpacing: size.width * 0.025,
                              mainAxisSpacing: size.width * 0.025,
                              shrinkWrap: true,
                              itemCount: 6,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, index) => HomeButton(
                                title: homeButtonData[index][0].toString(),
                                onPressed: () => Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: homeButtonData[index][1],
                                  ),
                                ),
                                image: homeButtonData[index][2],
                              ),
                              staggeredTileBuilder: (int index) =>
                                  new StaggeredTile.count(1, 1),
                            ),
                          ),

                          //Notice Cards
                          Container(
                              child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => ReusableCard(
                              title: _notices[index]['notice'],
                              trianglePainterTitle: _notices[index]['date'],
                              onPress: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewPdfScreen(
                                            appBarTitle: _notices[index]
                                                ['notice'],
                                            url: _notices[index]['link'],
                                          ))),
                              colour: Colors.grey[200],
                              height: size.height * 0.18,
                            ),
                            itemCount: _notices.length,
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
