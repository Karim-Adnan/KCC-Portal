import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AboutCard extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function onTap;
  final String head;
  AboutCard({
    Key key,
    @required this.iconData,
    @required this.title,
    @required this.onTap,
    @required this.head
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                head,
                style: TextStyle(fontSize: 20.0, color: Colors.grey[600]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(iconData, color: kPrimaryDarkColor, size: 32.0,),
                SizedBox(width: 5.0,),
                Expanded(
                  child: Card(
                    shadowColor: Colors.black,
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        title,
                        maxLines: 3,
                        style: TextStyle(fontSize: 20.0, color: kPrimaryColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}