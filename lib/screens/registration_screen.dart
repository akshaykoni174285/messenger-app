import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:messenger_application/components/rounded_button.dart';
import 'package:messenger_application/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration: KMaterialButtonStyle.copyWith(
                    hintText: 'Enter your email')),
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
                    hintText: 'Enter your Password')),
            SizedBox(
              height: 24.0,
            ),
            Material_Button(
              text: 'Register',
              color: Colors.blueAccent,
              onpressed: () async {
                try {
                  print('email : $email and password : $password');
                  final newuser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if (newuser != Null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                } catch (e) {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
