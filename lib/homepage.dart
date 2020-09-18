import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo/app_drawer.dart';
import 'package:demo/reusable_cards.dart';
import 'package:demo/round_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_clipper.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: Colors.white,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(100.0),
      //   child: AppBar(
      //     iconTheme: IconThemeData(color: Colors.black),
      //     backgroundColor: Color(0xffffffff),
      //     title: Column(
      //       children: [
      //         Text(
      //           "Welcome,",
      //           style: TextStyle(
      //             color: Colors.black,
      //           ),
      //         ),
      //         Text(
      //           "Kunal",
      //           style: TextStyle(
      //             color: Colors.black,
      //           ),
      //         ),
      //       ],
      //     ),
      //     actions: [
      //       Padding(
      //         padding: const EdgeInsets.all(10.0),
      //         child: CircleAvatar(
      //           radius: 50.0,
      //         ),
      //       ),
      //     ],
      //     elevation: 0.0,
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Color(0xff1dc4d8),
                ),
                child: Column(
                  children: [
                    SafeArea(
                      child: Align(
                          alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(Icons.menu),
                          color: Colors.white,
                          iconSize: 40.0,
                          // onPressed: () => Scaffold.of(context).openDrawer(),
                          onPressed: () { print("pressed"); },
                        ),
                      ),
                    ),
                    Text(
                      "Welcome, \nKunal",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 45.0,
                      )
                    ),
                  ],
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                // autoPlay: true,
                aspectRatio: 2.0,
              ),
              items: imageSliders,
            ),
            Container(
              margin: EdgeInsets.all(15.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey,
                //     blurRadius: 25.0, // soften the shadow
                //     spreadRadius: 1.0, //extend the shadow
                //     offset: Offset(
                //       5.0, // Move to right 10  horizontally
                //       5.0, // Move to bottom 10 Vertically
                //     ),
                //   )
                // ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          RoundIcon(colour: Color(0xff1dc4d8), iconData: FontAwesomeIcons.table),
                          SizedBox(height: 10.0),
                          Text(
                              "Time Table",
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          RoundIcon(colour: Color(0xff1dc4d8), iconData: Icons.video_call),
                          SizedBox(height: 10.0),
                          Text("Class Schedule"),
                        ],
                      ),
                      Column(
                        children: [
                          RoundIcon(colour: Color(0xff1dc4d8), iconData: Icons.home),
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
                          RoundIcon(colour: Color(0xff1dc4d8), iconData: FontAwesomeIcons.table),
                          SizedBox(height: 10.0),
                          Text("Time Table"),
                        ],
                      ),
                      Column(
                        children: [
                          RoundIcon(colour: Color(0xff1dc4d8), iconData: FontAwesomeIcons.table),
                          SizedBox(height: 10.0),
                          Text("Time Table"),
                        ],
                      ),
                      Column(
                        children: [
                          RoundIcon(colour: Color(0xff1dc4d8), iconData: FontAwesomeIcons.table),
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
              height: 120.0,
            ),
            ReusableCard(
              colour: Colors.grey[400],
              height: 120.0,
            ),
            ReusableCard(
              colour: Colors.grey[400],
              height: 120.0,
            ),
            ReusableCard(
              colour: Colors.grey[400],
              height: 120.0,
            ),
          ]
        ),
      ),
    );
  }
}



final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final List<Widget> imageSliders = imgList.map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(item, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  'No. ${imgList.indexOf(item)} image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )
    ),
  ),
)).toList();

