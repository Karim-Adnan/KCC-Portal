import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewPdfScreen extends StatefulWidget {
  @override
  _ViewPdfScreenState createState() => _ViewPdfScreenState();
}

class _ViewPdfScreenState extends State<ViewPdfScreen> {

  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromURL('https://abesit.in/library/download/B.Tech./Sem.5/2019-20/DATA-BASE-MANAGEMENT-SYSTEM-RCS-501.pdf');

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DATA-BASE-MANAGEMENT-SYSTEM-RCS-501"
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: _isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : PDFViewer(
          document: document,
        ),
      ),
    );
  }
}
