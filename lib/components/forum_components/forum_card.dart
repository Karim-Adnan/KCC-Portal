import 'package:demo/constants.dart';
import 'package:demo/database.dart';
import 'package:demo/screens/Forum/forum_answer.dart';
import 'package:demo/screens/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_moment/simple_moment.dart';

class ForumCard extends StatefulWidget {
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

  const ForumCard(
      {Key key,
      this.name,
      this.profilePic,
      this.sem,
      this.date,
      this.title,
      this.question,
      this.votes,
      this.answers,
      this.views,
      this.time,
      this.id})
      : super(key: key);
  @override
  _ForumCardState createState() => _ForumCardState();
}

class _ForumCardState extends State<ForumCard> {
  bool liked = false;
  List<String> postLikedUsers = [];
  List<String> postViewedUsers = [];
  String timeAgo;

  @override
  void initState() {
    super.initState();
    checkPostLiked();
    getTimeAgo();
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

  void getTimeAgo() {
    var secondsToAdd = new Duration(seconds: 10);
    var parsedDateTime = DateTime.parse(widget.time);
    var dateForComparison = parsedDateTime.add(secondsToAdd);
    var moment = new Moment.now();

    setState(() {
      timeAgo = moment.from(dateForComparison).toString();
    });
  }

  storeViewedUsers() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    postViewedUsers.clear();

    final QuerySnapshot result =
        await postCollection.doc(widget.id).collection('viewedBy').get();

    if (result.docs.length != 0) {
      final List<DocumentSnapshot> documents = result.docs;
      if (this.mounted) {
        setState(() {
          for (var document in documents) {
            postViewedUsers.add(document.reference.id);
          }
        });
      }
    }

    if (!postViewedUsers.contains(firebaseUser.email)) {
      if (this.mounted) {
        await postCollection
            .doc(widget.id)
            .collection('viewedBy')
            .doc(firebaseUser.email)
            .set({});
      }
      setState(() {
        postViewedUsers.add(firebaseUser.email);
      });
    }

    updateViews();
  }

  updateViews() async {
    String views = postViewedUsers.length.toString();
    await postCollection.doc(widget.id).update({'views': views});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () async {
        await storeViewedUsers();
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: ForumAnswer(
                id: widget.id,
                name: widget.name,
                profilePic: widget.profilePic,
                sem: widget.sem,
                date: widget.date,
                time: widget.time,
                title: widget.title,
                question: widget.question,
                votes: postLikedUsers.length.toString(),
                answers: widget.answers,
                views: postViewedUsers.length.toString()),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          left: size.width * 0.04,
          right: size.width * 0.04,
          top: size.width * 0,
          bottom: size.width * 0.05,
        ),
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width * 0.006),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(0.4),
              offset: Offset(1, 1),
              blurRadius: size.width * 0.036,
              spreadRadius: size.width * 0.003,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: UserProfilePage(),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                      size.width * 0.03,
                    ),
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
                        backgroundImage:
                            NetworkImage(widget.profilePic), // Profile Image
                        radius: size.width * 0.07,
                      ),
                    ),
                  ),
                ),
                // Spacer(
                //   flex: 1,
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      maxLines: 2,
                      style: GoogleFonts.roboto(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w600,
                        letterSpacing: size.width * 0.003,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    Text(
                      timeAgo,
                      style: GoogleFonts.roboto(
                        color: Colors.grey.shade500,
                        fontSize: size.width * 0.03,
                      ),
                    ),
                  ],
                ),
                Spacer(
                  flex: 8,
                ),
                Padding(
                  padding: EdgeInsets.all(
                    size.width * 0.03,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Text(
                        widget.date,
                        style: GoogleFonts.roboto(
                          color: Colors.grey.shade500,
                          fontSize: size.width * 0.03,
                          letterSpacing: size.width * 0.0015,
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
              padding: EdgeInsets.symmetric(
                vertical: size.width * 0.006,
                horizontal: size.width * 0.03,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          // overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                            color: kPrimaryLightColor,
                            fontSize: size.width * 0.055,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.width * 0.03,
                      bottom: size.width * 0.015,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(right: size.width * 0.035),
                            child: Text(
                              widget.question,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.nunito(
                                color: Colors.grey.shade600,
                                fontSize: size.width * 0.036,
                              ),
                            ),
                          ),
                        ),
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
              padding: EdgeInsets.all(size.width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.votes,
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
                          letterSpacing: size.width * 0.003,
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
                          letterSpacing: size.width * 0.003,
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
                          letterSpacing: size.width * 0.003,
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
                          letterSpacing: size.width * 0.003,
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
                          letterSpacing: size.width * 0.003,
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
