import 'package:flutter/material.dart';

class FullScreenProvider with ChangeNotifier {
  int selectedImage = 0;

  void taptap(int index) {
    selectedImage = index;
    notifyListeners();
  }
}
