import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:KCC_Portal/components/forum_components/forum_answer_comments.dart';
import 'package:KCC_Portal/constants.dart';
import 'package:KCC_Portal/database.dart';
import 'package:KCC_Portal/screens/Forum/preview_image.dart';

class ForumAnswer extends StatefulWidget {
  final id,
      name,
      profilePic,
      sem,
      tags,
      date,
      time,
      title,
      question,
      attachment,
      votes,
      answers,
      views;

  const ForumAnswer(
      {this.id,
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
      this.attachment,
      this.tags});

  @override
  _ForumAnswerState createState() => _ForumAnswerState();
}

class _ForumAnswerState extends State<ForumAnswer> {
  bool liked = false;
  List<String> postViewedUsers = [];
  Stream myStream, userStream;
  var userName, profilePic, sem, email, postStream;
  var replyController = TextEditingController();
  bool isLoading = false;
  List<String> postLikedUsers = [];
  List<DocumentSnapshot> answersCount;
  var attachments;

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
    setState(() {
      isLoading = true;
    });
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
    setState(() {
      isLoading = false;
    });
  }

  void updateVotes() async {
    String votes = postLikedUsers.length.toString();
    await postCollection.doc(widget.id).update({'votes': votes});
  }

  getStream() async {
    setState(() {
      isLoading = true;
    });
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
    setState(() {
      isLoading = false;
    });
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDocument =
        await userCollection.doc(firebaseUser.email).get();
    userName =
        userDocument.get('first name') + " " + userDocument.get('last name');
    profilePic = userDocument.get('profilePic');
    sem = userDocument.get('semester');
    email = firebaseUser.email;
    setState(() {
      isLoading = false;
    });
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

  updateAnswerCount() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot answers =
        await postCollection.doc(widget.id).collection('replies').get();
    setState(() {
      answersCount = answers.docs;
    });
    await postCollection
        .doc(widget.id)
        .update({'answers': answersCount.length.toString()});
    setState(() {
      isLoading = false;
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
        'email': email,
        'sem': sem,
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
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: kSecondaryColor,
          // appBar: AppBar(
          //   backgroundColor: kPrimaryLightColor,
          //   elevation: 0.0,
          //   leading: GestureDetector(
          //       onTap: () => Navigator.pop(context),
          //       child: Icon(Icons.arrow_back_ios)),
          // ),
          body: Container(
            height: double.infinity,
            color: kPrimaryLightColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.all(
                          size.width * 0.04,
                        ),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                  Column(
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
                                    color:
                                        liked ? Colors.red : Colors.grey[400],
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
                      widget.attachment[0].toString() == "No attachment"
                          ? Container()
                          : GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: List.generate(
                                widget.attachment.length,
                                (index) => GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PreviewImage(
                                              image: widget.attachment[index]
                                                  .toString()))),
                                  child: Container(
                                    width: size.width * 0.3,
                                    height: size.height * 0.15,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 3.0),
                                    ),
                                    child: Hero(
                                      tag: 'attachment $index',
                                      child: Image.network(
                                        widget.attachment[index].toString(),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                                  answersCount.length.toString(),
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
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.35),
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size.width * 0.025,
                            horizontal: size.width * 0.025,
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
                                    padding: EdgeInsets.only(
                                      right: size.width * 0.015,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.6),
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
                                      ),
                                    ),
                                  );
                                },
                              ),
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
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          size.width * 0.9),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          size.width * 0.9),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          size.width * 0.9),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.015),
                                child: MaterialButton(
                                  height: size.width * 0.1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(size.width * 0.9),
                                  ),
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    if (replyController.text.isNotEmpty) {
                                      addReply();
                                    }
                                  },
                                  color: kPrimaryColor,
                                  child: Text(
                                    "Add Reply",
                                    style: GoogleFonts.nunito(
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
                        padding: EdgeInsets.all(size.width * 0.01),
                        width: double.infinity,
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
                                              fontSize: size.width * 0.09,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data.documents.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      DocumentSnapshot reply =
                                          snapshot.data.documents[index];
                                      return ForumReplyTile(
                                        userName: reply.data()['name'],
                                        profilePic: reply.data()['profilePic'],
                                        sem: reply.data()['sem'],
                                        email: reply.data()['email'],
                                        date: reply.data()['date'],
                                        reply: reply.data()['reply'],
                                        id: reply.data()['id'],
                                        parentReplyId: widget.id,
                                        votes: reply.data()['votes'],
                                      );
                                    },
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}