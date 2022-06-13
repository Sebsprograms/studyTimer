import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final Color backgroundColor;
  final String text;
  final VoidCallback interactTimer;
  const ToggleButton(
      {Key? key,
      required this.backgroundColor,
      required this.text,
      required this.interactTimer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          interactTimer();
        },
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(145, 50), primary: backgroundColor),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
