import 'package:flutter/material.dart';
import 'package:messenger_application/constants.dart';

class Material_Button extends StatelessWidget {
  Material_Button(
      {required this.onpressed, required this.text, required this.color});
  late VoidCallback onpressed;
  late String text;
  late Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onpressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: KWhiteStyle,
          ),
        ),
      ),
    );
  }
}
