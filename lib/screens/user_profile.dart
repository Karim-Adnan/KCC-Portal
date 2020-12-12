import 'dart:io';
import 'dart:ui';
import 'package:KCC_Portal/components/profile_components/header_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:KCC_Portal/components/profile_components/profile_page_card.dart';
import 'package:KCC_Portal/constants.dart';
import 'package:KCC_Portal/database.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Stream myStream;
  File imagePath;
  bool showSpinner = false;
  bool isOnline = true;

  getStream() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    setState(() {
      myStream = userCollection.doc(firebaseUser.email).snapshots();
    });
  }

  storeProfilePic() async {
    setState(() {
      showSpinner = true;
    });
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
    setState(() {
      imagePath = File(image.path);
    });
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

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: StreamBuilder(
          stream: myStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    snapshot.data['profilePic'],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.width * 0.15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.06,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeaderButton(
                            icon: CupertinoIcons.chevron_back,
                            iconColor: Colors.white,
                            iconSize: size.width * 0.07,
                            onTap: () => Navigator.pop(context),
                          ),
                          HeaderButton(
                            icon: FontAwesomeIcons.ellipsisH,
                            iconColor: Colors.white,
                            iconSize: size.width * 0.05,
                            onTap: null,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.38,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.06,
                        vertical: size.width * 0.02,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.6),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: size.width * 0.125,
                          backgroundImage: NetworkImage(
                            snapshot.data['profilePic'],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.06,
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${snapshot.data['first name']} \n${snapshot.data['last name']}',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: size.width * 0.15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.06,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            isOnline ? '• ONLINE' : '• OFFLINE',
                            style: GoogleFonts.montserrat(
                              color: isOnline
                                  ? Colors.lightGreenAccent
                                  : Colors.grey[500],
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                              shadows: [
                                Shadow(
                                  color: Colors.white.withOpacity(0.2),
                                  offset: Offset(2, 0),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
            //   Stack(
            //   children: [
            //     Positioned(
            //       child: Container(
            //         height: MediaQuery.of(context).size.height * 0.4,
            //         decoration: BoxDecoration(
            //           image: DecorationImage(
            //             image: NetworkImage(
            //               snapshot.data['profilePic'],
            //             ),
            //             fit: BoxFit.cover,
            //           ),
            //         ),
            //         child: BackdropFilter(
            //           filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            //           child: Container(
            //             decoration:
            //                 BoxDecoration(color: Colors.white.withOpacity(0.0)),
            //           ),
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.all(size.width * 0.03),
            //       child: Align(
            //         alignment: Alignment.topLeft,
            //         child: InkWell(
            //           onTap: () => Navigator.pop(context),
            //           child: Icon(
            //             CupertinoIcons.back,
            //             color: Colors.white,
            //             size: 32.0,
            //           ),
            //         ),
            //       ),
            //     ),
            //     Align(
            //       alignment: Alignment.bottomCenter,
            //       child: Container(
            //         // padding: EdgeInsets.all(100.0),
            //         width: double.infinity,
            //         height: size.height / 1.4,
            //         decoration: BoxDecoration(
            //           gradient: LinearGradient(
            //               begin: Alignment.bottomCenter,
            //               end: Alignment.topCenter,
            //               colors: <Color>[
            //                 Color(0xFF0F427C),
            //                 Color(0xDF1dc4d8),
            //               ]),
            //           borderRadius: BorderRadius.only(
            //             topRight: Radius.circular(size.width * 0.12),
            //             topLeft: Radius.circular(size.width * 0.12),
            //           ),
            //         ),
            //         child: Container(
            //           margin: EdgeInsets.only(top: size.width * 0.18),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             children: [
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text(
            //                     '${snapshot.data['first name']} ${snapshot.data['last name']}',
            //                     style: TextStyle(
            //                       fontSize: 30.0,
            //                       color: Colors.grey[100],
            //                       shadows: <Shadow>[
            //                         Shadow(
            //                           offset: Offset(3.0, 3.0),
            //                           blurRadius: 3.0,
            //                           color: Colors.grey[900],
            //                         ),
            //                         Shadow(
            //                           offset: Offset(5.0, 5.0),
            //                           blurRadius: 10.0,
            //                           color: Colors.black12,
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               ProfileCard(
            //                 title: snapshot.data['email'],
            //                 icon: Icons.email,
            //               ),
            //               ProfileCard(
            //                 title: snapshot.data['mobile number'],
            //                 icon: Icons.phone,
            //               ),
            //               ProfileCard(
            //                 title: snapshot.data['roll number'],
            //                 icon: FontAwesomeIcons.university,
            //               ),
            //               ProfileCard(
            //                 title:
            //                     '${snapshot.data['department']}-${snapshot.data['semester']}',
            //                 icon: FontAwesomeIcons.userGraduate,
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     Positioned(
            //       top: size.height * 0.10,
            //       left: size.width * 0.46,
            //       // alignment: Alignment.bottomRight,
            //       child: Container(
            //         height: size.height * 0.4,
            //         width: size.width * 0.85,
            //         child: FlareActor(
            //           'assets/penguin_nodding.flr',
            //           alignment: Alignment.center,
            //           fit: BoxFit.fill,
            //           animation: 'music_walk',
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.only(top: size.height * 0.15),
            //       child: Align(
            //         alignment: Alignment.topCenter,
            //         child: Container(
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(75.0),
            //               boxShadow: [
            //                 BoxShadow(
            //                     color: Colors.black26,
            //                     offset: Offset(4.0, 4.0),
            //                     blurRadius: 15.0,
            //                     spreadRadius: 1.0),
            //               ],
            //             ),
            //             child: Container(
            //               height: size.width * 0.35,
            //               width: size.width * 0.35,
            //               child: Stack(
            //                 children: [
            //                   ClipOval(
            //                     child: Image.network(
            //                       snapshot.data['profilePic'] == null
            //                           ? 'https://www.pngkit.com/png/full/72-729613_icons-logos-emojis-user-icon-png-transparent.png'
            //                           : snapshot.data['profilePic'],
            //                       height: size.width * 0.35,
            //                       width: size.width * 0.35,
            //                       fit: BoxFit.cover,
            //                     ),
            //                   ),
            //                   GestureDetector(
            //                     onTap: () {
            //                       pickImageDialog();
            //                     },
            //                     child: Align(
            //                       alignment: Alignment.bottomRight,
            //                       child: CircleAvatar(
            //                         backgroundColor: Colors.blueGrey[600],
            //                         radius: size.width * 0.05,
            //                         child: Icon(
            //                           CupertinoIcons.pen,
            //                           color: Colors.white,
            //                           size: size.width * 0.05,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             )),
            //       ),
            //     ),
            //   ],
            // );
          },
        ),
      ),
    );
  }
}
