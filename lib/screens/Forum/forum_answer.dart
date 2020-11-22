import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/components/forum_components/forum_answer_timeline.dart';
import 'package:demo/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../database.dart';

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
  bool liked = false;
  List<String> postViewedUsers = [];
  Stream myStream, userStream;
  var userName, profilePic;
  var replyController = TextEditingController();
  bool isLoading = false;

  _pressed() async {
    setState(() {
      liked = !liked;
    });
  }

  getStream() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    setState(() {
      myStream = postCollection
          .doc(widget.id)
          .collection('replies')
          .orderBy('time', descending: false)
          .snapshots();
      userStream = userCollection.doc(firebaseUser.email).snapshots();
    });
  }

  void getData() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDocument =
        await userCollection.doc(firebaseUser.email).get();
    userName =
        userDocument.get('first name') + " " + userDocument.get('last name');
    profilePic = userDocument.get('profilePic');
  }

  String getDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMM yy').format(now);
    String year = "'" + formattedDate.split(" ")[2];
    String date = formattedDate.split(" ")[0] +
        " " +
        formattedDate.split(" ")[1] +
        " " +
        year;
    return date;
  }

  addReply() async {
    try {
      setState(() {
        isLoading = true;
      });
      DateTime now = DateTime.now();
      final id = postCollection.doc().id;
      postCollection.doc(widget.id).collection('replies').doc(id).set({
        'name': userName,
        'profilePic': profilePic,
        'id': id,
        'reply': replyController.text,
        'time': now.toString(),
        'date': getDate(),
      });
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => ForumAnswer()));
      replyController.clear();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error=$e");
    }
  }

  @override
  void initState() {
    super.initState();
    getStream();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor.withOpacity(0.9),
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: Container(
        height: double.infinity,
        color: kPrimaryLightColor.withOpacity(0.9),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.065,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              widget.title,
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
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
                      ],
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
                    Row(
                      children: [
                        Text(
                          widget.question,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.nunito(
                            color: Colors.white54,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.votes,
                          style: GoogleFonts.roboto(
                              fontSize: size.width * 0.045,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Text(
                          'votes',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
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
                          widget.answers,
                          style: GoogleFonts.roboto(
                            fontSize: size.width * 0.045,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Text(
                          'answers',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
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
                          widget.views,
                          style: GoogleFonts.roboto(
                            fontSize: size.width * 0.045,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Text(
                          'views',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
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
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  color: Colors.grey,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StreamBuilder(
                            stream: userStream,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              }
                              return CircleAvatar(
                                backgroundImage:
                                    NetworkImage(snapshot.data['profilePic']),
                              );
                            }),
                        SizedBox(width: 5),
                        Expanded(
                            child: TextField(
                          controller: replyController,
                          decoration: kTextFieldDecoration,
                        )),
                        SizedBox(width: 5),
                        FlatButton(
                          onPressed: () {
                            if (replyController.text.isNotEmpty) {
                              addReply();
                            }
                          },
                          color: Colors.white,
                          child: Text("Add a reply"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: StreamBuilder(
                  stream: myStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    return snapshot.data.documents.length == 0
                        ? Center(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    height: size.height * 0.5,
                                    width: size.width * 0.7,
                                    child: Image.asset(
                                        "assets/illustrations/no_posts.png"),
                                  ),
                                  Text(
                                    "No Posts",
                                    style: GoogleFonts.nunito(
                                      fontSize: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Flexible(
                          fit: FlexFit.loose,
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot reply =
                                    snapshot.data.documents[index];
                                return ForumTimelineTile(
                                  userName: reply.data()['name'],
                                  profilePic: reply.data()['profilePic'],
                                  date: reply.data()['date'],
                                  reply: reply.data()['reply'],
                                );
                              },
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
