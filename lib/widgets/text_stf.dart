import 'package:flutter/material.dart';

class TextStf extends StatefulWidget {
  final String text;
  const TextStf({super.key, required this.text});

  @override
  State<TextStf> createState() => TextStfState();
}

class TextStfState extends State<TextStf> {
  String displayText = "";

  @override
  void initState() {
    super.initState();
    displayText = widget.text;
  }

  void updateText(String newText) {
    setState(() {
      displayText = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      displayText,
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
