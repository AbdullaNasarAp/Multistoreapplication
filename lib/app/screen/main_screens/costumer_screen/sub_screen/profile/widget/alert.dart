import 'package:flutter/material.dart';
import '../../../../../../utils/colors.dart';

class Alert extends StatelessWidget {
  const Alert({
    super.key,
    required this.title,
    required this.content,
    required this.onpress,
  });
  final String title;
  final String content;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: xBlack,
      title: Text(
        title,
        style: const TextStyle(color: xWhite),
      ),
      content: Text(
        content,
        style: const TextStyle(color: xWhite),
      ),
      actions: [
        OutlinedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(xBlue)),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "No",
            style: TextStyle(color: xWhite),
          ),
        ),
        OutlinedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(xBlue)),
          onPressed: onpress,
          child: const Text(
            "Yes",
            style: TextStyle(color: xWhite),
          ),
        ),
      ],
    );
  }
}
