import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/cart.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/sub_screen/order/order.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/sub_screen/wishlist.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/app_bar.dart';

class CartOrderWish extends StatelessWidget {
  const CartOrderWish({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 80,
      decoration: BoxDecoration(
        color: xBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 60,
            width: MediaQuery.of(context).size.height * .13,
            decoration: const BoxDecoration(
              color: xBlack87,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      CartScreen(back: const AppBarbackButton()),
                ));
              },
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.height * 0.12,
                child: const Center(
                    child: Text(
                  "Cart",
                  style: TextStyle(
                      color: xWhite, fontSize: 17, fontFamily: "Poppins"),
                )),
              ),
            ),
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.height * .13,
            decoration: const BoxDecoration(
              color: xBlack87,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const OrderScreen(),
                ));
              },
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.height * 0.12,
                child: const Center(
                    child: Text(
                  "Order",
                  style: TextStyle(
                      color: xWhite, fontSize: 17, fontFamily: "Poppins"),
                )),
              ),
            ),
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.height * .13,
            decoration: const BoxDecoration(
              color: xBlack87,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Wishlist(),
                ));
              },
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.height * 0.12,
                child: const Center(
                    child: Text(
                  "Wishlist",
                  style: TextStyle(
                      color: xWhite, fontSize: 17, fontFamily: "Poppins"),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
