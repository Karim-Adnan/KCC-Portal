import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/constants.dart';
import 'package:demo/database.dart';
import 'package:demo/screens/Forum/forum_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ForumNewQuestion extends StatefulWidget {
  @override
  _ForumNewQuestionState createState() => _ForumNewQuestionState();
}

class _ForumNewQuestionState extends State<ForumNewQuestion> {
  var questionController = TextEditingController();
  var titleController = TextEditingController();
  var userName, profilePic;
  var _fileName;
  var attachmentImagePath;
  var isLoading = false;
  String imageId = Uuid().v4();
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

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDocument =
        await userCollection.doc(firebaseUser.email).get();
    userName =
        userDocument.get('first name') + " " + userDocument.get('last name');
    profilePic = userDocument.get('profilePic');
  }

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Ask a Question!',
            style: GoogleFonts.nunito(
              color: kPrimaryLightColor,
              fontSize: size.width * 0.06,
              fontWeight: FontWeight.w700,
              letterSpacing: size.width * 0.005,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: size.width * 0.05,
                    bottom: size.width * 0.08,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.width * 0.01, right: size.width * 0.04),
                        child: CircleAvatar(
                          // backgroundImage: NetworkImage(profilePic), // Profile Image
                          radius: size.width * 0.05,
                        ),
                      ),
                      Text(
                        "userName",
                        style: GoogleFonts.roboto(
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  controller: titleController,
                  style: GoogleFonts.nunito(
                    color: kPrimaryLightColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.75,
                  ),
                  // decoration: InputDecoration(
                  //   border: InputBorder.none,
                  //   focusedBorder: InputBorder.none,
                  //   enabledBorder: InputBorder.none,
                  //   errorBorder: InputBorder.none,
                  //   disabledBorder: InputBorder.none,
                  //   hintText: 'Title here',
                  //   hintStyle: GoogleFonts.nunito(color: Colors.grey),
                  // ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'Title here',
                    hintStyle: GoogleFonts.nunito(color: Colors.grey),
                    helperText: 'Write the title of your question here',
                    prefixIcon: Icon(
                      FontAwesomeIcons.questionCircle,
                      color: Colors.green,
                    ),
                    prefixText: ' ',
                  ),
                ),
                SizedBox(
                  height: size.width * 0.06,
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
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'What do you want to ask?',
                    hintStyle: GoogleFonts.nunito(color: Colors.grey),
                    helperText: 'Write the title of your question here',
                    contentPadding: EdgeInsets.only(
                      bottom: size.width * 0.048,
                      left: size.width * 0.039,
                      right: size.width * 0.039,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.width * 0.06,
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
                          fontSize: size.width * 0.05, color: Colors.grey),
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
                        // _showPicker(context);
                      },
                      child: Icon(
                        Icons.attachment_outlined,
                        color: kPrimaryLightColor,
                        size: size.width * 0.06,
                      ),
                    ),
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
                            backgroundColor: Colors.red.withOpacity(0.9),
                            textColor: Colors.white,
                            fontSize: size.width * 0.045,
                          );
                        } else if (questionController.text.isEmpty) {
                          if (Fluttertoast != null) {
                            Fluttertoast.cancel();
                          }
                          Fluttertoast.showToast(
                            msg: "Question cannot be empty",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red.withOpacity(0.9),
                            textColor: Colors.white,
                            fontSize: size.width * 0.045,
                          );
                        } else {
                          postQuestion();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kPrimaryLightColor.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(size.width * 0.065),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size.width * 0.033,
                            horizontal: size.width * 0.075,
                          ),
                          child: Text(
                            'Post',
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700,
                              fontSize: size.width * 0.045,
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
        ),
      ),
    );
  }
}
