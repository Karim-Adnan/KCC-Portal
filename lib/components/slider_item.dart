import 'package:KCC_Portal/screens/webview.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SliderItem extends StatelessWidget {
  final String url;
  final String linkTitle;
  final String image;
  SliderItem({Key key,this.url,this.linkTitle,this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, PageTransition(type: PageTransitionType.fade,duration: Duration(milliseconds: 300), child: WebViewContainer(url, linkTitle)),
            // MaterialPageRoute(builder: (context) => WebViewContainer(url, linkTitle))
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          image: DecorationImage(
            image: AssetImage('assets/images/$image'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}