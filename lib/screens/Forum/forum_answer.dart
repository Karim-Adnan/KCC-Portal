import 'package:demo/components/forum_components/forum_answer_timeline.dart';
import 'package:demo/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ForumAnswer extends StatefulWidget {
  final id,
      name,
      profilePic,
      sem,
      date,
      time,
      title,
      question,
      votes,
      answers,
      views;

  const ForumAnswer(
      {Key key,
      this.id,
      this.name,
      this.profilePic,
      this.sem,
      this.date,
      this.time,
      this.title,
      this.question,
      this.votes,
      this.answers,
      this.views})
      : super(key: key);

  @override
  _ForumAnswerState createState() => _ForumAnswerState();
}

class _ForumAnswerState extends State<ForumAnswer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        color: kPrimaryLightColor.withOpacity(0.9),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.12,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.025,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        padding: EdgeInsets.only(
                          top: size.width * 0.02,
                          right: size.width * 0.02,
                          left: size.width * 0.02,
                        ),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                // height: size.height * 0.3,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.065,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: size.width,
                            child: Text(
                              'Title of the question  is herejdm hfhjehfiheifhi',
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.015,
                        horizontal: size.width * 0.07,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Lorem ipsum dolor elit, magna aliqua. Ullamcorper condimentum id venenatis. Sed elementum tempus egestas sed sed risus pretium quam vulputate. Eu nisl nunc mi ipsum. Amet nisl suscipit adipiscing bibendum est ultricies integer quis. Blandit cursus risus at ultrices mi. Fermentum dui faucibus in ornare quam viverra orci. Adipiscing at in tellus integer feugiat scelerisque. Nisi porta lorem mollis aliquam.',
                            style: GoogleFonts.nunito(
                              color: Colors.white54,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.01,
                            horizontal: size.width * 0.075,
                          ),
                          child: Container(
                            height: size.height * 0.12,
                            width: size.width * 0.3,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.01,
                            horizontal: size.width * 0.075,
                          ),
                          child: Container(
                            height: size.height * 0.12,
                            width: size.width * 0.3,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: size.height * 0.025,
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.02,
                        horizontal: size.width * 0.03,
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return ForumTimelineTile(
                            reply:
                                'Lorem Ipsum is simply dummy textm.',
                            image: 'https://i.pinimg.com/originals/a6/58/32/a65832155622ac173337874f02b218fb.png',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
