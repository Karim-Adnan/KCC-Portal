import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
StorageReference profilePics = FirebaseStorage.instance.ref().child('profilePic');
CollectionReference postCollection = FirebaseFirestore.instance.collection('posts');

String exampleImage = "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-photo-183042379.jpg";
