import 'package:demo/components/drop_down_menu.dart';
import 'package:demo/components/rounded_button.dart';
import 'file:///D:/AndroidProjects/KCC-Portal/lib/components/auth_components/rounded_input_field.dart';
import 'package:demo/models/list_item.dart';
import 'package:demo/models/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteProfile extends StatefulWidget {
  final String role;
  final String currentUserPassword;
  CompleteProfile({@required this.role,@required this.currentUserPassword});

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var rollNoController = TextEditingController();
  var mobileController = TextEditingController();
  String department, year, sem;
  bool showSpinner= false;

  setPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("initScreen", 1);
  }

  storeData() async{
    setState(() {
      showSpinner=true;
    });

    try{
      var firebaseUser = await FirebaseAuth.instance.currentUser;
       widget.role == "student"
          ? await UserDetails(
          email: firebaseUser.email,
          password: widget.currentUserPassword,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          role: widget.role,
          rollNo: rollNoController.text,
          mobile: mobileController.text,
          department: department,
          year: year,
          semester: sem
      ).storeUser()
      : await UserDetails(
          email: firebaseUser.email,
          password: widget.currentUserPassword,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          role: widget.role,
          mobile: mobileController.text,
          department: department,
      ).storeUser();

       setPreference();

      Navigator.pop(context);
      Navigator.pop(context);

      setState(() {
        showSpinner=false;
      });
    }catch(e){
      SnackBar snackbar = SnackBar(content: Text(e.toString()));
      scaffoldKey.currentState.showSnackBar(snackbar);
      setState(() {
        showSpinner=false;
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            height: size.height,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Please help us to complete your profile",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height * 0.03),
                      RoundedInputField(
                        controller: firstNameController,
                        hintText: "First Name",
                        onChanged: (value) {},
                      ),
                      RoundedInputField(
                        controller: lastNameController,
                        hintText: "Last Name",
                        onChanged: (value) {},
                      ),
                      widget.role == "student"
                          ? RoundedInputField(
                        controller: rollNoController,
                        hintText: "Roll Number",
                        inputType: TextInputType.number,
                        icon: Icons.confirmation_number,
                        onChanged: (value) {},
                      )
                      : Container(),
                      RoundedInputField(
                        controller: mobileController,
                        hintText: "Mobile Number",
                        inputType: TextInputType.phone,
                        icon: Icons.phone_android,
                        onChanged: (value) {},
                      ),
                      DropDownMenu(
                        dropdownItems: [
                          ListItem(1, "CSE"),
                          ListItem(2, "IT"),
                          ListItem(3, "ME"),
                          ListItem(4, "EC"),
                          ListItem(5, "CE")
                        ],
                        onChanged: (item) {
                          setState(() {
                            department=item.name;
                          });
                        },
                        hint: "Select Department",
                      ),
                      widget.role == "student"
                          ? DropDownMenu(
                        dropdownItems: [
                          ListItem(1, "First Year"),
                          ListItem(2, "Second Year"),
                          ListItem(3, "Third Year"),
                          ListItem(4, "Fourth Year")
                        ],
                        onChanged: (item) {
                          setState(() {
                            year=item.name;
                          });
                        },
                        hint: "Select Year",
                      )
                      : Container(),
                      widget.role == "student"
                          ? DropDownMenu(
                        dropdownItems: [
                          ListItem(1, "1st Sem"),
                          ListItem(2, "2nd Sem"),
                          ListItem(3, "3rd Sem"),
                          ListItem(4, "4th Sem"),
                          ListItem(5, "5th Sem"),
                          ListItem(6, "6th Sem"),
                          ListItem(7, "7th Sem"),
                          ListItem(8, "8th Sem"),
                        ],
                        onChanged: (item) {
                          setState(() {
                            sem=item.name;
                          });
                        },
                        hint: "Select Semester",
                      )
                      : Container(),
                      SizedBox(height: size.height * 0.03),
                      RoundedButton(
                        text: "PROCEED",
                        press: () {
                          print("department=$department");
                          print("year=$year");
                          print("sem=$sem");
                          if(firstNameController.text.isEmpty){
                            SnackBar snackbar = SnackBar(content: Text("First Name cannot be empty"));
                            scaffoldKey.currentState.showSnackBar(snackbar);
                          }else if(lastNameController.text.isEmpty){
                            SnackBar snackbar = SnackBar(content: Text("Last Name cannot be empty"));
                            scaffoldKey.currentState.showSnackBar(snackbar);
                          }else if(rollNoController.text.isEmpty && widget.role=="student"){
                            SnackBar snackbar = SnackBar(content: Text("Roll Number cannot be empty"));
                            scaffoldKey.currentState.showSnackBar(snackbar);
                          }else if(mobileController.text.isEmpty){
                            SnackBar snackbar = SnackBar(content: Text("Mobile Number cannot be empty"));
                            scaffoldKey.currentState.showSnackBar(snackbar);
                          }else if(mobileController.text.length != 10){
                            SnackBar snackbar = SnackBar(content: Text("Enter a valid mobile number"));
                            scaffoldKey.currentState.showSnackBar(snackbar);
                          }else if(department==null){
                            SnackBar snackbar = SnackBar(content: Text("Please specify your Department"));
                            scaffoldKey.currentState.showSnackBar(snackbar);
                          }else if(year==null && widget.role=="student"){
                            SnackBar snackbar = SnackBar(content: Text("Please specify your Year"));
                            scaffoldKey.currentState.showSnackBar(snackbar);
                          }else if(sem==null && widget.role=="student"){
                            SnackBar snackbar = SnackBar(content: Text("Please specify your Semester"));
                            scaffoldKey.currentState.showSnackBar(snackbar);
                          }else{
                            storeData();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
