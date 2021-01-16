import 'package:KCC_Portal/components/reusable_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../database.dart';
import '../view_pdf_screen.dart';

class CollegeNoticesTab extends StatefulWidget {
  @override
  _CollegeNoticesTabState createState() => _CollegeNoticesTabState();
}

class _CollegeNoticesTabState extends State<CollegeNoticesTab> {
  bool isLoading;
  List<Map<String, dynamic>> _notices = [];

  void getData() async {
    if (this.mounted) {
      setState(() {
        isLoading = true;
      });
    }

    final DocumentSnapshot documents =
        await noticeCollection.doc('CollegeNotices').get();

    if (this.mounted) {
      setState(() {
        documents.data().forEach((key, value) {
          _notices.add({
            'notice': key.toString(),
            'link': value['link'].toString(),
            'date': value['date'].toString(),
            'sem': value['sem'].toString(),
          });
        });
      });
    }
     if (this.mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? SpinKitWave(itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(color: Colors.blue),
            );
          })
        : Scaffold(
            body: Container(
                child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => ReusableCard(
                title: _notices[index]['notice'],
                trianglePainterTitle: _notices[index]['date'],
                onPress: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewPdfScreen(
                              appBarTitle: _notices[index]['notice'],
                              url: _notices[index]['link'],
                            ))),
                colour: Colors.grey[200],
                height: size.height * 0.18,
              ),
              itemCount: _notices.length,
            )),
          );
  }
}
