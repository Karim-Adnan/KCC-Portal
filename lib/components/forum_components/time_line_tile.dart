import 'package:KCC_Portal/constants.dart';
import 'package:KCC_Portal/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final sem;
  final email;
  final String userName, date;
  final grandParentReplyId;
  final grandParentEmail;
  final grandParentPostId;
  final grandParentUserName;
  final parentReplyId;
  final id;
  final isTaggingReply;
  final taggingUsername;
  final taggingReply;
  const TimeLineTile(
      {Key key,
      this.reply,
      this.profilePic,
      this.sem,
      this.userName,
      this.date,
      this.id,
      this.parentReplyId,
      this.grandParentReplyId,
      this.isTaggingReply,
      this.taggingUsername,
      this.taggingReply,
      this.email,
      this.grandParentEmail,
      this.grandParentPostId,
      this.grandParentUserName})
      : super(key: key);

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
  var currentUserName, currentUserProfilePic, currentUserSem, currentUserEmail;
  var replyController = TextEditingController();

  void getData() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDocument =
        await userCollection.doc(firebaseUser.email).get();
    currentUserName =
        userDocument.get('first name') + " " + userDocument.get('last name');
    currentUserProfilePic = userDocument.get('profilePic');
    currentUserSem = userDocument.get('semester');
    currentUserEmail = firebaseUser.email;
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
      final id = postCollection
          .doc(widget.grandParentReplyId)
          .collection('replies')
          .doc(widget.parentReplyId)
          .collection('replies')
          .doc()
          .id;

      postCollection
          .doc(widget.grandParentReplyId)
          .collection('replies')
          .doc(widget.parentReplyId)
          .collection('replies')
          .doc(id)
          .set({
        'name': currentUserName,
        'profilePic': currentUserProfilePic,
        'email': currentUserEmail,
        'sem': currentUserSem,
        'id': id,
        'reply': replyController.text,
        'time': now.toString(),
        'date': getDate(),
        'isTaggingReply': true,
        'taggingUserName': widget.userName,
        'taggingReply': widget.reply
      });
      if (currentUserEmail != widget.grandParentEmail &&
          widget.email == widget.grandParentEmail) {
        notifyParentUser(
            postId: widget.grandParentReplyId, reply: replyController.text);
      }
      if (currentUserEmail != widget.email) {
        if (widget.grandParentEmail == widget.email) {
          notifyUser(
              postId: widget.grandParentReplyId,
              reply: replyController.text,
              isParentEqualsChild: true);
        } else {
          notifyUser(
              postId: widget.grandParentReplyId,
              reply: replyController.text,
              isParentEqualsChild: false);
        }
      }
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

  void notifyParentUser({String postId, String reply}) async {
    try {
      setState(() {
        isLoading = true;
      });
      DateTime now = DateTime.now();
      final id = userCollection
          .doc(widget.grandParentEmail)
          .collection('forumNotifications')
          .doc()
          .id;
      userCollection
          .doc(widget.grandParentEmail)
          .collection('forumNotifications')
          .doc(id)
          .set({
        'id': id,
        'title': currentUserName.toString() +
            ' replied to ' +
            widget.userName +
            '\'s comment on your post',
        'reply': reply,
        'profilePic': currentUserProfilePic,
        'email': currentUserEmail,
        'postId': postId,
        'time': now.toString(),
        'viewed': false
      });
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

  void notifyUser(
      {String postId, String reply, bool isParentEqualsChild}) async {
    try {
      setState(() {
        isLoading = true;
      });
      DateTime now = DateTime.now();
      final id = isParentEqualsChild
          ? userCollection
              .doc(widget.grandParentEmail)
              .collection('forumNotifications')
              .doc()
              .id
          : userCollection
              .doc(widget.email)
              .collection('forumNotifications')
              .doc()
              .id;

      isParentEqualsChild
          ? userCollection
              .doc(widget.grandParentEmail)
              .collection('forumNotifications')
              .doc(id)
              .set({
              'id': id,
              'title': currentUserName.toString() +
                  ' replied to your comment on your post',
              'reply': reply,
              'profilePic': currentUserProfilePic,
              'email': currentUserEmail,
              'postId': postId,
              'time': now.toString(),
              'viewed': false
            })
          : userCollection
              .doc(widget.email)
              .collection('forumNotifications')
              .doc(id)
              .set({
              'id': id,
              'title': currentUserName.toString() +
                  ' replied to your comment on ' +
                  widget.grandParentUserName +
                  '\'s post',
              'reply': reply,
              'profilePic': currentUserProfilePic,
              'email': currentUserEmail,
              'postId': postId,
              'time': now.toString(),
              'viewed': false
            });
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
          .doc(widget.grandParentReplyId)
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
            .doc(widget.grandParentReplyId)
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
          .doc(widget.grandParentReplyId)
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
            .doc(widget.grandParentReplyId)
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
            .doc(widget.grandParentReplyId)
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
            .doc(widget.grandParentReplyId)
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
        .doc(widget.grandParentReplyId)
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
        .doc(widget.grandParentReplyId)
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
    int totalVotes =
        upvotedUsers.length.toInt() - downvotedUsers.length.toInt();
    setState(() {
      upvoteCount = totalVotes;
    });
    await postCollection
        .doc(widget.grandParentReplyId)
        .collection('replies')
        .doc(widget.parentReplyId)
        .collection('replies')
        .doc(widget.id)
        .update({'votes': totalVotes.toString()});
  }

  deletePost() async {
    await postCollection
        .doc(widget.grandParentReplyId)
        .collection('replies')
        .doc(widget.parentReplyId)
        .collection('replies')
        .doc(widget.id)
        .delete();
  }

  @override
  void initState() {
    super.initState();
    checkPostUpvotedOrDownVoted();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    Size size = MediaQuery.of(context).size;

    PopupMenu menu = PopupMenu(
        backgroundColor: Colors.grey[400].withOpacity(0.5),
        lineColor: Colors.black,
        maxColumn: 1,
        items: currentUserEmail == widget.email
            ? [
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
              ]
            : [
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
            deletePost();
          }
        });

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
          lineXY: 0.08,
          hasIndicator: true,
          indicatorStyle: IndicatorStyle(
            width: size.width * 0.11,
            height: size.width * 0.11,
            indicator: Container(
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
          beforeLineStyle: LineStyle(
            color: kPrimaryColor.withOpacity(0.7),
          ),
          endChild: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.036,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //     vertical: size.width * 0.04,
                    //   ),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       boxShadow: <BoxShadow>[
                    //         BoxShadow(
                    //           color: Colors.black.withOpacity(0.6),
                    //           offset: Offset(0, 0),
                    //           blurRadius: 0,
                    //           spreadRadius: size.width * 0.0015,
                    //         ),
                    //       ],
                    //     ),
                    //     child: CircleAvatar(
                    //       backgroundImage: NetworkImage(widget.profilePic),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: size.width * 0.02,
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: size.width * 0.03),
                          child: Row(
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
                                width: size.width * 0.01,
                              ),
                              Text(
                                '·',
                                style: GoogleFonts.nunito(
                                  color: Colors.grey.shade900,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.03,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.01,
                              ),
                              Image.asset(
                                'assets/icons/SemesterIcons/${widget.sem.replaceAll(' ', '-')}.png',
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
                        ),
                        SizedBox(
                          height: size.width * 0.01,
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
              // SizedBox(height: size.width * 0.04,),
              Padding(
                padding: EdgeInsets.only(
                  top: size.width * 0.04,
                  bottom: size.width * 0.025,
                  left: size.width * 0.035,
                  right: size.width * 0.035,
                ),
                child: Column(
                  children: [
                    widget.isTaggingReply
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.015,
                              vertical: size.width * 0.025,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.12),
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.lightBlueAccent,
                                    width: size.width * 0.02,
                                  ),
                                  right: BorderSide(
                                    color: Colors.black,
                                    width: size.width * 0.0012,
                                  ),
                                  top: BorderSide(
                                    color: Colors.black,
                                    width: size.width * 0.0012,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: size.width * 0.0012,
                                  ),
                                ),
                              ),
                              width: size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.03,
                                      vertical: size.width * 0.02,
                                    ),
                                    child: Text(
                                      widget.taggingUsername,
                                      style: GoogleFonts.nunito(
                                        fontStyle: FontStyle.italic,
                                        fontSize: size.width * 0.04,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.03,
                                      vertical: size.width * 0.02,
                                    ),
                                    child: Text(
                                      widget.taggingReply,
                                      style: GoogleFonts.nunito(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                              letterSpacing: 0.5,
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
                            setState(
                              () {
                                isReplying = !isReplying;
                              },
                            );
                          },
                          child: Container(
                            height: size.width * 0.11,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.03,
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
              Padding(
                padding: EdgeInsets.only(
                  right: size.width * 0.03,
                ),
                child: Container(
                  height: size.width * 0.001,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              isReplying
                  ? Container(
                      decoration: BoxDecoration(
                        color: kSecondaryColor.withOpacity(0.2),
                      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
