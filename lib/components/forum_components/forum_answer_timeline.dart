import 'package:demo/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ForumTimelineTile extends StatelessWidget {
  final String reply;
  final String image;
  final String replyCount;
  const ForumTimelineTile(
      {Key key, @required this.reply, @required this.image, this.replyCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return TimelineTile(
      beforeLineStyle: LineStyle(
        color: kPrimaryDarkColor,
      ),
      indicatorStyle: IndicatorStyle(
        width: size.width * 0.14,
        height: size.width * 0.14,
        padding: EdgeInsets.all(8),
        indicator: CircleAvatar(
          child: ClipOval(
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ), // Profile Image
          radius: size.width * 0.07,
        ),
      ),
      alignment: TimelineAlign.start,
      endChild: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Container(
          constraints: BoxConstraints(
            minHeight: 70,
          ),
          decoration: BoxDecoration(
            color: kSecondaryLightColor.withOpacity(0.5),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.02,
              right: size.width * 0.02,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        reply,
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // ExpansionTile(
                //   title: Text('View all replies ($replyCount)'),
                //   trailing: Icon(FontAwesomeIcons.chevronDown),
                //   children: [
                //     ForumTimelineTile(
                //       reply: 'Lorem Ipsum is simply dummy textm.',
                //       image:
                //           'https://i.pinimg.com/originals/a6/58/32/a65832155622ac173337874f02b218fb.png',
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
