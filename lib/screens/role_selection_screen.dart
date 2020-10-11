import 'package:demo/components/role_selection_card.dart';
import 'package:demo/screens/complete_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoleSelection extends StatelessWidget {

  final String currentUserPassword;

  const RoleSelection({Key key, this.currentUserPassword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
       body: Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           RoleSelectionCard(
               size: size,
               label: "Teacher",
               image: 'teacher.png',
             onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteProfile(role: "teacher", currentUserPassword: currentUserPassword,))),
           ),
           RoleSelectionCard(
               size: size,
               label: "Student",
               image: 'student.jpg',
               onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteProfile(role: "student", currentUserPassword: currentUserPassword,))),
           ),
        ],
      ),
    );
  }
}
