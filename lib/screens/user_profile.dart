import 'dart:ui';
import 'package:demo/constants.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/pic.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                    ),
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: ()=>Navigator.pop(context),
                    child: Icon(CupertinoIcons.back,color: Colors.white,size: 32.0,
                    ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // padding: EdgeInsets.all(100.0),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[
                        Color(0xFF0F427C),
                        Color(0xDF1dc4d8),
                      ]),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 70.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Adnan Karim',
                            style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(3.0, 3.0),
                                  blurRadius: 3.0,
                                  color: Colors.grey[900],
                                ),
                                Shadow(
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 10.0,
                                  color: Colors.black12,
                                ),
                              ],
                                fontSize: 30.0,
                                color: Colors.grey[100]
                            ),
                          ),
                        ],
                      ),
                      ProfileCard(title: 'kaif.adnan05@gmail.com',icon: Icons.email,),
                      ProfileCard(title: '7838871487',icon: Icons.phone,),
                      ProfileCard(title: '1849210005',icon: FontAwesomeIcons.university,),
                      ProfileCard(title: 'CSE-5th',icon: FontAwesomeIcons.userGraduate,),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 180.0,
                          width: 200.0,
                          child: FlareActor('assets/penguin_nodding.flr',
                            alignment: Alignment.center,
                            fit: BoxFit.fill,
                            animation: 'music_walk',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(4.0, 4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/pic.jpg'),
                    radius: size*0.75,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const ProfileCard({Key key,this.title,this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.07,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            topRight: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        elevation: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(width: 25.0,),
            Text(title, style: TextStyle(fontSize: 22.0),),
          ],
        ),
        color: Colors.white,
      ),
    );
  }
}