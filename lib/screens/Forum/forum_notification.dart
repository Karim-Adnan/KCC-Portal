import 'package:KCC_Portal/components/forum_components/forum_notification_cards.dart';
import 'package:KCC_Portal/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants.dart';
import 'forum_screen.dart';

class ForumNotification extends StatefulWidget {
  @override
  _ForumNotificationState createState() => _ForumNotificationState();
}

class _ForumNotificationState extends State<ForumNotification> {
  var email;
  bool isLoading;
  void getData() async {
    setState(() {
      isLoading = true;
    });
    var firebaseUser = FirebaseAuth.instance.currentUser;
    setState(() {
      email = firebaseUser.email;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Notifications'),
          backgroundColor: kPrimaryLightColor.withOpacity(0.9),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: ForumPage(), type: PageTransitionType.fade))),
        ),
        body: isLoading
            ? SpinKitWave(itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(color: Colors.blue),
                );
              })
            : StreamBuilder(
                stream: userCollection
                    .doc(email)
                    .collection('forumNotifications')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  return ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                            color: Colors.black,
                          ),
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot notification =
                            snapshot.data.documents[index];
                        return ForumNotificationCards(
                          id: notification.data()['id'],
                          title: notification.data()['title'],
                          subtitle: notification.data()['reply'],
                          profilePic: notification.data()['profilePic'],
                          time: notification.data()['time'],
                          postId: notification.data()['postId'],
                          viewed: notification.data()['viewed'],
                        );
                      });
                }));
  }
}
