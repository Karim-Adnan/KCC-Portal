import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/components/drop_down_menu.dart';
import 'package:demo/constants.dart';
import 'package:demo/custom_drawer/drawer_user_controller.dart';
import 'package:demo/custom_drawer/home_drawer.dart';
import 'package:demo/models/list_item.dart';
import 'package:demo/screens/homepage.dart';
import 'package:demo/screens/navigation_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../database.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  var feedbackController = TextEditingController();
  String topic;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool showSpinner= false;

  sendFeedback() async{

    setState(() {
      showSpinner=true;
    });
    try{
      var firebaseUser = await FirebaseAuth.instance.currentUser;
      final id = userCollection.doc(firebaseUser.email).collection('feedBacks').doc().id;
      userCollection.doc(firebaseUser.email).collection('feedBacks').doc(id)
          .set({
        'topic': topic,
        'response': feedbackController.text
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
      setState(() {
        showSpinner=false;
      });
    }catch(e){
      print(e);
    }

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
     child: ModalProgressHUD(
       inAsyncCall: showSpinner,
       child: SafeArea(
         child: Scaffold(
           key: scaffoldKey,
           backgroundColor: Colors.white,
           body: Container(
             width: double.infinity,
             height: size.height,
             child: SingleChildScrollView(
               child: Column(
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
                       ListItem(1, "Add/modify a feature"),
                       ListItem(2, "Something is wrong"),
                       ListItem(3, "Other Problem"),
                       ListItem(4, "Other Feedback")
                     ],
                     onChanged: (item) {
                       setState(() {
                         topic = item.name;
                       });
                     },
                     hint: "Select Toipc",
                   ),
                   Container(
                     width: MediaQuery.of(context).size.width * 0.85,
                     child: TextField(
                       controller: feedbackController,
                       keyboardType: TextInputType.multiline,
                       maxLines: 7,
                       decoration: kTextFieldDecoration,
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
                         onPressed: (){
                          if(topic==null){
                             SnackBar snackbar = SnackBar(content: Text("Please select the topic"));
                             scaffoldKey.currentState.showSnackBar(snackbar);
                           }else if(feedbackController.text.isEmpty){
                            SnackBar snackbar = SnackBar(content: Text("Please write your feedback"));
                            scaffoldKey.currentState.showSnackBar(snackbar);
                          }else{
                             sendFeedback();
                           }
                         },
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ),
         ),
       ),
     ),
    );
  }
}
