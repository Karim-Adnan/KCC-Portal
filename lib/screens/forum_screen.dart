import 'package:demo/components/forum_card.dart';
import 'package:demo/components/forum_new_question.dart';
import 'package:demo/screens/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: kSecondaryLightColor.withOpacity(0.15),
          child: Column(
            children: [
              Container(
                height: size.height * 0.17,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: size.height * 0.025),
                      color: kPrimaryLightColor.withOpacity(0.9),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.025,
                            bottom: size.height * 0.01),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                margin: EdgeInsets.all(8),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                'Forum',
                                style: GoogleFonts.nunito(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 4,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {}, // Open Forum Menu

                              child: Container(
                                margin: EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.menu_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 1.2),
                      child: GestureDetector(
                        onTap: () {}, // Open Search Screen

                        child: Container(
                          height: size.height * 0.06,
                          width: size.width * 0.7,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2.8,
                              color: kPrimaryLightColor.withOpacity(0.9),
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(size.width * 0.03),
                              topRight: Radius.circular(size.width * 0.03),
                              bottomLeft: Radius.circular(size.width * 0.09),
                              bottomRight: Radius.circular(size.width * 0.09),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.05),
                                  child: Icon(
                                    Icons.search,
                                    size: size.width * 0.05,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.025,
                                ),
                                Text(
                                  'Looking for answers?',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: size.width * 0.04,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ForumCard(),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      ForumCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return NewQuestion();
                });
          },
          backgroundColor: kPrimaryDarkColor,
          child: Icon(CupertinoIcons.plus),
        ),
      ),
    );
  }
}
