import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  Color backgroundColor;
  String text;
  VoidCallback interactTimer;
  ToggleButton(
      {Key? key,
      required this.backgroundColor,
      required this.text,
      required this.interactTimer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          interactTimer();
        },
        style: ElevatedButton.styleFrom(
            minimumSize: Size(145, 50), primary: backgroundColor),
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
