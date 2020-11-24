import 'package:demo/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ForumReplyTile extends StatefulWidget {
  final String reply;
  final String profilePic;
  final String replyCount;
  final String userName, date;
  const ForumReplyTile(
      {Key key,
      @required this.reply,
      @required this.profilePic,
      this.replyCount,
      this.userName,
      this.date})
      : super(key: key);

  @override
  _ForumReplyTileState createState() => _ForumReplyTileState();
}

class _ForumReplyTileState extends State<ForumReplyTile> {
  bool liked = false;

  _pressed() async {
    setState(() {
      liked = !liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
          // vertical: 10,
          ),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 70,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.only(
          //   topRight: Radius.circular(15),
          //   bottomRight: Radius.circular(15),
          // ),
          border: Border(
            bottom: BorderSide(color: Colors.black.withOpacity(0.2)),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                    left: 15.0,
                    right: 10.0,
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.profilePic),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userName,
                      style: GoogleFonts.roboto(
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    Text(
                      widget.date,
                      style: GoogleFonts.roboto(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                bottom: size.width * 0.02,
              ),
              child: Row(
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
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _pressed();
                  },
                  child: Container(
                    height: size.width * 0.08,
                    child: liked ? Image.asset("assets/icons/vote/upvote_fill.png")
                        : Image.asset("assets/icons/vote/upvote.png"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // TimelineTile(
    //   beforeLineStyle: LineStyle(
    //     color: kPrimaryDarkColor,
    //   ),
    //   hasIndicator: false,
    //   alignment: TimelineAlign.start,
    //   endChild: ,
    // );
  }
}
