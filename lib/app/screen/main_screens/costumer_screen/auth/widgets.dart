import 'package:flutter/material.dart';
import 'package:siopa/app/utils/colors.dart';

class MyMessengerHelper {
  static void showSnackBar(var scaffoldKey, String messege) {
    scaffoldKey.currentState?.hideCurrentSnackBar();
    scaffoldKey.currentState?.showSnackBar(SnackBar(
        backgroundColor: xBlue,
        dismissDirection: DismissDirection.startToEnd,
        duration: const Duration(milliseconds: 800),
        content: Text(messege)));
  }
}
