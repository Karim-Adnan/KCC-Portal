import 'dart:io';
import 'package:KCC_Portal/constants.dart';
import 'package:KCC_Portal/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfileInfo extends StatefulWidget {
  final String name;
  final String profileImage;

  const ProfileInfo({
    this.name,
    this.profileImage,
  });

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  bool isOnline = true;
  Stream myStream;
  bool showSpinner = false;
  File imagePath;

  getStream() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    setState(
        () => myStream = userCollection.doc(firebaseUser.email).snapshots());
  }

  storeProfilePic() async {
    setState(() => showSpinner = true);
    var firebaseUser = await FirebaseAuth.instance.currentUser;

    String downloadPic = imagePath == null
        ? "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-photo-183042379.jpg"
        : await uploadImage();
    userCollection
        .doc(firebaseUser.email)
        .set({'profilePic': downloadPic}, SetOptions(merge: true));
    setState(() {
      showSpinner = false;
    });
  }

  pickImage(ImageSource imageSource) async {
    final image = await ImagePicker()
        .getImage(source: imageSource, maxHeight: 670, maxWidth: 800);
    setState(() => imagePath = File(image.path));
    storeProfilePic();
    Navigator.pop(context);
  }

  pickImageDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () => pickImage(ImageSource.gallery),
                child: Text(
                  "From Galley",
                  style: TextStyle(
                    fontSize: 20,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => pickImage(ImageSource.camera),
                child: Text(
                  "From Camera",
                  style: TextStyle(
                    fontSize: 20,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 20,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          );
        });
  }

  uploadImage() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    //store image
    UploadTask storage =
        profilePics.child(firebaseUser.email).putFile(imagePath);

    //complete image
    TaskSnapshot storageTaskSnapshot = await storage;

    //download pic
    String downloadPic = await storageTaskSnapshot.ref.getDownloadURL();

    return downloadPic;
  }

  @override
  void initState() {
    super.initState();
    getStream();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.06,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.width * 0.02,
              ),
              child: GestureDetector(
                onTap: () => pickImageDialog(),
                child: Container(
                  height: size.width * 0.25,
                  width: size.width * 0.25,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: size.width * 0.0375,
                        spreadRadius: size.width * 0.005,
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(widget.profileImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  // child: CircleAvatar(
                  //   radius: size.width * 0.125,
                  //   backgroundImage: NetworkImage(widget.profileImage),
                  // ),
                ),
              ),
            ),
            SizedBox(
              height: size.width * 0.025,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.name,
                    style: GoogleFonts.josefinSans(
                      color: Colors.white,
                      fontSize: size.width * 0.15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 5,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  isOnline ? '• ONLINE' : '• OFFLINE',
                  style: GoogleFonts.montserrat(
                    color:
                        isOnline ? Colors.lightGreenAccent : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                    shadows: [
                      Shadow(
                        color: Colors.white.withOpacity(0.3),
                        blurRadius: size.width * 0.025,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
