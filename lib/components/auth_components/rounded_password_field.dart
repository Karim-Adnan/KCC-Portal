import 'package:KCC_Portal/constants.dart';
import 'package:flutter/material.dart';


class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String hintText;
  RoundedPasswordField({Key key, this.onChanged, this.controller, this.hintText}) : super(key: key);
  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isObscure=true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: size.height * 0.0003),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: isObscure,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                isObscure = !isObscure;
              });
            },
            child: Icon(
              Icons.visibility,
              color: kPrimaryColor,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}