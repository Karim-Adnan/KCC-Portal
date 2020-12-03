import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/components/forum_components/forum_card.dart';
import 'package:demo/constants.dart';
import 'package:demo/database.dart';
import 'package:demo/screens/Forum/forum_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class ForumFavouritePosts extends StatefulWidget {
  @override
  _ForumFavouritePostsState createState() => _ForumFavouritePostsState();
}

class _ForumFavouritePostsState extends State<ForumFavouritePosts> {
  Stream myStream;
  var email;

  @override
  void initState() {
    super.initState();
    getStream();
    getData();
  }

  getStream() async {
    setState(() {
      myStream = postCollection.orderBy('time', descending: true).snapshots();
    });
  }

  getData() async {
    var firebaseuser = FirebaseAuth.instance.currentUser;
    setState(() {
      email = firebaseuser.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor.withOpacity(0.9),
        title: Text(
          "Favourite Posts",
          style: GoogleFonts.nunito(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: 4,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () => Navigator.pushReplacement(
                context,
                PageTransition(
                    child: ForumPage(), type: PageTransitionType.fade)),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Column(
        children: [
          StreamBuilder(
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
                  : Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot post =
                              snapshot.data.documents[index];

                          return post
                                  .data()['likedBy']
                                  .contains(email.toString())
                              ? ForumCard(
                                  name: post.data()['name'],
                                  id: post.data()['id'],
                                  profilePic: post.data()['profilePic'],
                                  sem: post.data()['sem'],
                                  tags: post.data()['tags'],
                                  email: post.data()['email'],
                                  date: post.data()['date'],
                                  time: post.data()['time'],
                                  title: post.data()['title'],
                                  attachment: post.data()['attachment'],
                                  question: post.data()['question'],
                                  votes: post.data()['votes'],
                                  answers: post.data()['answers'],
                                  views: post.data()['views'],
                                )
                              : Container();
                        },
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
