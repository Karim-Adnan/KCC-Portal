import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../database.dart';

class UserDetails{

  String email;
  String password;
  String firstName;
  String lastName;
  String role;
  String rollNo;
  String mobile;
  String department;
  String year;
  String semester;

  UserDetails({this.email, this.password, this.firstName, this.lastName, this.role, this.rollNo,this.mobile,this.department,this.year,this.semester});


  Future storeUser() async{

    role == 'student'
       ? await userCollection.doc(email).set({
      'email': email,
      'password': password,
      'first name': firstName,
      'last name': lastName,
      'role': role,
      'roll number': rollNo,
      'mobile number': mobile,
      'department': department,
      'year': year,
      'semester': semester
    })
    : await userCollection.doc(email).set({
      'email': email,
      'password': password,
      'first name': firstName,
      'last name': lastName,
      'role': role,
      'mobile number': mobile,
      'department': department,
    });

  }



}