import 'package:KCC_Portal/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPdfScreen extends StatelessWidget {
  final url;
  final appBarTitle;

  const ViewPdfScreen({Key key, this.url, this.appBarTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(backgroundColor: kPrimaryColor, title: Text(appBarTitle)),
        body: Container(
            child: SfPdfViewer.network(
          url,
        )));
  }
}
