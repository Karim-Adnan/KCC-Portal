import 'dart:io';

import 'package:demo/components/forum_components/forum_card.dart';
import 'package:demo/database.dart';
import 'package:demo/screens/Forum/forum_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uuid/uuid.dart';

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
  var _fileName;

  @override
  void initState() {
    super.initState();
    getData();
    getStream();
  }

  getStream() async {
    setState(() {
      myStream = postCollection.orderBy('time', descending: true).snapshots();
    });
  }

  void getData() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDocument =
        await userCollection.doc(firebaseUser.email).get();
    userName =
        userDocument.get('first name') + " " + userDocument.get('last name');
    profilePic = userDocument.get('profilePic');
  }

  String getDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMM yy').format(now);
    String year = "'" + formattedDate.split(" ")[2];
    String date = formattedDate.split(" ")[0] +
        " " +
        formattedDate.split(" ")[1] +
        " " +
        year;
    return date;
  }

  postQuestion() async {
    setState(() {
      isLoading = true;
    });
    try {
      DateTime now = DateTime.now();
      var firebaseUser = await FirebaseAuth.instance.currentUser;
      String attachment = attachmentImagePath == null
          ? 'No attachment'
          : await uploadAttachmentImage();
      DocumentSnapshot userDocument =
          await userCollection.doc(firebaseUser.email).get();
      final id = postCollection.doc().id;
      postCollection.doc(id).set({
        'name': userName,
        'profilePic': profilePic,
        'sem': userDocument.get('semester'),
        'id': id,
        'title': titleController.text,
        'question': questionController.text,
        'attachment': attachment,
        'time': now.toString(),
        'date': getDate(),
        'votes': '0',
        'answers': '0',
        'views': '0',
      });
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ForumPage()));
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error=$e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // pickImage(ImageSource imageSource) async {
  //   final image = await ImagePicker()
  //       .getImage(source: imageSource, maxHeight: 670, maxWidth: 800);
  //   setState(() {
  //     attachmentImagePath = File(image.path);
  //   });
  //   Navigator.pop(context);
  // }

  _imgFromGallery() async {
    final image = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 670, maxWidth: 800);
    if (image != null) {
      setState(() {
        attachmentImagePath = File(image.path);
      });
      _fileName = attachmentImagePath.toString().split('/').last;
    }
  }

  _imgFromCamera() async {
    final image = await ImagePicker()
        .getImage(source: ImageSource.camera, maxHeight: 670, maxWidth: 800);
    if (image != null) {
      setState(() {
        attachmentImagePath = File(image.path);
      });
      _fileName = attachmentImagePath.toString().split('/').last;
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Choose attachment",
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

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

  String imageId = Uuid().v4();

  uploadAttachmentImage() async {
    //store image
    StorageUploadTask storage =
        attachments.child(imageId).putFile(attachmentImagePath);

    //complete image
    StorageTaskSnapshot storageTaskSnapshot = await storage.onComplete;

    //download pic
    String downloadPic = await storageTaskSnapshot.ref.getDownloadURL();

    return downloadPic;
  }

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          Size size = MediaQuery.of(context).size;
          return StatefulBuilder(builder: (context, setState) {
            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: AlertDialog(
                content: SingleChildScrollView(
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        // height: size.height * 0.6,
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
                                    color: kPrimaryLightColor,
                                    fontSize: size.width * 0.045,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: size.width * 0.005,
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
                              // thickness: 0.5,
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: size.width * 0.01,
                                      right: size.width * 0.04),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        profilePic), // Profile Image
                                    radius: size.width * 0.05,
                                  ),
                                ),
                                Text(
                                  userName,
                                  style: GoogleFonts.roboto(
                                    fontSize: size.width * 0.05,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
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
                                hintStyle:
                                    GoogleFonts.nunito(color: Colors.grey),
                              ),
                            ),
                            TextFormField(
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
                                  bottom: 20.0,
                                ),
                                hintText: 'What do you want to ask?',
                                hintStyle:
                                    GoogleFonts.nunito(color: Colors.grey),
                              ),
                            ),
                            Divider(
                              thickness: 0.5,
                              color: Colors.black,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Attachments:",
                                  style: GoogleFonts.nunito(
                                      fontSize: size.width * 0.05,
                                      color: Colors.grey),
                                ),
                                _fileName == null
                                    ? Container()
                                    : Text(
                                        _fileName.toString(),
                                        style: GoogleFonts.nunito(
                                          color: kPrimaryLightColor,
                                          fontSize: size.width * 0.045,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                // Container(
                                //   child: Image(
                                //       width: size.width * 0.5,
                                //       height: size.height * 0.2,
                                //       image: FileImage(
                                //           attachmentImagePath)),
                                // )
                              ],
                            ),
                            Row( 
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      attachmentImagePath = null;
                                      _fileName = null;
                                    });
                                    _showPicker(context);
                                  },
                                  child: Icon(
                                    Icons.attachment_outlined,
                                    color: kPrimaryLightColor,
                                    size: size.width * 0.06,
                                  ),
                                ),
                                // Spacer(
                                //   flex: 1,
                                // ),
                                // InkWell(
                                //   onTap: () {},
                                //   child: Icon(
                                //     FontAwesomeIcons.file,
                                //     color: kPrimaryLightColor,
                                //     size: size.width * 0.06,
                                //   ),
                                // ),
                                Spacer(
                                  flex: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (titleController.text.isEmpty) {
                                      if (Fluttertoast != null) {
                                        Fluttertoast.cancel();
                                      }
                                      Fluttertoast.showToast(
                                        msg: "Title cannot be empty",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                            Colors.red.withOpacity(0.9),
                                        textColor: Colors.white,
                                        fontSize: 16,
                                      );
                                    } else if (questionController
                                        .text.isEmpty) {
                                      if (Fluttertoast != null) {
                                        Fluttertoast.cancel();
                                      }
                                      Fluttertoast.showToast(
                                        msg: "Question cannot be empty",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                            Colors.red.withOpacity(0.9),
                                        textColor: Colors.white,
                                        fontSize: 16,
                                      );
                                    } else {
                                      postQuestion();
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          kPrimaryLightColor.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 20,
                                      ),
                                      child: Text(
                                        'Post',
                                        style: GoogleFonts.nunito(
                                          color: Colors.white,
                                        ),
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
              ),
            );
          });
        });
  }

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
            onPressed: () async {
              titleController.clear();
              questionController.clear();
              await showInformationDialog(context);
            },
            backgroundColor: kPrimaryDarkColor,
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
