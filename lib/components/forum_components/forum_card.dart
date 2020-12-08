
import 'package:KCC_Portal/constants.dart';
import 'package:KCC_Portal/database.dart';
import 'package:KCC_Portal/screens/Forum/forum_answer.dart';
import 'package:KCC_Portal/screens/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:simple_moment/simple_moment.dart';

class ForumCard extends StatefulWidget {
  final id,
      name,
      profilePic,
      sem,
      email,
      tags,
      date,
      time,
      title,
      attachment,
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
      this.id,
      this.attachment,
      this.email,
      this.tags})
      : super(key: key);
  @override
  _ForumCardState createState() => _ForumCardState();
}

class _ForumCardState extends State<ForumCard> {
  bool liked = false;
  List<String> postLikedUsers = [];
  List<String> postViewedUsers = [];
  String timeAgo;
  GlobalKey keyBtn = GlobalKey();
  var _tapPosition;
  var email;

  @override
  void initState() {
    super.initState();
    checkPostLiked();
    getTimeAgo();
    getUsersEmail();
    // updateAnswerCount();
  }

  getUsersEmail() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    email = firebaseUser.email;
  }

  _pressed() async {
    setState(() {
      liked = !liked;
    });
    storePostLikedUsers();
  }

  // updateAnswerCount() async{
  //    QuerySnapshot answers = await postCollection.doc(widget.id).collection('replies').get();
  //    List<DocumentSnapshot> answerscount = answers.docs;
  //    await postCollection.doc(widget.id).update({
  //      'answers': answerscount.length.toString()
  //    });
  // }

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
    await postCollection
        .doc(widget.id)
        .set({'likedBy': postLikedUsers.toList()}, SetOptions(merge: true));
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

  void moveToForumAnswer(BuildContext context) async {
    await Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: ForumAnswer(
            id: widget.id,
            name: widget.name,
            profilePic: widget.profilePic,
            sem: widget.sem,
            tags: widget.tags,
            date: widget.date,
            time: widget.time,
            title: widget.title,
            question: widget.question,
            attachment: widget.attachment,
            votes: postLikedUsers.length.toString(),
            answers: widget.answers,
            views: postViewedUsers.length.toString()),
      ),
    );

    checkPostLiked();
  }

  deletePost() async {
    await postCollection.doc(widget.id).delete();
  }

  _showPopupMenu(BuildContext context) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    showMenu<String>(
      context: context,
      position: RelativeRect.fromRect(
          _tapPosition & Size(40, 40), // smaller rect, the touch area
          Offset.zero & overlay.size // Bigger rect, the entire screen
          ),
      items: email == widget.email
          ? [
              PopupMenuItem<String>(child: Text('Share'), value: 'Share'),
              PopupMenuItem<String>(child: Text('Report'), value: 'Report'),
              PopupMenuItem<String>(child: Text('Delete'), value: 'Delete'),
            ]
          : [
              PopupMenuItem<String>(child: Text('Share'), value: 'Share'),
              PopupMenuItem<String>(child: Text('Report'), value: 'Report'),
            ],
      elevation: 8.0,
    ).then<void>((String itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == "Delete") {
        deletePost();
      } else if (itemSelected == "Share") {
        //code here
      } else if (itemSelected == "Report") {
        //code here
      } else {
        //code here
      }
    });
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    PopupMenu menu = PopupMenu(
        backgroundColor: Colors.grey[400].withOpacity(0.5),
        lineColor: Colors.black,
        maxColumn: 2,
        items: [
          MenuItem(
            title: 'Delete',
            textStyle: GoogleFonts.nunito(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
          MenuItem(
            title: 'Report',
            textStyle: GoogleFonts.nunito(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
        onClickMenu: (MenuItemProvider item) {
          if (item.menuTitle == 'Report') {
          } else if (item.menuTitle == 'Delete') {
            // deletePost();
          }
        });

    return GestureDetector(
      onTap: () async {
        await storeViewedUsers();
        await moveToForumAnswer(context);
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.width * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Text(
                        widget.name,
                        maxLines: 2,
                        style: GoogleFonts.roboto(
                          // fontSize: size.width * 0.05,
                          fontSize: size.width * 0.03,
                          fontWeight: FontWeight.w600,
                          letterSpacing: size.width * 0.003,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/SemesterIcons/${widget.sem}.png',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: size.width * 0.015,
                          ),
                          Text(
                            "Sem",
                            style: GoogleFonts.roboto(
                              color: Colors.grey.shade500,
                              fontSize: size.width * 0.03,
                            ),
                          ),
                        ],
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
                ),
                Spacer(
                  flex: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTapDown: _storePosition,
                          onTap: () {
                            _showPopupMenu(context);
                            menu.show(widgetKey: keyBtn);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(size.width * 0.03),
                            child: GestureDetector(

                              child: Icon(
                                FontAwesomeIcons.ellipsisV,
                                color: kPrimaryDarkColor,
                              ),
                            ),
                          ),
                        ),
                      ],
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
              ],
            ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        children: widget.tags.map<Widget>((e) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            child: Chip(
                              backgroundColor: Colors.blue[100],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              label: Text(e.toString(),
                                  style: TextStyle(color: Colors.blue[900])),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  // GridView.count(
                  //   crossAxisCount: 4,
                  //   crossAxisSpacing: 5.0,
                  //   mainAxisSpacing: 1.0,
                  //   shrinkWrap: true,
                  //   padding: EdgeInsets.zero,
                  //   childAspectRatio: 2.5,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   children: List.generate(
                  //     widget.tags.length,
                  //     (index) => Chip(
                  //       backgroundColor: Colors.blue[100],
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(7),
                  //       ),
                  //       label: Text(widget.tags[index],
                  //           style: TextStyle(color: Colors.blue[900])),
                  //     ),
                  //   ),
                  // ),
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
