import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_application/components/rounded_button.dart';
import 'package:messenger_application/constants.dart';
import 'chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool spinner = false;
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  //do something with it
                  email = value;
                },
                decoration: KMaterialButtonStyle.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration: KMaterialButtonStyle.copyWith(
                    hintText: 'Enter your Password',
                  )),
              SizedBox(
                height: 24.0,
              ),
              Material_Button(
                text: 'Login In',
                color: Colors.lightBlueAccent,
                onpressed: () async {
                  setState(() {
                    spinner = true;
                  });
                  try {
                    final exuser = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (exuser != Null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                      setState(() {
                        spinner = false;
                      });
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
