import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Quotelist(),
  ));
}

class Quotelist extends StatefulWidget {
  @override
  _QuotelistState createState() => _QuotelistState();
}

class _QuotelistState extends State<Quotelist> {

  List<String> quotes = [
    'My name is adnan'
    'my name is kaif'
    'my name is karim'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Awesome quotes!'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: quotes.map((quote) => Text(quote)).toList(),
      )
    );

    
  }
}