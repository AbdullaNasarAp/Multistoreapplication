import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/cart.dart';
import 'package:siopa/app/controller/costumer_control/wishlist.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/app_bar.dart';
import 'package:siopa/app/widget/wishlist_widget.dart';

class Wishlist extends StatelessWidget {
  Wishlist({
    super.key,
  });

  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
          backgroundColor: xWhite,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: xBlue,
            title: const AppBarTitle(title: "Wishlist"),
            leading: const AppBarbackButton(),
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
          body: context.watch<WishListProvider>().getWishItems.isNotEmpty
              ? WishlistItem(scaffoldKey: scaffoldKey)
              : const EmptyWidget()),
    );
  }

  Future<dynamic> myAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: xBlack,
        title: const Text(
          "Clear Wishlist",
          style: TextStyle(color: xWhite),
        ),
        content: const Text(
          "Are you sure to  clear Wishlist",
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
              context.read<WishListProvider>().clearIWishtems();
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
