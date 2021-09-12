import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messenger_application/constants.dart';
import 'welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String message;
  late final currentuser;
  late User loggedinuser;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  void getcurrent_user() async {
    try {
      currentuser = await _auth.currentUser;
      if (currentuser != Null) {
        loggedinuser = currentuser;
        print(loggedinuser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getmessages() async {
  //   var data = await _firestore.collection('messages').get();
  //   for (var message in data.docs) {
  //     print(message.data());
  //   }
  // }
  void getsnapshots() async {
    await for (var snapshots in _firestore.collection('messages').snapshots()) {
      for (var snapshot in snapshots.docs) {
        print(snapshot.data());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getcurrent_user();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                getsnapshots();
                //Implement logout functionality\
                // try {
                //   final logoutuser = await _auth.signOut();
                //   Navigator.popAndPushNamed(context, WelcomeScreen.id);
                // } catch (e) {
                //   print(e);
                // }
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      _firestore.collection('messages').add(
                        {'text': message, 'sender': loggedinuser.email},
                      );
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
