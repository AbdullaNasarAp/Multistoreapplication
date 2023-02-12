import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/cart.dart';
import 'package:siopa/app/screen/minor_screen.dart/place_order.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/app_bar.dart';
import 'package:siopa/app/widget/cart_widget.dart';

class CartScreen extends StatelessWidget {
  final Widget? back;
  CartScreen({super.key, this.back});

  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    final double total = context.watch<CartProvider>().totalPrice;
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        backgroundColor: xWhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: xBlue,
          title: const AppBarTitle(title: "Cart"),
          leading: back,
          iconTheme: const IconThemeData(color: xWhite),
          actions: [
            context.watch<CartProvider>().getItems.isEmpty
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      myAlert(context);
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: xWhite,
                    ),
                  )
          ],
        ),
        body: context.watch<CartProvider>().getItems.isNotEmpty
            ? CartItem(scaffoldKey: scaffoldKey)
            : const EmptyWidget(),
        bottomSheet: Container(
          color: xWhite,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "Total ₹",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      total.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
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
                  onPressed: total == 0.0
                      ? null
                      : () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const PlaceOrderScreen(),
                            ),
                          );
                        },
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
      ),
    );
  }

  Future<dynamic> myAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: xBlack,
        title: const Text(
          "Clear Cart",
          style: TextStyle(color: xWhite),
        ),
        content: const Text(
          "Are you sure to  clear Cart",
          style: TextStyle(color: xWhite),
        ),
        actions: [
          OutlinedButton(
            style:
                ButtonStyle(backgroundColor: MaterialStateProperty.all(xBlue)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "No",
              style: TextStyle(color: xWhite),
            ),
          ),
          OutlinedButton(
            style:
                ButtonStyle(backgroundColor: MaterialStateProperty.all(xBlue)),
            onPressed: () {
              context.read<CartProvider>().clearItems();
              Navigator.of(context).pop();
            },
            child: const Text(
              "Yes",
              style: TextStyle(color: xWhite),
            ),
          ),
        ],
      ),
    );
  }
}
