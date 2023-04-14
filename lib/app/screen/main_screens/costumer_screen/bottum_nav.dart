import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/b_nav.dart';
import 'package:siopa/app/controller/costumer_control/cart.dart';
import 'package:siopa/app/utils/colors.dart';

class CostumerHomeScreen extends StatelessWidget {
  const CostumerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CostumerHomeScreenProvider>(
      builder: (context, cHSP, child) {
        return Scaffold(
          body: cHSP.tabs[cHSP.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: xBlue,
            elevation: 0,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: xBlack87,
            unselectedItemColor: xWhite,
            currentIndex: cHSP.selectedIndex,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Category",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.shop),
                label: "Stores",
              ),
              BottomNavigationBarItem(
                icon: Badge(
                    isLabelVisible:
                        context.watch<CartProvider>().getItems.isEmpty
                            ? false
                            : true,
                    label: Text(context
                        .watch<CartProvider>()
                        .getItems
                        .length
                        .toString()),
                    child: const Icon(Icons.shopping_cart)),
                label: "Cart",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
            onTap: (index) {
              cHSP.changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
