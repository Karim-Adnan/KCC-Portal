import 'package:demo/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class NewQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var questionController = TextEditingController();
    var titleController = TextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: AlertDialog(
        content: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              height: size.height * 0.5,
              width: size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ask a Question!',
                        style: GoogleFonts.nunito(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                      InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.width * 0.01, right: size.width * 0.04),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/images/drawerImage.jpg'), // Profile Image
                          radius: size.width * 0.05,
                        ),
                      ),
                      Text(
                        'Adnan Karim',
                        style: GoogleFonts.roboto(
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: titleController,
                    style: GoogleFonts.nunito(
                      color: kPrimaryLightColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.75,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Title here',
                      hintStyle: GoogleFonts.nunito(color: Colors.grey),
                    ),
                  ),
                  TextField(
                    controller: questionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                    style: GoogleFonts.nunito(
                      color: Colors.grey.shade700,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      hintText: 'What do you want to ask?',
                      hintStyle: GoogleFonts.nunito(color: Colors.grey),
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          FontAwesomeIcons.solidImage,
                          color: Colors.black,
                          size: size.width * 0.06,
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          FontAwesomeIcons.file,
                          color: Colors.black,
                          size: size.width * 0.06,
                        ),
                      ),
                      Spacer(
                        flex: 10,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300.withOpacity(0.75),
                              borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20),
                            child: Text(
                              'Post',
                              style: GoogleFonts.nunito(
                                  color: Colors.grey.shade800),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}