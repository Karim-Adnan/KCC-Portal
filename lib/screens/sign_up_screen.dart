import 'package:demo/components/already_have_an_account_check.dart';
import 'package:demo/components/rounded_button.dart';
import 'package:demo/components/rounded_input_field.dart';
import 'package:demo/components/rounded_password_field.dart';
import 'package:demo/screens/role_selection_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool showSpinner= false;


  registerUser() async{
    setState(() {
      showSpinner=true;
    });

    try{
      print("email and password=${emailController.text.trim()} and ${passwordController.text.trim()}");
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text);
      Navigator.push(context, MaterialPageRoute(builder: (context) => RoleSelection(currentUserPassword: passwordController.text,)));
      setState(() {
        showSpinner=false;
      });
    }catch(e){
      if (e.code == 'weak-password') {
        SnackBar snackbar = SnackBar(content: Text("The password provided is too weak."));
        scaffoldKey.currentState.showSnackBar(snackbar);
        setState(() {
          showSpinner=false;
        });
      } else if (e.code == 'email-already-in-use') {
        SnackBar snackbar = SnackBar(content: Text("The account already exists for this username."));
        scaffoldKey.currentState.showSnackBar(snackbar);
        setState(() {
          showSpinner=false;
        });
      }else{
        SnackBar snackbar = SnackBar(content: Text(e.toString()));
        scaffoldKey.currentState.showSnackBar(snackbar);
        setState(() {
          showSpinner=false;
        });
      }
    }
  }


    @override
    Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          height: size.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/signup_top.png",
                  width: size.width * 0.35,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_bottom.png",
                  width: size.width * 0.25,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "SIGNUP",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Image.asset(
                      "assets/images/signup_page.png",
                      height: size.height * 0.35,
                    ),
                    RoundedInputField(
                      controller: emailController,
                      hintText: "Email",
                      inputType: TextInputType.emailAddress,
                      icon: Icons.email,
                      onChanged: (value) {},
                    ),
                    RoundedPasswordField(
                      controller: passwordController,
                      hintText: "Password",
                      onChanged: (value) {},
                    ),
                    RoundedPasswordField(
                      controller: confirmPasswordController,
                      hintText: "Confirm Password",
                      onChanged: (value) {},
                    ),
                    SizedBox(height: size.height * 0.03),
                    RoundedButton(
                      text: "SIGNUP",
                      press: () {
                        if(emailController.text.isEmpty){
                          SnackBar snackbar = SnackBar(content: Text("Email cannot be empty"));
                          scaffoldKey.currentState.showSnackBar(snackbar);
                        }else if(passwordController.text != confirmPasswordController.text){
                          SnackBar snackbar = SnackBar(content: Text("Both passwords should match"));
                          scaffoldKey.currentState.showSnackBar(snackbar);
                        }else if(passwordController.text.isEmpty || confirmPasswordController.text.isEmpty){
                          SnackBar snackbar = SnackBar(content: Text("The password cannot be empty"));
                          scaffoldKey.currentState.showSnackBar(snackbar);
                        }else if(passwordController.text.length<6){
                          SnackBar snackbar = SnackBar(content: Text("The password should atleast be of 6 characters"));
                          scaffoldKey.currentState.showSnackBar(snackbar);
                        }else{
                          registerUser();
                        }
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
        ),
     ),
      ),
    );
  }
}