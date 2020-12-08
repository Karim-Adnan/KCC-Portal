import 'dart:io';
import 'dart:ui';
import 'package:KCC_Portal/constants.dart';
import 'package:KCC_Portal/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Stream myStream;
  File imagePath;
  bool showSpinner= false;

  getStream() async{
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    setState(() {
      myStream = userCollection
          .doc(firebaseUser.email).snapshots();
    });
  }

  storeProfilePic() async{
    setState(() {
      showSpinner=true;
    });
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    
    String downloadPic = imagePath == null ?
    "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-photo-183042379.jpg"
        : await uploadImage();
    userCollection.doc(firebaseUser.email).set({
      'profilePic' : downloadPic
    }, SetOptions(merge: true));
    setState(() {
      showSpinner=false;
    });
  }


  pickImage(ImageSource imageSource) async{
    final image = await ImagePicker().getImage(
        source: imageSource,
        maxHeight: 670,
        maxWidth: 800
    );
    setState(() {
      imagePath = File(image.path);
    });
    storeProfilePic();
    Navigator.pop(context);
  }

  pickImageDialog(){
    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () => pickImage(ImageSource.gallery),
                child: Text("From Galley", style: TextStyle(fontSize: 20, color: kPrimaryColor),),
              ),
              SimpleDialogOption(
                onPressed: () => pickImage(ImageSource.camera),
                child: Text("From Camera", style: TextStyle(fontSize: 20, color: kPrimaryColor),),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel", style: TextStyle(fontSize: 20, color: kPrimaryColor),),
              ),
            ],
          );
        }
    );
  }

  uploadImage() async{
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    //store image
    UploadTask storage = profilePics.child(firebaseUser.email).putFile(imagePath);

    //complete image
    TaskSnapshot storageTaskSnapshot = await storage;

    //download pic
    String downloadPic = await storageTaskSnapshot.ref.getDownloadURL();

    return downloadPic;
  }

  @override
  void initState(){
    super.initState();
    getStream();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: SafeArea(
          child: StreamBuilder(
            stream: myStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData){
                return CircularProgressIndicator();
              }
              return Stack(
                children: [
                  Positioned(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                               snapshot.data['profilePic'],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                          ),
                        ),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: ()=>Navigator.pop(context),
                          child: Icon(CupertinoIcons.back,color: Colors.white,size: 32.0,
                          ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      // padding: EdgeInsets.all(100.0),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 1.4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: <Color>[
                              Color(0xFF0F427C),
                              Color(0xDF1dc4d8),
                            ]),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(top: 60.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${snapshot.data['first name']} ${snapshot.data['last name']}',
                                  style: TextStyle(
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(3.0, 3.0),
                                        blurRadius: 3.0,
                                        color: Colors.grey[900],
                                      ),
                                      Shadow(
                                        offset: Offset(5.0, 5.0),
                                        blurRadius: 10.0,
                                        color: Colors.black12,
                                      ),
                                    ],
                                      fontSize: 30.0,
                                      color: Colors.grey[100]
                                  ),
                                ),
                              ],
                            ),
                            ProfileCard(title: snapshot.data['email'],icon: Icons.email,),
                            ProfileCard(title: snapshot.data['mobile number'],icon: Icons.phone,),
                            ProfileCard(title: snapshot.data['roll number'],icon: FontAwesomeIcons.university,),
                            ProfileCard(title: '${snapshot.data['department']}-${snapshot.data['semester']}',icon: FontAwesomeIcons.userGraduate,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.10,
                    left: MediaQuery.of(context).size.width * 0.46,
                    // alignment: Alignment.bottomRight,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: FlareActor('assets/penguin_nodding.flr',
                        alignment: Alignment.center,
                        fit: BoxFit.fill,
                        animation: 'music_walk',
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(4.0, 4.0),
                                blurRadius: 15.0,
                                spreadRadius: 1.0),
                          ],
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.35,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Stack(
                            children: [
                              ClipOval(
                                  child: Image.network(
                                    snapshot.data['profilePic'] == null
                                    ? 'https://www.pngkit.com/png/full/72-729613_icons-logos-emojis-user-icon-png-transparent.png'
                                    : snapshot.data['profilePic'],
                                    height: MediaQuery.of(context).size.width * 0.35,
                                    width: MediaQuery.of(context).size.width * 0.35,
                                    fit: BoxFit.cover,
                                  ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  pickImageDialog();
                                },
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blueGrey[600],
                                    radius: MediaQuery.of(context).size.width * 0.05,
                                    child: Icon(
                                      CupertinoIcons.pen,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width * 0.05,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const ProfileCard({Key key,this.title,this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            topRight: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        elevation: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(width: MediaQuery.of(context).size.width * 0.15, child: Icon(icon)),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title ,
                    maxLines: 2,
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05,),
                  ),
                )
            ),
          ],
        ),
        color: Colors.white,
      ),
    );
  }
}