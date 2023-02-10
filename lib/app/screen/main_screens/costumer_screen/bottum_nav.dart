import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/cart.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/category.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/home.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/profile.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/stores.dart';
import 'package:siopa/app/utils/colors.dart';

class CostumerHomeScreen extends StatefulWidget {
  const CostumerHomeScreen({super.key});

  @override
  State<CostumerHomeScreen> createState() => _CostumerHomeScreenState();
}

class _CostumerHomeScreenState extends State<CostumerHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = [
    const HomeScreen(),
    CategoryScreen(),
    const StoresScreen(),
    const CartScreen(),
    ProfileScreen(docId: FirebaseAuth.instance.currentUser!.uid),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: xBlack87,
        elevation: 0,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: xGreen,
        unselectedItemColor: xBlue,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: "Stores",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
