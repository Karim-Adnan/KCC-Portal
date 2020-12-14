import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:KCC_Portal/components/profile_components/header_icons.dart';
import 'package:KCC_Portal/components/profile_components/profile_backdrop.dart';
import 'package:KCC_Portal/components/profile_components/profile_info.dart';
import 'package:KCC_Portal/components/profile_components/profile_panel.dart';
import 'package:KCC_Portal/components/profile_components/profile_panel_cards.dart';
import 'package:KCC_Portal/database.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Stream myStream;
  bool showSpinner = false;
  bool isOnline = true;

  getStream() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    setState(
        () => myStream = userCollection.doc(firebaseUser.email).snapshots());
  }

  @override
  void initState() {
    super.initState();
    getStream();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: StreamBuilder(
          stream: myStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return Stack(
              children: [
                ProfileBackdrop(
                  backdropImage: snapshot.data['profilePic'] == null
                      ? 'https://www.pngkit.com/png/full/72-729613_icons-logos-emojis-user-icon-png-transparent.png'
                      : snapshot.data['profilePic'],
                  children: [
                    SizedBox(
                      height: size.width * 0.15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.06,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeaderButton(
                            icon: CupertinoIcons.chevron_back,
                            iconColor: Colors.white,
                            iconSize: size.width * 0.07,
                            onTap: () => Navigator.pop(context),
                          ),
                          HeaderButton(
                            icon: FontAwesomeIcons.ellipsisH,
                            iconColor: Colors.white,
                            iconSize: size.width * 0.05,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.5,
                    ),
                    ProfileInfo(
                      profileImage: snapshot.data['profilePic'] == null
                          ? 'https://www.pngkit.com/png/full/72-729613_icons-logos-emojis-user-icon-png-transparent.png'
                          : snapshot.data['profilePic'],
                      name:
                          '${snapshot.data['first name']} \n${snapshot.data['last name']}',
                    ),
                  ],
                ),
                ProfilePanel(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 0.045,
                    ),
                    ProfilePanelCards(
                      overTitle: "Email",
                      title: snapshot.data['email'],
                    ),
                    ProfilePanelCards(
                      overTitle: "Contact",
                      title: snapshot.data['mobile number'],
                    ),
                    ProfilePanelCards(
                      overTitle: "Roll No.",
                      title: snapshot.data['roll number'],
                    ),
                    ProfilePanelCards(
                      overTitle: "Dept-Sem",
                      title:
                          '${snapshot.data['department']}-${snapshot.data['semester']}',
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}