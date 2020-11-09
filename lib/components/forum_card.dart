import 'package:demo/constants.dart';
import 'package:demo/screens/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class ForumCard extends StatefulWidget {
  @override
  _ForumCardState createState() => _ForumCardState();
}

class _ForumCardState extends State<ForumCard> {
  bool liked = false;

  _pressed() {
    setState(() {
      liked = !liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    int _viewCount = 2515;
    int _answerCount = 347;
    int _voteCount = 568;
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(
            left: size.width * 0.06,
            right: size.width * 0.06,
            top: size.height * 0.025),
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(0.4),
              offset: Offset(1, 1),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(size.width * 0.03),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: UserProfilePage(),
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/images/drawerImage.jpg'), // Profile Image
                      radius: size.width * 0.07,
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Adnan Karim',
                      style: GoogleFonts.roboto(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    Text(
                      '6 hours ago',
                      style: GoogleFonts.roboto(
                        color: Colors.grey.shade500,
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
                Spacer(
                  flex: 8,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          liked
                              ? FontAwesomeIcons.solidHeart
                              : FontAwesomeIcons.heart,
                          color: liked ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          _pressed();
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Text(
                        '09 Nov \'20',
                        style: GoogleFonts.roboto(
                          color: Colors.grey.shade500,
                          fontSize: 11.0,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: size.height * 0.01,
            // ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Title of Post!',
                          style: GoogleFonts.nunito(
                            color: kPrimaryLightColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                            style: GoogleFonts.nunito(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        _voteCount.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Text(
                        'votes',
                        style: GoogleFonts.roboto(
                          color: Colors.grey.shade600,
                          fontSize: size.width * 0.035,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        _answerCount.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Text(
                        'answers',
                        style: GoogleFonts.roboto(
                          color: Colors.grey.shade600,
                          fontSize: size.width * 0.035,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        _viewCount.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Text(
                        'views',
                        style: GoogleFonts.roboto(
                          color: Colors.grey.shade600,
                          fontSize: size.width * 0.035,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
