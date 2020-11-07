import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewPdfScreen extends StatefulWidget {
  @override
  _ViewPdfScreenState createState() => _ViewPdfScreenState();
}

class _ViewPdfScreenState extends State<ViewPdfScreen> {
  bool _isLoading = true;
  PDFDocument document;
  String url;
  String appBarTitle;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String selectedSem = await prefs.getString("SelectedSem");
    String selectedYear = await prefs.getString("SelectedYear");
    String selectedSubject = await prefs.getString("SelectedSubject");
    // print("selectedSem=$selectedSem selectedYear=$selectedYear selectedSubject=$selectedSubject");
    final DocumentSnapshot result = await FirebaseFirestore.instance
        .collection('questionPapers')
        .doc(selectedSem)
        .collection(selectedYear)
        .doc(selectedSubject.trim())
        .get();
    setState(() {
      appBarTitle = selectedSubject.toString();
      url = result.get('link');
    });
    // print("Url=$url");
    document = await PDFDocument.fromURL(url);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: AppBar(
              title: Text(
                appBarTitle,
              ),
            ),
            backgroundColor: Colors.white,
            body: Center(
              child: PDFViewer(
                document: document,
              ),
            ),
          );
  }
}
