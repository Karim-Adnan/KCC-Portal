import 'package:demo/constants.dart';
import 'package:demo/util/drawer_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50.0, left: 20, bottom: 20),
      color: kPrimaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kunal Manchanda",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    "Student",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              )
            ],
          ),
          Column(
            children: drawerItems.map((drawerItem) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: [
                  Icon(drawerItem['icon'], color: Colors.white, size: 30,),
                  SizedBox(width: 10,),
                  Text(
                    drawerItem['title'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),
                  )
                ],
              ),
            )).toList(),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(Icons.settings,color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Settings", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(width: 2, height: 20, color: Colors.white,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(FontAwesomeIcons.signOutAlt,color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Logout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),),
              ),

            ],
          )
        ],
      ),
    );
  }
}
