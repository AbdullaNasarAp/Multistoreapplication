import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  String searchInput = '';
  void searchNotifier(String value) {
    searchInput = value;
    notifyListeners();
  }
}
