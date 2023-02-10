import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/category.dart';

class CategoryProvider with ChangeNotifier {
  final PageController pageController = PageController();

  List<ItemsData> items = [
    ItemsData(label: "Men"),
    ItemsData(label: "Women"),
    ItemsData(label: "Shoes"),
    ItemsData(label: "Bags"),
    ItemsData(label: "Electronics"),
    ItemsData(label: "Accessories"),
    ItemsData(label: "Home & Garden"),
    ItemsData(label: "Kids"),
    ItemsData(label: "Beauty"),
  ];
  void initValueGetting() {
    for (var element in items) {
      element.isSelected = false;
    }

    items[0].isSelected = true;
    notifyListeners();
  }

  void changeItem(int value) {
    for (var element in items) {
      element.isSelected = false;
    }

    items[value].isSelected = true;
    notifyListeners();
  }
}
