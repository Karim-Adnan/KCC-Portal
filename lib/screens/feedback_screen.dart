import 'package:demo/components/drop_down_menu.dart';
import 'package:demo/constants.dart';
import 'package:demo/models/list_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              child: Image.asset('assets/illustrations/feedback.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Help us improve',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      Text('Please select a topic below and let us',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.normal,
                          fontSize: 18.0,
                          letterSpacing: 0.3,
                        ),
                      ),
                      Text('know about your concern',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.normal,
                          fontSize: 18.0,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            DropDownMenu(
              dropdownItems: [
                ListItem(1, "Select topic"),
                ListItem(2, "Add/modify a feature"),
                ListItem(3, "Something is wrong"),
                ListItem(4, "Other Problem"),
                ListItem(5, "Other Feedback")
              ],
              onChanged: (item) {

              },
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                style: GoogleFonts.nunito(
                  fontSize: 15.0,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
                width: MediaQuery.of(context).size.width * 0.5,
                child: RaisedButton(
                  child: Text('SUBMIT',
                    style: GoogleFonts.nunito(
                      color: Colors.white60,
                      fontWeight: FontWeight.w700,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      letterSpacing: 3.0,
                    ),
                  ),
                  elevation: 5.0,
                  color: kPrimaryColor,
                  onPressed: (){},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
