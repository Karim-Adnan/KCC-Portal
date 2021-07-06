import 'package:flutter/material.dart';

class PreviewImage extends StatelessWidget {
  final image;
  final index;

  const PreviewImage({Key key, this.image, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
            child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        )),
      ),
      body: Center(
        child: Hero(
          tag: 'attachment $index',
          child: Image.network(
            image,
          ),
        ),
      ),
    );
  }
}
