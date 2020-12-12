import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const ProfileCard({Key key, this.title, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      height: size.height * 0.1,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            topRight: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        elevation: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.15,
              child: Icon(icon),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: size.width * 0.05,
                    ),
                  ),
                )),
          ],
        ),
        color: Colors.white,
      ),
    );
  }
}