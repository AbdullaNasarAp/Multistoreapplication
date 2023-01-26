import 'package:flutter/material.dart';
import 'package:siopa/utils/colors.dart';

extension EmailValidator on String {
  bool isEmailValidate() {
    return RegExp(
            r'^([a-zA-Z0-9]+)([\-\_\.]*)([a-zA-Z0-9]*)([@])([a-zA-Z0-9]{2,})([\.][a-zA-z]{2,4})$')
        .hasMatch(this);
  }
}

class MyMessengerHelper {
  static void showSnackBar(var scaffoldKey, String messege) {
    scaffoldKey.currentState!.hideCurrentSnackBar();
    scaffoldKey.currentState!.showSnackBar(SnackBar(
        backgroundColor: xBlue,
        dismissDirection: DismissDirection.startToEnd,
        duration: const Duration(milliseconds: 800),
        content: Text(messege)));
  }
}
