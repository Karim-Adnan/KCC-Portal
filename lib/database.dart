import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
Reference profilePics = FirebaseStorage.instance.ref().child('profilePic');
CollectionReference postCollection = FirebaseFirestore.instance.collection('posts');
Reference attachments = FirebaseStorage.instance.ref().child('attachments');

String exampleImage = "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-photo-183042379.jpg";
