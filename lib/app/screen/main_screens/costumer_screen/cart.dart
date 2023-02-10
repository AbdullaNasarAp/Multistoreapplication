import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/bottum_nav.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/app_bar.dart';

class CartScreen extends StatelessWidget {
  final Widget? back;
  const CartScreen({super.key, this.back});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: xWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: xBlue,
        title: const AppBarTitle(title: "Cart"),
        leading: back,
        iconTheme: const IconThemeData(color: xWhite),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_forever,
              color: xWhite,
            ),
          )
        ],
      ),
      body: Container(
        color: xWhite,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Your Cart is Empyt",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              MaterialButton(
                color: xBlue,
                minWidth: MediaQuery.of(context).size.width * 0.6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const CostumerHomeScreen(),
                  ));
                },
                child: const Text(
                  "Continue Shopping",
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Poppins", color: xWhite),
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: xWhite,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Text(
                    "Total \$",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "00.00",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: xGreen,
                    ),
                  ),
                ],
              ),
              MaterialButton(
                color: xBlue,
                minWidth: MediaQuery.of(context).size.width * 0.3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: () {},
                child: const Text(
                  "CHECK OUT",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: xWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
