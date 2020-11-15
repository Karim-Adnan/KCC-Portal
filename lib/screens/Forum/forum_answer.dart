import 'package:flutter/cupertino.dart';

class ForumAnswer extends StatefulWidget {

  final id, name, profilePic, sem, date, time, title, question, votes, answers, views;

  const ForumAnswer({Key key, this.id, this.name, this.profilePic, this.sem, this.date, this.time, this.title, this.question, this.votes, this.answers, this.views}) : super(key: key);

  @override
  _ForumAnswerState createState() => _ForumAnswerState();
}

class _ForumAnswerState extends State<ForumAnswer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
