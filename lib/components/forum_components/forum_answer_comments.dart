import 'package:demo/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popup_menu/popup_menu.dart';
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
  bool upVoted = false;
  bool downVoted = false;
  bool isReplying = false;

  _pressedUp() async {
    setState(() {
      upVoted = !upVoted;
    });
  }

  _pressedDown() async {
    setState(() {
      downVoted = !downVoted;
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey keyBtn = GlobalKey();
    PopupMenu.context = context;
    Size size = MediaQuery.of(context).size;
    int upvoteCount = 7;

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
      child: Container(
        margin: EdgeInsets.all(size.width * 0.006),
        constraints: BoxConstraints(
          minHeight: 70,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.black.withOpacity(0.2)),
          ),
        ),
        child: Column(
          children: [
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
                    decoration:
                        BoxDecoration(color: kSecondaryColor.withOpacity(0.2)),
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
                            controller: null, //NEED A CONTROLLER
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
                            onPressed: () {},
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
