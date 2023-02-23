import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../screen/main_screens/costumer_screen/cart.dart';
import '../../screen/main_screens/costumer_screen/category.dart';
import '../../screen/main_screens/costumer_screen/home.dart';
import '../../screen/main_screens/costumer_screen/stores.dart';
import '../../screen/main_screens/costumer_screen/sub_screen/profile/profile.dart';

class CostumerHomeScreenProvider with ChangeNotifier {
  int selectedIndex = 0;
  final List<Widget> tabs = [
    const HomeScreen(),
    const CategoryScreen(),
    const StoresScreen(),
    CartScreen(),
    ProfileScreen(docId: FirebaseAuth.instance.currentUser!.uid),
  ];

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
