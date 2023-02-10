import 'package:flutter/material.dart';

class VisitorStore with ChangeNotifier {
  bool follow = false;

  void followunfollowStore() {
    follow = !follow;
    notifyListeners();
  }
}
