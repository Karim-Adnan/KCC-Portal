import 'package:KCC_Portal/constants.dart';
import 'package:flutter/material.dart';

class StudyMaterialCard extends StatefulWidget {
  final content;
  final Function setPreference;
  final Function onTap;
  final image;
  final TextStyle textStyle;

  const StudyMaterialCard({this.content, this.setPreference, this.onTap, this.image, this.textStyle});

  @override
  _StudyMaterialCard createState() => _StudyMaterialCard();
}

class _StudyMaterialCard extends State<StudyMaterialCard> {


  @override
  void initState() {
    super.initState();
    widget.setPreference();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: size.height * 0.15,
      width: size.width * 0.1,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kPrimaryLightColor,
            offset: Offset(-5, -5),
            blurRadius: 10,
            spreadRadius: 5,
          ),
          BoxShadow(
            color: kPrimaryDarkColor,
            offset: Offset(5, 5),
            blurRadius: 10,
            spreadRadius: 10,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => widget.onTap,
        child: Card(
          color: Colors.white.withOpacity(0.9),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    flex: 1,
                    child: Image(
                      height: 50,
                      image: AssetImage('assets/icons/${widget.image}'),
                    )),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      widget.content,
                      style: widget.textStyle,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}