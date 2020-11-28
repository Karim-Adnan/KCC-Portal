import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/components/forum_components/forum_answer_comments.dart';
import 'package:demo/components/forum_components/forum_card.dart';
import 'package:demo/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:demo/database.dart';

class ForumAnswer extends StatefulWidget {
  final id,
      name,
      profilePic,
      sem,
      date,
      time,
      title,
      question,
      attachment,
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
      this.views,
      this.attachment})
      : super(key: key);

  @override
  _ForumAnswerState createState() => _ForumAnswerState();
}

class _ForumAnswerState extends State<ForumAnswer> {
  bool liked = false;
  List<String> postViewedUsers = [];
  Stream myStream, userStream;
  var userName, profilePic, postStream;
  var replyController = TextEditingController();
  bool isLoading = false;
  List<String> postLikedUsers = [];
  List<DocumentSnapshot> answerscount;

  @override
  void initState() {
    super.initState();
    getStream();
    getData();
    checkPostLiked();
    updateAnswerCount();
  }

  _pressed() async {
    setState(() {
      liked = !liked;
    });
    storePostLikedUsers();
  }

  storePostLikedUsers() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    if (liked) {
      await postCollection
          .doc(widget.id)
          .collection('likedBy')
          .doc(firebaseUser.email)
          .set({});
    } else {
      await postCollection
          .doc(widget.id)
          .collection('likedBy')
          .doc(firebaseUser.email)
          .delete();
    }
    checkPostLiked();
  }

  void checkPostLiked() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    postLikedUsers.clear();

    final QuerySnapshot result =
        await postCollection.doc(widget.id).collection('likedBy').get();

    if (result.docs.length != 0) {
      final List<DocumentSnapshot> documents = result.docs;
      if (this.mounted) {
        setState(() {
          for (var document in documents) {
            postLikedUsers.add(document.reference.id);
          }
        });
      }
    }

    if (postLikedUsers.contains(firebaseUser.email)) {
      if (this.mounted) {
        setState(() {
          liked = true;
        });
      }
    } else {
      if (this.mounted) {
        setState(() {
          liked = false;
        });
      }
    }
    updateVotes();
  }

  void updateVotes() async {
    String votes = postLikedUsers.length.toString();
    await postCollection.doc(widget.id).update({'votes': votes});
  }

  getStream() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    setState(() {
      postStream = postCollection.doc(widget.id).snapshots();
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

  updateAnswerCount() async{
     QuerySnapshot answers = await postCollection.doc(widget.id).collection('replies').get();
     setState(() {
      answerscount = answers.docs;
     });
     await postCollection.doc(widget.id).update({
       'answers': answerscount.length.toString()
     });
  }

  addReply() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    try {
      setState(() {
        isLoading = true;
      });
      DateTime now = DateTime.now();
      final id = postCollection.doc(widget.id).collection('replies').doc().id;
      postCollection.doc(widget.id).collection('replies').doc(id).set({
        'name': userName,
        'profilePic': profilePic,
        'id': id,
        'reply': replyController.text,
        'time': now.toString(),
        'date': getDate(),
        'votes': '0'
      });
      replyController.clear();
      updateAnswerCount();
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
  Widget build(BuildContext context) {
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
                              color: liked ? Colors.red : Colors.grey[400],
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
                widget.attachment == "No attachment"
                    ? Container()
                    : Image(
                        width: size.width,
                        height: size.height * 0.25,
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.attachment),
                      ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.symmetric(
                //         vertical: size.height * 0.01,
                //         horizontal: size.width * 0.075,
                //       ),
                //       child: Container(
                //         height: size.height * 0.12,
                //         width: size.width * 0.3,
                //         color: Colors.white,
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.symmetric(
                //         vertical: size.height * 0.01,
                //         horizontal: size.width * 0.075,
                //       ),
                //       child: Container(
                //         height: size.height * 0.12,
                //         width: size.width * 0.3,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ],
                // ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text(
                              postLikedUsers.length.toString(),
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
                              answerscount.length.toString(),
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
                    )),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.35),
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.black.withOpacity(0.2))),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StreamBuilder(
                            stream: userStream,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              }
                              return Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.6),
                                          offset: Offset(0, 0),
                                          blurRadius: 0,
                                          spreadRadius: size.width * 0.0015,
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      child: ClipOval(
                                        child: Image.network(
                                          snapshot.data['profilePic'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                              );
                            }),
                        Expanded(
                          child: TextField(
                            cursorHeight: size.width * 0.045,
                            style: GoogleFonts.nunito(
                              height: size.width * 0.004,
                              fontSize: size.width * 0.039,
                            ),
                            controller: replyController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: size.width * 0.021,
                                horizontal: size.width * 0.033,
                              ),
                              isDense: true,
                              hintText: "Add a reply...",
                              hintStyle: GoogleFonts.nunito(
                                fontSize: size.width * 0.039,
                              ),
                              // focusColor: Colors.white,
                              // fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: MaterialButton(
                            height: 40,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if(replyController.text.isNotEmpty){
                                addReply();
                              }
                              // if (replyController.text.isEmpty) {
                              //   if (Fluttertoast != null) {
                              //     Fluttertoast.cancel();
                              //   }
                              //   Fluttertoast.showToast(
                              //     msg: "Comment cannot be empty",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.BOTTOM,
                              //     timeInSecForIosWeb: 1,
                              //     backgroundColor: Colors.red.withOpacity(0.9),
                              //     textColor: Colors.white,
                              //     fontSize: 16,
                              //   );
                              // } else {
                              //   addReply();
                              // }
                            },
                            color: kPrimaryColor,
                            child: Text(
                              "Add Reply",
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(1),
                  width: double.infinity,
                  color: kSecondaryColor,
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
                                      "No Replies..",
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
                                  return ForumReplyTile(
                                    userName: reply.data()['name'],
                                    profilePic: reply.data()['profilePic'],
                                    date: reply.data()['date'],
                                    reply: reply.data()['reply'],
                                    id: reply.data()['id'],
                                    parentReplyId: widget.id,
                                    votes: reply.data()['votes'],
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
      ),
    );
  }
}
