import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/constants.dart';
import 'package:demo/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineTile extends StatefulWidget {
  final String reply;
  final String profilePic;
  final String userName, date;
  final grandParentRepyId;
  final parentReplyId;
  final id;
  final isTaggingReply;
  final taggingUsername;
  final taggingReply;
  const TimeLineTile({
    Key key,
    this.reply,
    this.profilePic,
    this.userName,
    this.date,
    this.id,
    this.parentReplyId,
    this.grandParentRepyId,
    this.isTaggingReply, this.taggingUsername, this.taggingReply,
  }) : super(key: key);

  @override
  _TimeLineTileState createState() => _TimeLineTileState();
}

class _TimeLineTileState extends State<TimeLineTile> {
  bool upVoted = false;
  bool downVoted = false;
  bool isReplying = false;
  int upvoteCount = 0;
  GlobalKey keyBtn = GlobalKey();
  bool isLoading = false;
  Stream myStream;
  List<String> upvotedUsers = [];
  List<String> downvotedUsers = [];
  var userName, profilePic;
  var replyController = TextEditingController();

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
      postCollection
          .doc(widget.grandParentRepyId)
          .collection('replies')
          .doc(widget.parentReplyId)
          .collection('replies')
          .doc(id)
          .set({
        'name': userName,
        'profilePic': profilePic,
        'id': id,
        'reply': replyController.text,
        'time': now.toString(),
        'date': getDate(),
        'isTaggingReply': true,
        'taggingUserName': widget.userName,
        'taggingReply': widget.reply
      });
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

  _pressedUp() async {
    if (downVoted) {
      setState(() {
        upVoted = true;
        downVoted = false;
      });
    } else if (upVoted) {
      setState(() {
        upVoted = false;
      });
    } else {
      setState(() {
        upVoted = true;
      });
    }

    storePostVotedUsers();
  }

  _pressedDown() async {
    if (upVoted) {
      setState(() {
        downVoted = true;
        upVoted = false;
      });
    } else if (downVoted) {
      setState(() {
        downVoted = false;
      });
    } else {
      setState(() {
        downVoted = true;
      });
    }

    storePostVotedUsers();
  }

  //storing upvoted or downvoted users
  storePostVotedUsers() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;

    //if the users upvotes a comment
    if (upVoted) {
      //adding user to upVoted collection
      await postCollection
          .doc(widget.grandParentRepyId)
          .collection('replies')
          .doc(widget.parentReplyId)
          .collection('replies')
          .doc(widget.id)
          .collection('upVotedBy')
          .doc(firebaseUser.email)
          .set({});

      //deleting user from downVoted collection if the user has previously downVoted the reply
      if (downvotedUsers.contains(firebaseUser.email)) {
        await postCollection
            .doc(widget.grandParentRepyId)
            .collection('replies')
            .doc(widget.parentReplyId)
            .collection('replies')
            .doc(widget.id)
            .collection('downVotedBy')
            .doc(firebaseUser.email)
            .delete();
      }
    }
    //if the users downvotes a comment
    else if (downVoted) {
      //adding user to downVoted collection
      await postCollection
          .doc(widget.grandParentRepyId)
          .collection('replies')
          .doc(widget.parentReplyId)
          .collection('replies')
          .doc(widget.id)
          .collection('downVotedBy')
          .doc(firebaseUser.email)
          .set({});

      //deleting user from upVoted collection if the user has previously upVoted the reply
      if (upvotedUsers.contains(firebaseUser.email)) {
        await postCollection
            .doc(widget.grandParentRepyId)
            .collection('replies')
            .doc(widget.parentReplyId)
            .collection('replies')
            .doc(widget.id)
            .collection('upVotedBy')
            .doc(firebaseUser.email)
            .delete();
      }
    }

