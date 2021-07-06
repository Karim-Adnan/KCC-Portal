import 'package:KCC_Portal/database.dart';
import 'package:KCC_Portal/screens/Forum/forum_answer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ForumNotificationCards extends StatefulWidget {
  final title;
  final subtitle;
  final time;
  final profilePic;
  final viewed;
  final postId;
  final id;

  const ForumNotificationCards(
      {Key key,
      this.title,
      this.subtitle,
      this.time,
      this.profilePic,
      this.viewed,
      this.postId,
      this.id})
      : super(key: key);

  @override
  _ForumNotificationCardsState createState() => _ForumNotificationCardsState();
}

class _ForumNotificationCardsState extends State<ForumNotificationCards> {
  var postName,
      postProfilePic,
      postSem,
      postDate,
      postTime,
      postTitle,
      postQuestion,
      postVotes,
      postAnswers,
      postViews,
      postAttachment,
      postTags,
      postEmail;
  var currentUserEmail;
  bool isLoading;

  void getCurrentUserEmail() async {
    setState(() {
      isLoading = true;
    });
    var firebaseUser = FirebaseAuth.instance.currentUser;
    setState(() {
      currentUserEmail = firebaseUser.email;
      isLoading = false;
    });
  }

  void getPostData() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot postDocument =
        await postCollection.doc(widget.postId).get();
    postName = postDocument.get('name');
    postProfilePic = postDocument.get('profilePic');
    postSem = postDocument.get('sem');
    postDate = postDocument.get('date');
    postTime = postDocument.get('time');
    postTitle = postDocument.get('title');
    postQuestion = postDocument.get('question');
    postVotes = postDocument.get('votes');
    postAnswers = postDocument.get('answers');
    postViews = postDocument.get('views');
    postAttachment = postDocument.get('attachment');
    postTags = postDocument.get('tags');
    postEmail = postDocument.get('email');
    setState(() {
      isLoading = false;
    });
  }

  String getTimeAgo(var time) {
    var secondsToAdd = new Duration(seconds: 10);
    var parsedDateTime = DateTime.parse(time);
    var dateForComparison = parsedDateTime.add(secondsToAdd);
    var moment = new Moment.now();

    return moment.from(dateForComparison).toString();
  }

  postViewed() async {
    await userCollection
        .doc(currentUserEmail)
        .collection('forumNotifications')
        .doc(widget.id)
        .update({'viewed': true});
  }

  @override
  void initState() {
    super.initState();
    getPostData();
    getCurrentUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: ListTile(
        tileColor: widget.viewed ? Colors.white : Colors.grey[200],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => ForumAnswer(
                  id: widget.postId,
                  name: postName,
                  profilePic: postProfilePic,
                  sem: postSem,
                  date: postDate,
                  time: postTime,
                  title: postTitle,
                  question: postQuestion,
                  votes: postVotes,
                  answers: postAnswers,
                  views: postViews,
                  attachment: postAttachment,
                  tags: postTags,
                  email: postEmail,
                ),
              ));
          postViewed();
        },
        title: Text(widget.title),
        subtitle: Text(widget.subtitle),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.profilePic),
        ),
        trailing: Text(getTimeAgo(widget.time)),
      ),
    );
  }
}
