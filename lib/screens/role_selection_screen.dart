import 'package:demo/components/role_selection_card.dart';
import 'package:demo/screens/complete_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoleSelection extends StatefulWidget {
  final String currentUserPassword;
  const RoleSelection({Key key, this.currentUserPassword}) : super(key: key);

  @override
  _RoleSelectionState createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {

  @override
  void initState() {
    super.initState();
    setPreference();
  }

  setPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("initScreen", 2);
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
         body: Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             RoleSelectionCard(
                 size: size,
                 label: "Teacher",
                 image: 'teacher.png',
               onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteProfile(role: "teacher", currentUserPassword: widget.currentUserPassword,))),
             ),
             RoleSelectionCard(
                 size: size,
                 label: "Student",
                 image: 'student.jpg',
                 onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteProfile(role: "student", currentUserPassword: widget.currentUserPassword,))),
             ),
          ],
        ),
      ),
    );
  }
}