    //if the user neither upvotes or downvotes a comment
    else {
      //deleting user from upVoted collection if the user has previously upVoted the reply
      if (upvotedUsers.contains(firebaseUser.email)) {
        await postCollection
            .doc(widget.grandParentRepyId)
            .collection('replies')
            .doc(widget.parentReplyId)
            .collection('replies')
            .doc(widget.id)
            .collection('upVotedBy')
            .doc(firebaseUser.email)
            .delete();
      }

      //deleting user from downVoted collection if the user has previously downVoted the reply
      if (downvotedUsers.contains(firebaseUser.email)) {
        await postCollection
            .doc(widget.grandParentRepyId)
            .collection('replies')
            .doc(widget.parentReplyId)
            .collection('replies')
            .doc(widget.id)
            .collection('downVotedBy')
            .doc(firebaseUser.email)
            .delete();
      }
    }
    checkPostUpvotedOrDownVoted();
  }

  //check for upvotes and downvotes
  void checkPostUpvotedOrDownVoted() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    upvotedUsers.clear();
    downvotedUsers.clear();

    // getting upvoted Users
    final QuerySnapshot upVotedResult = await postCollection
        .doc(widget.grandParentRepyId)
        .collection('replies')
        .doc(widget.parentReplyId)
        .collection('replies')
        .doc(widget.id)
        .collection('upVotedBy')
        .get();

    if (upVotedResult.docs.length != 0) {
      final List<DocumentSnapshot> documents = upVotedResult.docs;
      if (this.mounted) {
        setState(() {
          for (var document in documents) {
            upvotedUsers.add(document.reference.id);
          }
        });
      }
    }

    //getting downvoted Users
    final QuerySnapshot downVotedResult = await postCollection
        .doc(widget.grandParentRepyId)
        .collection('replies')
        .doc(widget.parentReplyId)
        .collection('replies')
        .doc(widget.id)
        .collection('downVotedBy')
        .get();

    if (downVotedResult.docs.length != 0) {
      final List<DocumentSnapshot> documents = downVotedResult.docs;
      if (this.mounted) {
        setState(() {
          for (var document in documents) {
            downvotedUsers.add(document.reference.id);
          }
        });
      }
    }

    if (upvotedUsers.contains(firebaseUser.email)) {
      if (this.mounted) {
        setState(() {
          upVoted = true;
          downVoted = false;
        });
      }
    } else if (downvotedUsers.contains(firebaseUser.email)) {
      if (this.mounted) {
        setState(() {
          downVoted = true;
          upVoted = false;
        });
      }
    } else {
      if (this.mounted) {
        setState(() {
          upVoted = false;
          downVoted = false;
        });
      }
    }
    updateVotes();
  }

  void updateVotes() async {
    int totalvotes =
        upvotedUsers.length.toInt() - downvotedUsers.length.toInt();
    setState(() {
      upvoteCount = totalvotes;
    });
    await postCollection
        .doc(widget.grandParentRepyId)
        .collection('replies')
        .doc(widget.parentReplyId)
        .collection('replies')
        .doc(widget.id)
        .update({'votes': totalvotes.toString()});
  }

  @override
  void initState() {
    super.initState();
    checkPostUpvotedOrDownVoted();
    getData();
  }

  PopupMenu menu = PopupMenu(
      backgroundColor: Colors.grey[400].withOpacity(0.5),
      lineColor: Colors.black,
      maxColumn: 1,
      items: [
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
        if (item.menuTitle == 'Report') {}
      });

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          isReplying = false;
        });
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.1,
            hasIndicator: false,
            beforeLineStyle: LineStyle(
              color: Colors.black45,
            ),
            endChild: Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.036,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.width * 0.03,
                        bottom: size.width * 0.03,
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
                          backgroundImage: NetworkImage(widget.profilePic),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userName,
                          style: GoogleFonts.roboto(
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.w500,
                            letterSpacing: size.width * 0.003,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.005,
                        ),
                        Text(
                          widget.date,
                          style: GoogleFonts.roboto(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: size.width * 0.03,
                            letterSpacing: size.width * 0.0015,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.036,
                  // bottom: size.width * 0.02,
                ),
                child: Column(
                  children: [
                    widget.isTaggingReply
                        ? Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width: size.width,
                              color: Colors.grey,
                              child: Column(children: [
                                Text(widget.taggingUsername),
                                Text(widget.taggingReply)
                              ],),
                            ),
                        )
                        : Container(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            widget.reply,
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.036,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _pressedUp();
                      },
                      child: Container(
                        height: size.width * 0.11,
                        child: Row(
                          children: [
                            Container(
                              height: size.width * 0.08,
                              child: upVoted
                                  ? Image.asset(
                                      "assets/icons/vote/upvote_fill.png",
                                      color: kPrimaryLightColor,
                                    )
                                  : Image.asset("assets/icons/vote/upvote.png"),
                            ),
                            Text(
                              'Upvote  $upvoteCount',
                              style: GoogleFonts.nunito(
                                color:
                                    upVoted ? kPrimaryLightColor : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isReplying = !isReplying;
                            });
                          },
                          child: Container(
                            height: size.width * 0.11,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    /* vertical: 8.0 ,*/ horizontal:
                                        size.width * 0.03,
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.reply,
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                                Text(
                                  'Reply',
                                  style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        _pressedDown();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(size.width * 0.02),
                        child: Container(
                          height: size.width * 0.08,
                          child: downVoted
                              ? Image.asset(
                                  "assets/icons/vote/downvote_fill.png",
                                  color: kPrimaryLightColor,
                                )
                              : Image.asset("assets/icons/vote/downvote.png"),
                        ),
                      ),
                    ),
                    InkWell(
                      key: keyBtn,
                      enableFeedback: true,
                      onTap: () {
                        menu.show(widgetKey: keyBtn);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(size.width * 0.025),
                        child: Icon(FontAwesomeIcons.ellipsisH),
                      ),
                    ),
                  ],
                ),
              ),
              isReplying
                  ? Container(
                      decoration: BoxDecoration(
                          color: kSecondaryColor.withOpacity(0.2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * 0.04,
                          ),
                          Expanded(
                            child: TextField(
                              cursorHeight: size.width * 0.045,
                              style: GoogleFonts.nunito(
                                height: size.width * 0.004,
                                fontSize: 14,
                              ),
                              controller: replyController, //NEED A CONTROLLER
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: size.width * 0.021,
                                  horizontal: size.width * 0.036,
                                ),
                                isDense: true,
                                hintText: "Add a reply...",
                                hintStyle: GoogleFonts.nunito(
                                  fontSize: size.width * 0.039,
                                ),
                                // focusColor: Colors.white,
                                // fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.09),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.09),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.09),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.006),
                            child: MaterialButton(
                              height: size.width * 0.108,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.09),
                              ),
                              padding: EdgeInsets.zero,
                              onPressed: () => addReply(),
                              color: kPrimaryColor,
                              child: Text(
                                "Reply",
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.04,
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ])),
      ),
    );
  }
}
