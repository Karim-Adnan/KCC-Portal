import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo/components/reusable_cards.dart';
import 'package:demo/components/round_icon.dart';
import 'package:demo/constants.dart';
import 'package:demo/screens/time_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/my_clipper.dart';
import 'webview.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:demo/custom_drawer/drawer_user_controller.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: <Color>[
                                Color(0xFF2081F7),
                                Color(0xff1dc4d8),
                              ]),
                        ),
                        ),

                      ClipPath(
                        clipper: MyClipper(),
                        child: Container(
                          height: 140.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: <Color>[
                                  Color(0xFF2081F7),
                                  Color(0xff1dc4d8),
                                ]),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Welcome,",
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 22.0,
                                          ),
                                        ),
                                        TypewriterAnimatedTextKit(
                                          speed: Duration(milliseconds: 500),
                                          totalRepeatCount: 1,
                                          text: [
                                            "Username"
                                          ],
                                          textStyle: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 30.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    CircleAvatar(
                                      radius: 28.0,),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 170.0,
                          enlargeCenterPage: true,
                          // autoPlay: true,
                        ),
                        items: [
                          GestureDetector(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => WebViewContainer('https://organize.mlh.io/participants/events/3989-the-open-source-roadshow-kccitm', 'HacktoberFest 2k20')
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/hacktoberfest2020.jpeg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => WebViewContainer('https://dsc.community.dev/kcc-institute-of-technology-management/', 'DSC-KCCITM'))
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/DSC.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewContainer('http://kccitm.acm.org', 'ACM-KCCITM')));

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/ACM.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
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
                                Column(
                                  children: [
                                    RoundIcon(colour: kPrimaryColor,
                                      iconData: FontAwesomeIcons.table,
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => TimeTable()));
                                      },
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "Time Table",
                                    ),
                                  ],
                                ),

                                Column(
                                  children: [
                                    RoundIcon(colour: kPrimaryColor,
                                      iconData: Icons.video_call,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text("Class Schedule"),
                                  ],
                                ),
                                Column(
                                  children: [
                                    RoundIcon(colour: kPrimaryColor,
                                        iconData: Icons.home),
                                    SizedBox(height: 10.0),
                                    Text("Time Table"),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    RoundIcon(colour: kPrimaryColor,
                                        iconData: FontAwesomeIcons.table),
                                    SizedBox(height: 10.0),
                                    Text("Time Table"),
                                  ],
                                ),
                                Column(
                                  children: [
                                    RoundIcon(colour: kPrimaryColor,
                                        iconData: FontAwesomeIcons.table),
                                    SizedBox(height: 10.0),
                                    Text("Time Table"),
                                  ],
                                ),
                                Column(
                                  children: [
                                    RoundIcon(colour: kPrimaryColor,
                                        iconData: FontAwesomeIcons.table),
                                    SizedBox(height: 10.0),
                                    Text("Time Table"),
                                  ],
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
    );
  }
}






//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: AppDrawer(),
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(55.0),
//         child: AppBar(
//           backgroundColor: Color(0xff1dc4d8),
//           elevation: 0.0,
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                     colors: <Color>[
//                       Color(0xFF2081F7),
//                       Color(0xff1dc4d8),
//                     ])
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               ClipPath(
//                 clipper: MyClipper(),
//                 child: Container(
//                   height: 140.0,
//                   decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight,
//                           colors: <Color>[
//                             Color(0xFF2081F7),
//                             Color(0xff1dc4d8),
//                           ]),
//                   ),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 45.0),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Welcome,",
//                                   style: GoogleFonts.montserrat(
//                                       color: Colors.white,
//                                       fontWeight:
//                                       FontWeight.bold,
//                                       fontSize: 22.0,
//                                   ),
//                                 ),
//                                 TypewriterAnimatedTextKit(
//                                   speed: Duration(milliseconds: 500),
//                                   totalRepeatCount: 1,
//                                   text: [
//                                     "Username"
//                                   ],
//                                   textStyle: GoogleFonts.montserrat(
//                                     color: Colors.white,
//                                     fontWeight:
//                                     FontWeight.bold,
//                                     fontSize: 30.0,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             CircleAvatar(
//                               radius: 28.0,),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//
//               CarouselSlider(
//                 options: CarouselOptions(
//                   height: 170.0,
//                   enlargeCenterPage: true,
//                   // autoPlay: true,
//                 ),
//                 items: [
//                   GestureDetector(
//                     onTap: (){
//
//                       Navigator.push(context, MaterialPageRoute(
//                           builder: (context) => WebViewContainer('https://organize.mlh.io/participants/events/3989-the-open-source-roadshow-kccitm', 'HacktoberFest 2k20')
//                       ));
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                         image: DecorationImage(
//                           image: AssetImage('assets/images/hacktoberfest2020.jpeg'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: (){
//
//                       Navigator.push(context, MaterialPageRoute(
//                           builder: (context) => WebViewContainer('https://dsc.community.dev/kcc-institute-of-technology-management/', 'DSC-KCCITM'))
//                       );
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                         image: DecorationImage(
//                           image: AssetImage('assets/images/DSC.png'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: (){
//
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewContainer('http://kccitm.acm.org', 'ACM-KCCITM')));
//
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                         image: DecorationImage(
//                           image: AssetImage('assets/images/ACM.png'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               Container(
//                 margin: EdgeInsets.all(15.0),
//                 padding: EdgeInsets.all(20.0),
//                 decoration: BoxDecoration(
//                   color: Colors.transparent,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.white,
//                       blurRadius: 0, // soften the shadow
//                       spreadRadius: 1.0, //extend the shadow
//                       offset: Offset(
//                         5.0, // Move to right 10  horizontally
//                         5.0, // Move to bottom 10 Vertically
//                       ),
//                     )
//                   ],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Column(
//                           children: [
//                             RoundIcon(colour: Color(0xff1dc4d8),
//                                 iconData: FontAwesomeIcons.table,
//                               onPressed: () {
//                               Navigator.push(context, MaterialPageRoute(builder: (context) => TimeTable()));
//                               },
//                             ),
//                             SizedBox(height: 10.0),
//                             Text(
//                               "Time Table",
//                             ),
//                           ],
//                         ),
//
//                         Column(
//                           children: [
//                             RoundIcon(colour: Color(0xff1dc4d8),
//                                 iconData: Icons.video_call,
//                             ),
//                             SizedBox(height: 10.0),
//                             Text("Class Schedule"),
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             RoundIcon(colour: Color(0xff1dc4d8),
//                                 iconData: Icons.home),
//                             SizedBox(height: 10.0),
//                             Text("Time Table"),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Column(
//                           children: [
//                             RoundIcon(colour: Color(0xff1dc4d8),
//                                 iconData: FontAwesomeIcons.table),
//                             SizedBox(height: 10.0),
//                             Text("Time Table"),
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             RoundIcon(colour: Color(0xff1dc4d8),
//                                 iconData: FontAwesomeIcons.table),
//                             SizedBox(height: 10.0),
//                             Text("Time Table"),
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             RoundIcon(colour: Color(0xff1dc4d8),
//                                 iconData: FontAwesomeIcons.table),
//                             SizedBox(height: 10.0),
//                             Text("Time Table"),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               ReusableCard(
//                 colour: Colors.grey[400],
//                 height: 150.0,
//               ),
//               ReusableCard(
//                 colour: Colors.grey[400],
//                 height: 150.0,
//               ),
//               ReusableCard(
//                 colour: Colors.grey[400],
//                 height: 150.0,
//               ),
//             ]
//         ),
//       ),
//     );
//   }
// }