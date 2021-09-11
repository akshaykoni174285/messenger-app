import 'package:flutter/material.dart';
import 'package:messenger_application/screens/login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:messenger_application/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = ColorTween(begin: Color(0xFF4C566A), end: Color(0xFF81A1C1))
        .animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {
        // print(animation.value);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                AnimatedTextKit(
                  totalRepeatCount: 1,
                  repeatForever: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      speed: Duration(milliseconds: 400),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 45,
                        color: Color(0xFFECEFF4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Material_Button(
              onpressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              text: 'Login In',
              color: Colors.lightBlueAccent,
            ),
            Material_Button(
              onpressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              text: 'Register',
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
