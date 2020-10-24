import 'package:demo/components/already_have_an_account_check.dart';
import 'package:demo/components/rounded_button.dart';
import 'package:demo/components/rounded_input_field.dart';
import 'package:demo/components/rounded_password_field.dart';
import 'package:demo/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool showSpinner= false;

  signIn() async{
    setState(() {
      showSpinner=true;
    });
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text.trim(),
          password: passwordController.text.trim());
      Navigator.pop(context);
      setState(() {
        showSpinner=false;
      });
    }catch (e) {
      if (e.code == 'user-not-found') {
        SnackBar snackbar = SnackBar(content: Text('No user found for that email.'));
        scaffoldKey.currentState.showSnackBar(snackbar);
        setState(() {
          showSpinner=false;
        });
      } else if (e.code == 'wrong-password') {
        SnackBar snackbar = SnackBar(content: Text('Incorrect password'));
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
            width: double.infinity,
            height: size.height,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    "assets/images/main_top.png",
                    width: size.width * 0.35,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/images/login_bottom.png",
                    width: size.width * 0.4,
                  ),
                ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "LOGIN",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Image.asset(
                      "assets/images/login_page.png",
                      height: size.height * 0.35,
                    ),
                    SizedBox(height: size.height * 0.03),
                    RoundedInputField(
                      controller: usernameController,
                      hintText: "Email",
                      inputType: TextInputType.emailAddress,
                      onChanged: (value) {},
                    ),
                    RoundedPasswordField(
                      hintText: "Password",
                      controller: passwordController,
                      onChanged: (value) {},
                    ),
                    RoundedButton(
                      text: "LOGIN",
                      press: () {
                        if(usernameController.text.isEmpty){
                          SnackBar snackbar = SnackBar(content: Text("The username cannot be null"));
                          scaffoldKey.currentState.showSnackBar(snackbar);
                        }else if(passwordController.text.isEmpty){
                          SnackBar snackbar = SnackBar(content: Text("The password cannot be null"));
                          scaffoldKey.currentState.showSnackBar(snackbar);
                        }else{
                          signIn();
                        }
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      press: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpScreen();
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
        )
      ),
    );
  }
}