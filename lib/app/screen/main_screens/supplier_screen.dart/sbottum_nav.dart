import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/category.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/stores.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/dashboard.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/uploads.dart';
import 'package:siopa/app/utils/colors.dart';

class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({super.key});

  @override
  State<SupplierHomeScreen> createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  int selectedIndex = 0;
  final List<Widget> tabs = [
    const DashboardScreen(),
    const CategoryScreen(),
    const StoresScreen(),
    UploadsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('deliverystatus', isEqualTo: 'preparing')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(
              child: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          body: tabs[selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            selectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: xBlack87,
            unselectedItemColor: xWhite,
            currentIndex: selectedIndex,
            items: [
              BottomNavigationBarItem(
                icon: Badge(
                    isLabelVisible: snapshot.data!.docs.isEmpty ? false : true,
                    largeSize: 20,
                    label: Text(snapshot.data!.docs.length.toString()),
                    child: const Icon(Icons.dashboard)),
                label: "Dashboard",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Category",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.shop),
                label: "Stores",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.upload),
                label: "Upload",
              ),
            ],
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}
