import 'package:flutter/material.dart';
import 'package:siopa/utils/colors.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(color: xWhite, fontSize: 24),
    );
  }
}

class AppBarbackButton extends StatelessWidget {
  const AppBarbackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: xWhite,
        ));
  }
}
