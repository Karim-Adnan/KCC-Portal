import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
StorageReference profilePics = FirebaseStorage.instance.ref().child('profilePic');
CollectionReference postCollection = FirebaseFirestore.instance.collection('posts');
