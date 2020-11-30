
import 'package:demo/components/forum_components/forum_card.dart';
import 'package:demo/database.dart';
import 'package:demo/screens/Forum/forum_new_post.dart';
import 'package:demo/screens/Forum/forum_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var questionController = TextEditingController();
  var titleController = TextEditingController();
  var userName, profilePic;
  Stream myStream;
  var attachmentImagePath;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    getStream();
  }

  getStream() async {
    setState(() {
      myStream = postCollection.orderBy('time', descending: true).snapshots();
    });
  }

  // pickImage(ImageSource imageSource) async {
  //   final image = await ImagePicker()
  //       .getImage(source: imageSource, maxHeight: 670, maxWidth: 800);
  //   setState(() {
  //     attachmentImagePath = File(image.path);
  //   });
  //   Navigator.pop(context);
  // }

  // pickImageDialog() {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return SimpleDialog(
  //           title: Column(children: [
  //             Text(
  //               "Choose attachment",
  //               style: GoogleFonts.nunito(color: Colors.black87,)
  //             ),
  //             Divider(
  //               thickness: 0.5,
  //               color: Colors.black,
  //             ),
  //           ]),
  //           children: [
  //             SimpleDialogOption(
  //               onPressed: () => pickImage(ImageSource.gallery),
  //               child: Text("From Galley",
  //                   style:
  //                       GoogleFonts.nunito(fontSize: 20, color: kPrimaryLightColor)),
  //             ),
  //             SimpleDialogOption(
  //               onPressed: () => pickImage(ImageSource.camera),
  //               child: Text("From Camera",
  //                   style:
  //                       GoogleFonts.nunito(fontSize: 20, color: kPrimaryLightColor)),
  //             ),
  //             SimpleDialogOption(
  //               onPressed: () => Navigator.pop(context),
  //               child: Text("Cancel",
  //                   style:
  //                       GoogleFonts.nunito(fontSize: 20, color: kPrimaryLightColor)),
  //             ),
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    Size size = MediaQuery.of(context).size;

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          body: Container(
            height: double.infinity,
            color: kSecondaryLightColor.withOpacity(0.15),
            child: Column(
              children: [
                Container(
                  height: size.height * 0.17,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: size.height * 0.025),
                        color: kPrimaryLightColor.withOpacity(0.9),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.025,
                              bottom: size.height * 0.01),
                          child: Row(
                            children: [
                              IconButton(
                                padding: EdgeInsets.all(size.width * 0.04),
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  'Forum',
                                  style: GoogleFonts.nunito(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 4,
                                  ),
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.all(size.width * 0.04),
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(0, 1),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  child: SearchForum(),
                                  type: PageTransitionType.fade),
                            );
                          }, // Open Search Screen

                          child: Container(
                            height: size.height * 0.06,
                            width: size.width * 0.7,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: size.width * 0.008,
                                color: kPrimaryLightColor.withOpacity(0.9),
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(size.width * 0.03),
                                topRight: Radius.circular(size.width * 0.03),
                                bottomLeft: Radius.circular(size.width * 0.09),
                                bottomRight: Radius.circular(size.width * 0.09),
                              ),
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.05,
                                    ),
                                    child: Icon(
                                      Icons.search,
                                      size: size.width * 0.05,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                  Text(
                                    'Looking for answers?',
                                    style: GoogleFonts.nunito(
                                      color: Colors.grey.shade500,
                                      fontSize: size.width * 0.04,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                StreamBuilder(
                  stream: myStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    return snapshot.data.documents.length == 0
                        ? Center(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    height: size.height * 0.5,
                                    width: size.width * 0.7,
                                    child: Image.asset(
                                        "assets/illustrations/no_posts.png"),
                                  ),
                                  Text(
                                    "No Posts",
                                    style: GoogleFonts.nunito(
                                      fontSize: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot post =
                                    snapshot.data.documents[index];
                                return ForumCard(
                                  name: post.data()['name'],
                                  id: post.data()['id'],
                                  profilePic: post.data()['profilePic'],
                                  sem: post.data()['sem'],
                                  date: post.data()['date'],
                                  time: post.data()['time'],
                                  title: post.data()['title'],
                                  attachment: post.data()['attachment'],
                                  question: post.data()['question'],
                                  votes: post.data()['votes'],
                                  answers: post.data()['answers'],
                                  views: post.data()['views'],
                                );
                              },
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              titleController.clear();
              questionController.clear();
              Navigator.push(context, PageTransition(child: ForumNewQuestion(), type: PageTransitionType.fade));
            },
            backgroundColor: kPrimaryDarkColor,
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
